// Tencent is pleased to support the open source community by making ncnn available.
//
// Copyright (C) 2020 THL A29 Limited, a Tencent company. All rights reserved.
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

#include "cnn_demo.h"
#include "../ncnn/net.h"
#include "../ncnn/simpleocv.h"
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include "../config.h"
#include "../veri.h"
#include "Vtop.h"


#define NCNN_PROFILING
#define YOLOV4_TINY //Using yolov4_tiny, if undef, using original yolov4

// #ifdef NCNN_PROFILING
// #include "benchmark.h"
// #endif
namespace demo {
struct Object
{
    cv::Rect_<float> rect;
    int label;
    float prob;
};



static int detect_yolov4(const cv::Mat& bgr, std::vector<Object>& objects)
{
    ncnn::Net yolov4;
    // int target_size = 160;
    yolov4.opt.use_vulkan_compute = false;
    yolov4.opt.use_int8_inference = true;

    #ifdef YOLOV4_TINY
        // if (yolov4.load_param_mem(yolov4.load_file2mem("/mnt/ssd1/zgm/ncnnAccel/simulation_prj/models/yolov4_tiny/yolov4_tiny_int8.param")))
        if (yolov4.load_param("models/yolov4_tiny/yolov4_tiny_int8.param"))
            exit(-1);
        // printf("finish param load \n");
        // if (yolov4.load_model_mem(yolov4.load_file2mem("/mnt/ssd1/zgm/ncnnAccel/simulation_prj/models/yolov4_tiny/yolov4_tiny_int8.bin")))
        if (yolov4.load_model("models/yolov4_tiny/yolov4_tiny_int8.bin"))
            exit(-1);
    
    #else
        if (yolov4.load_param_mem(yolov4.load_file2mem("models/yolov4/yolov4_int8.param")))
            exit(-1);
        if (yolov4.load_model_mem(yolov4.load_file2mem("models/yolov4/yolov4_int8.bin")))
            exit(-1);
        target_size = 608;
    #endif
    const int target_size = 416;

    int img_w = bgr.cols;
    int img_h = bgr.rows;

    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR2RGB, bgr.cols, bgr.rows, target_size, target_size);
    printf("[ log ]: in[0] = %d, in[416] = %d\n", int(in[0]), int(in[416]));
    const float mean_vals[3] = {0, 0, 0};
    const float norm_vals[3] = {1 / 255.f, 1 / 255.f, 1 / 255.f};
    in.substract_mean_normalize(mean_vals, norm_vals);

    ncnn::Extractor ex = yolov4.create_extractor();

    ex.input("data", in);

    ncnn::Mat out;
    ex.extract("output", out);

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

static int draw_objects(const cv::Mat& bgr, const std::vector<Object>& objects)
{
    static const char* class_names[] = {"background", "person", "bicycle",
                                        "car", "motorbike", "aeroplane", "bus", "train", "truck",
                                        "boat", "traffic light", "fire hydrant", "stop sign",
                                        "parking meter", "bench", "bird", "cat", "dog", "horse",
                                        "sheep", "cow", "elephant", "bear", "zebra", "giraffe",
                                        "backpack", "umbrella", "handbag", "tie", "suitcase",
                                        "frisbee", "skis", "snowboard", "sports ball", "kite",
                                        "baseball bat", "baseball glove", "skateboard", "surfboard",
                                        "tennis racket", "bottle", "wine glass", "cup", "fork",
                                        "knife", "spoon", "bowl", "banana", "apple", "sandwich",
                                        "orange", "broccoli", "carrot", "hot dog", "pizza", "donut",
                                        "cake", "chair", "sofa", "pottedplant", "bed", "diningtable",
                                        "toilet", "tvmonitor", "laptop", "mouse", "remote", "keyboard",
                                        "cell phone", "microwave", "oven", "toaster", "sink",
                                        "refrigerator", "book", "clock", "vase", "scissors",
                                        "teddy bear", "hair drier", "toothbrush"
                                       };

    cv::Mat image = bgr.clone();

    printf("\n******************YOLOv4-Tiny Inference Result*****************\n");
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

    #ifdef FORWARD_ON_CPU
        cv::imshow("image_yolov4_tiny-CPU", image);
    #endif
    #ifdef FORWARD_ON_CIM
        cv::imshow("image_yolov4_tiny-NPU", image);
    #endif
    // cv::imshow("image", image);

    return 0;
}


int yolov4_tiny_inference()
{
    printf("This is a yolov4_tiny inference!\n");

    cv::Mat m = cv::imread(IMAGE_PATH, 1);
    if (m.empty())
    {
        printf("[error]: cv::imread is failed\n");
        return -1;
    }
    printf("[ log ]: loaded image\n\n");
    std::vector<Object> objects;
    
    detect_yolov4(m, objects);

    draw_objects(m, objects);

    // double time_ms = (main_time/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // double time_pool_ms = (time_pool/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // double time_gemm_ms = (time_gemm/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // printf("[ log ]: FREQ = %dMHz, CYCLES = %ld, TIME = %.3fms, FPS = %.3f\n",HW_FREQ_MHZ,main_time/2,time_ms,1000.f/time_ms);
    // printf("[ log ]: POOL_TIME = %f, %.5f%%\n", time_pool_ms, time_pool_ms/time_ms*100.f);
    // printf("[ log ]: GEMM_TIME = %f, %.5f%%\n", time_gemm_ms, time_gemm_ms/time_ms*100.f);
    #ifdef FORWARD_ON_CPU
        printf("[ log ]: YOLOv4_Tiny-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: YOLOv4_Tiny-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif

    return 0;
}
}