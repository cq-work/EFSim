// Tencent is pleased to support the open source community by making ncnn available.
//
// Copyright (C) 2018 THL A29 Limited, a Tencent company. All rights reserved.
//
// Licensed under the BSD 3-Clause License (the "License"); you may not use this file except
// in compliance with the License. You may obtain a copy of the License at
//
// https://opensource.org/licenses/BSD-3-Clause
//
// Unless required by applicable law or agreed to in writing, software distributed
// under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include "../ncnn/net.h"

#include "../ncnn/simpleocv.h"


#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <time.h>
#include "../config.h"
#include "Vtop.h"

namespace demo{
static int detect_shufflenetv2(const cv::Mat& bgr, std::vector<float>& cls_scores)
{
    ncnn::Net shufflenetv2;

    // shufflenetv2.opt.use_vulkan_compute = true;

    // https://github.com/miaow1988/ShuffleNet_V2_pytorch_caffe
    // models can be downloaded from https://github.com/miaow1988/ShuffleNet_V2_pytorch_caffe/releases
    if (shufflenetv2.load_param("/home/cqi/models/shuffleNetv2/shufflenet_v2_x0.5-opt-int8.param"))
    // if (shufflenetv2.load_param("/SSD/cq/Compute-in-memory/simulation_sin_cos_1022/models/shufflenet_v2_x0.5.param"))
        exit(-1);
    if (shufflenetv2.load_model("/home/cqi/models/shuffleNetv2/shufflenet_v2_x0.5-opt-int8.bin"))
    // if (shufflenetv2.load_model("/SSD/cq/Compute-in-memory/simulation_sin_cos_1022/models/shufflenet_v2_x0.5.bin"))
        exit(-1);

    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR, bgr.cols, bgr.rows, 224, 224);

    const float norm_vals[3] = {1 / 255.f, 1 / 255.f, 1 / 255.f};
    in.substract_mean_normalize(0, norm_vals);

    ncnn::Extractor ex = shufflenetv2.create_extractor();

    ex.input("data", in);

    ncnn::Mat out;
    ex.extract("fc", out);

    // manually call softmax on the fc output
    // convert result into probability
    // skip if your model already has softmax operation
    {
        ncnn::Layer* softmax = ncnn::create_layer("Softmax");

        ncnn::ParamDict pd;
        softmax->load_param(pd);

        softmax->forward_inplace(out, shufflenetv2.opt);

        delete softmax;
    }

    out = out.reshape(out.w * out.h * out.c);

    cls_scores.resize(out.w);
    for (int j = 0; j < out.w; j++)
    {
        cls_scores[j] = out[j];
    }

    return 0;
}

static int print_topk(const std::vector<float>& cls_scores, int topk, int right_result, int& is_top1, int& is_top5)
{
    // partial sort topk with index
    int size = cls_scores.size();
    std::vector<std::pair<float, int> > vec;
    vec.resize(size);
    for (int i = 0; i < size; i++)
    {
        vec[i] = std::make_pair(cls_scores[i], i);
    }

    std::partial_sort(vec.begin(), vec.begin() + topk, vec.end(),
                      std::greater<std::pair<float, int> >());

    // print topk and score
    printf("This is shufflenetv2 result\n");
    for (int i = 0; i < topk; i++)
    {
        float score = vec[i].first;
        int index = vec[i].second;
        fprintf(stderr, "%d = %f\n", index, score);
    }

    if (vec[0].second == right_result){
        is_top1 = 1;
    } else {
        is_top1 = 0;
    }
    if (vec[0].second == right_result || vec[1].second == right_result || vec[2].second == right_result || vec[3].second == right_result || vec[4].second == right_result){
        is_top5 = 1;
    } else {
        is_top5 = 0;
    }

    printf("is_top1 = %d\n", is_top1);        
    printf("is_top5 = %d\n", is_top5);    

    return 0;
}

int shufflenetv2_inference()
{
    printf("This is a shufflenetv2 inference\n");
    time_t start_time, end_time;
    double execution_time;
    start_time = time(NULL); 

    //读取label文档
    FILE *file_label;    

    // 打开文件
    file_label = fopen(LABELFILE_PATH_SHUFFLENETV2, "r");
    if (file_label == NULL) {
        printf("无法打开文件: %s\n", LABELFILE_PATH_SHUFFLENETV2);
        return 1;
    }

    std::vector<std::string> image_name;
    std::vector<int> label;

    char line[100];
    while (fgets(line, sizeof(line), file_label)) {
        char str[100];
        int num;
        if (sscanf(line, "%s %d", str, &num) == 2) {
            image_name.push_back(str);
            label.push_back(num);
        }
    }

    fclose(file_label);

    FILE *file;
    char a[100];  // 假设每行的最大长度不超过100个字符
    file = fopen(IMAGEFILE_PATH_SHUFFLENETV2, "r");
    if (file == NULL) {
        printf("无法打开文件: %s\n", IMAGEFILE_PATH_SHUFFLENETV2);
        return 1;
    }
    int image_index = 0;
    int all_top1 = 0;
    int all_top5 = 0;
    while (fgets(a, sizeof(a), file) != NULL) {
        printf("读取到的地址: %s\n", a);  // 在这里你可以使用 a 变量进行其他操作
        if (a[strlen(a) - 1] == '\n') {
            a[strlen(a) - 1] = '\0';
        }

        cv::Mat m = cv::imread(a, 1);
        if (m.empty())
        {
            fprintf(stderr, "cv::imread %s failed\n", IMAGE_PATH);
            return -1;
        }
        printf("[ log ]: loaded image\n\n");

        std::vector<float> cls_scores;
        int right_result = label[image_index];
        detect_shufflenetv2(m, cls_scores);
        int is_top1, is_top5;
        print_topk(cls_scores, 5, right_result, is_top1, is_top5);

        printf("right_result = %d\n", right_result);        
        printf("is_top1 = %d\n", is_top1);        
        printf("is_top5 = %d\n", is_top5);  

        if (is_top1 == 1) {
            all_top1++;
        } else {
            all_top1 = all_top1;
        }
        if (is_top5 == 1) {
            all_top5++;
        } else {
            all_top5 = all_top5;
        }       
        printf("all_top1 = %d\n", all_top1);        
        printf("all_top5 = %d\n", all_top5);    
        image_index++;    
    }

    fclose(file);
    printf("all_top1 = %d\n", all_top1);        
    printf("all_top5 = %d\n", all_top5);       
    float top1_acc = (float)all_top1/label.size();
    float top5_acc = (float)all_top5/label.size();

    
    printf("TOP1 Accuracy is %f %\n", top1_acc*100);
    printf("TOP5 Accuracy is %f %\n", top5_acc*100);
    #ifdef FORWARD_ON_CPU
        printf("shufflenetv2-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("shufflenetv2-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif

    end_time = time(NULL);
    execution_time = difftime(end_time, start_time);
    printf("程序执行时间: %.2f 秒\n", execution_time);
    return 0;
}
}