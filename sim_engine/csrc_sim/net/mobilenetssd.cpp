// Tencent is pleased to support the open source community by making ncnn available.
//
// Copyright (C) 2017 THL A29 Limited, a Tencent company. All rights reserved.
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
struct Object
{
    cv::Rect_<float> rect;
    int label;
    float prob;
};

static int detect_mobilenet(const cv::Mat& bgr, std::vector<Object>& objects)
{
    ncnn::Net mobilenet;

    mobilenet.opt.use_vulkan_compute = false;
    mobilenet.opt.use_int8_inference = true;

    // model is converted from https://github.com/chuanqi305/MobileNet-SSD
    // and can be downloaded from https://drive.google.com/open?id=0ByaKLD9QaPtucWk0Y0dha1VVY0U
    // the ncnn model https://github.com/nihui/ncnn-assets/tree/master/models
    // if (mobilenet.load_param("/SSD/cq/Compute-in-memory/simulation_sin_cos_1022/models/mobilenet_ssd_voc_ncnn.param"))
    if (mobilenet.load_param("models/mobilenetssd/mobilenet_ssd_voc_ncnn-opt-int8.param"))
        exit(-1);
    // if (mobilenet.load_model("/SSD/cq/Compute-in-memory/simulation_sin_cos_1022/models/mobilenet_ssd_voc_ncnn.bin"))
    if (mobilenet.load_model("models/mobilenetssd/mobilenet_ssd_voc_ncnn-opt-int8.bin"))
        exit(-1);

    const int target_size = 300;

    int img_w = bgr.cols;
    int img_h = bgr.rows;

    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR, bgr.cols, bgr.rows, target_size, target_size);
    printf("[ log ]: in[0] = %d, in[300] = %d\n", int(in[0]), int(in[300]));
    const float mean_vals[3] = {127.5f, 127.5f, 127.5f};
    const float norm_vals[3] = {1.0 / 127.5, 1.0 / 127.5, 1.0 / 127.5};
    in.substract_mean_normalize(mean_vals, norm_vals);

    ncnn::Extractor ex = mobilenet.create_extractor();

    ex.input("data", in);

    ncnn::Mat out;
    ex.extract("detection_out", out);

    //     printf("%d %d %d\n", out.w, out.h, out.c);
    objects.clear();
    for (int i = 0; i < out.h; i++)
    {
        const float* values = out.row(i);

        Object object;
        object.label = values[0];
        object.prob = values[1];
        object.rect.x = values[2] * img_w;
        object.rect.y = values[3] * img_h;
        object.rect.width = values[4] * img_w - object.rect.x;
        object.rect.height = values[5] * img_h - object.rect.y;

        objects.push_back(object);
    }

    return 0;
}

static void draw_objects(const cv::Mat& bgr, const std::vector<Object>& objects, int right_result, int image_index, int& is_top1)
{
    static const char* class_names[] = {"background",
                                        "aeroplane", "bicycle", "bird", "boat",
                                        "bottle", "bus", "car", "cat", "chair",
                                        "cow", "diningtable", "dog", "horse",
                                        "motorbike", "person", "pottedplant",
                                        "sheep", "sofa", "train", "tvmonitor"
                                       };

    cv::Mat image = bgr.clone();
    printf("\n******************MOBILENETSSD Inference Result*****************\n");
    for (size_t i = 0; i < objects.size(); i++)
    {
        const Object& obj = objects[i];

        fprintf(stderr, "%d = %.5f at %.2f %.2f %.2f x %.2f\n", obj.label, obj.prob,
                obj.rect.x, obj.rect.y, obj.rect.width, obj.rect.height);

        cv::rectangle(image, obj.rect, cv::Scalar(255, 0, 0));

        char text[256];
        sprintf(text, "%s %.1f%%", class_names[obj.label], obj.prob * 100);

        int baseLine = 0;
        cv::Size label_size = cv::getTextSize(text, cv::FONT_HERSHEY_SIMPLEX, 0.5, 1, &baseLine);

        int x = obj.rect.x;
        int y = obj.rect.y - label_size.height - baseLine;
        if (y < 0)
            y = 0;
        if (x + label_size.width > image.cols)
            x = image.cols - label_size.width;

        cv::rectangle(image, cv::Rect(cv::Point(x, y), cv::Size(label_size.width, label_size.height + baseLine)),
                      cv::Scalar(255, 255, 255), -1);

        cv::putText(image, text, cv::Point(x, y + label_size.height),
                    cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0, 0, 0));
    }

    // if (str(objects[0].label) == "im"):
        // print("i=",i)
        // print("objects[0].label=",objects[0].label)
        // print("right_result=",right_result) 
        // is_top1 = 0;   
    printf("image_index= %d\n", image_index);
    if (objects.size() == 0){
        is_top1 = 0;
    } 
    else if (objects[0].label == (right_result + 1)){
        is_top1 = 1;
    }
    else{
        printf("objects[0].label=%d\n",objects[0].label);
        printf("right_result=%d\n",right_result);
        is_top1 = 0;
    }

    #ifdef FORWARD_ON_CPU
        cv::imshow("image_mobilenetssd-CPU", image);
    #endif
    #ifdef FORWARD_ON_CIM
        cv::imshow("image_mobilenetssd-NPU", image);
    #endif 
    cv::waitKey(0);
}

int mobilenetssd_inference()
{
    printf("This is a mobilenetssd inference\n");
    time_t start_time, end_time;
    double execution_time;
    start_time = time(NULL);    

    //读取label文档
    FILE *file_label;    

    // 打开文件
    file_label = fopen(LABELFILE_PATH_MOBILENETSSD, "r");
    if (file_label == NULL) {
        printf("无法打开文件: %s\n", LABELFILE_PATH_MOBILENETSSD);
        return 1;
    }

    std::vector<int> label;
    std::vector<float> x;
    std::vector<float> y;
    std::vector<float> w;
    std::vector<float> h;

    char line[100];
    while (fgets(line, sizeof(line), file_label)) {
        int num_label;
        float num_x;
        float num_y;
        float num_w;
        float num_h;
        if (sscanf(line, "%d %f %f %f %f", &num_label, &num_x, &num_y, &num_w, &num_h) == 5) {
            label.push_back(num_label);
            x.push_back(num_x);
            y.push_back(num_y);
            w.push_back(num_w);
            h.push_back(num_h);
        }
    }
    // printf("label[0]=%d \n",label[0]);
    // printf("x[0]=%f \n",x[0]);
    // printf("y[0]=%f \n",y[0]);
    // printf("w[0]=%f \n",w[0]);
    // printf("h[0]=%f \n",h[0]);

    fclose(file_label);    

    FILE *file;
    char a[100];  // 假设每行的最大长度不超过100个字符
    file = fopen(IMAGEFILE_PATH_MOBILENETSSD, "r");
    if (file == NULL) {
        printf("无法打开文件: %s\n", IMAGEFILE_PATH_MOBILENETSSD);
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
            printf("[error]: cv::imread is failed\n");
            return -1;
        }
        printf("[ log ]: loaded image\n\n");

        std::vector<Object> objects;
        int right_result = label[image_index];
        detect_mobilenet(m, objects);
        int is_top1;
        draw_objects(m, objects, right_result, image_index, is_top1);

        printf("right_result = %d\n", right_result);        
        printf("is_top1 = %d\n", is_top1);         

        if (is_top1 == 1) {
            all_top1++;
        } else {
            all_top1 = all_top1;
        }     
        printf("all_top1 = %d\n", all_top1);        
        image_index++;    
    }

    fclose(file);
    printf("all_top1 = %d\n", all_top1);            
    float top1_acc = (float)all_top1/label.size();

    
    printf("TOP1 Accuracy is %f %\n", top1_acc*100);
    #ifdef FORWARD_ON_CPU
        printf("[ log ]: mobilenetssd-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: mobilenetssd-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif


    end_time = time(NULL);
    execution_time = difftime(end_time, start_time);
    // printf("程序执行时间: %.2f 秒\n", execution_time);
    return 0;
}
}