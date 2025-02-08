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

#include <algorithm>
#include <stdio.h>
#include <vector>
#include "../config.h"
#include "../veri.h"
namespace demo {
static int detect_googlenet(const cv::Mat& bgr, std::vector<float>& cls_scores)
{
    ncnn::Net googlenet;

    googlenet.opt.use_vulkan_compute = true;

    // if (googlenet.load_param_mem(googlenet.load_file2mem("models/googlenet/googlenet_opt.param")))
    //     exit(-1);
    // if (googlenet.load_model_mem(googlenet.load_file2mem("models/googlenet/googlenet_opt.bin")))
    //     exit(-1);

    if (googlenet.load_param("models/googlenet/googlenet_int8.param"))
        exit(-1);
    if (googlenet.load_model("models/googlenet/googlenet_int8.bin"))
        exit(-1);

    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR, bgr.cols, bgr.rows, 224, 224);

    const float mean_vals[3] = {104.f, 117.f, 123.f};
    in.substract_mean_normalize(mean_vals, 0);

    ncnn::Extractor ex = googlenet.create_extractor();
    ex.set_light_mode(true);

    ex.input("input", in);

    ncnn::Mat out;
    ex.extract("output", out);

    cls_scores.resize(out.w);
    for (int j = 0; j < out.w; j++)
    {
        cls_scores[j] = out[j];
    }

    return 0;
}

static int print_topk(const std::vector<float>& cls_scores, int topk)
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
    printf("\n******************GoogleNet Inference Result*****************\n");
    for (int i = 0; i < topk; i++)
    {
        float score = vec[i].first;
        int index = vec[i].second;
        fprintf(stderr, "%d = %f\n", index, score);
    }

    return 0;
}

int googlenet_inference()
{
    printf("This is a GoogleNet inference!\n");
    cv::Mat m = cv::imread(IMAGE_PATH, 1);
    if (m.empty())
    {
        printf("[error]: cv::imread is failed\n");
        return -1;
    }

    std::vector<float> cls_scores;
    detect_googlenet(m, cls_scores);

    print_topk(cls_scores, 3);

    // double time_ms = (main_time/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // double time_pool_ms = (time_pool/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // double time_gemm_ms = (time_gemm/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // printf("[ log ]: FREQ = %dMHz, CYCLES = %ld, TIME = %fms\n",HW_FREQ_MHZ,main_time/2,time_ms);
    // printf("[ log ]: POOL_TIME = %f, %.5f%%\n", time_pool_ms, time_pool_ms/time_ms*100.f);
    // printf("[ log ]: GEMM_TIME = %f, %.5f%%\n", time_gemm_ms, time_gemm_ms/time_ms*100.f);
     #ifdef FORWARD_ON_CPU
        printf("[ log ]: GoogleNet-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: GoogleNet-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif
    return 0;
}
}