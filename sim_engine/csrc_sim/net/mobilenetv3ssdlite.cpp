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

template<class T>
const T& clamp(const T& v, const T& lo, const T& hi)
{
    assert(!(hi < lo));
    return v < lo ? lo : hi < v ? hi : v;
}

struct Object
{
    cv::Rect_<float> rect;
    int label;
    float prob;
};

static int detect_mobilenetv3(const cv::Mat& bgr, std::vector<Object>& objects)
{
    ncnn::Net mobilenetv3;

// #if NCNN_VULKAN
//     mobilenetv3.opt.use_vulkan_compute = true;
// #endif // NCNN_VULKAN
    mobilenetv3.opt.use_vulkan_compute = false;
    mobilenetv3.opt.use_int8_inference = true;

    // converted ncnn model from https://github.com/ujsyehao/mobilenetv3-ssd
    if (mobilenetv3.load_param("/home/cqi/models/mobilenetv3ssdlite/mobilenetv3_ssdlite_voc.param"))
        exit(-1);
    if (mobilenetv3.load_model("/home/cqi/models/mobilenetv3ssdlite/mobilenetv3_ssdlite_voc.bin"))
        exit(-1);

    const int target_size = 300;

    int img_w = bgr.cols;
    int img_h = bgr.rows;

    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR2RGB, bgr.cols, bgr.rows, target_size, target_size);
    printf("[ log ]: in[0] = %d, in[300] = %d\n", int(in[0]), int(in[300]));
    const float mean_vals[3] = {123.675f, 116.28f, 103.53f};
    const float norm_vals[3] = {1.0f, 1.0f, 1.0f};
    in.substract_mean_normalize(mean_vals, norm_vals);

    ncnn::Extractor ex = mobilenetv3.create_extractor();

    ex.input("input", in);

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

        // filter out cross-boundary
        float x1 = clamp(values[2] * target_size, 0.f, float(target_size - 1)) / target_size * img_w;
        float y1 = clamp(values[3] * target_size, 0.f, float(target_size - 1)) / target_size * img_h;
        float x2 = clamp(values[4] * target_size, 0.f, float(target_size - 1)) / target_size * img_w;
        float y2 = clamp(values[5] * target_size, 0.f, float(target_size - 1)) / target_size * img_h;

        object.rect.x = x1;
        object.rect.y = y1;
        object.rect.width = x2 - x1;
        object.rect.height = y2 - y1;

        objects.push_back(object);
    }

    return 0;
}

static void draw_objects(const cv::Mat& bgr, const std::vector<Object>& objects)
{
    static const char* class_names[] = {"background",
                                        "aeroplane", "bicycle", "bird", "boat",
                                        "bottle", "bus", "car", "cat", "chair",
                                        "cow", "diningtable", "dog", "horse",
                                        "motorbike", "person", "pottedplant",
                                        "sheep", "sofa", "train", "tvmonitor"
                                       };

    cv::Mat image = bgr.clone();
    printf("\n******************MOBILENETV3SSD Inference Result*****************\n");
    for (size_t i = 0; i < objects.size(); i++)
    {
        if (objects[i].prob > 0.6)
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
    }

    #ifdef FORWARD_ON_CPU
        cv::imshow("image_mobilenetv3ssd-CPU", image);
    #endif
    #ifdef FORWARD_ON_CIM
        cv::imshow("image_mobilenetv3ssd-NPU", image);
    #endif
    cv::waitKey(0);
}

int mobilenetv3ssd_inference()
{
    printf("This is a mobilenetv3ssd inference\n");
    time_t start_time, end_time;
    double execution_time;
    start_time = time(NULL); 


    cv::Mat m = cv::imread(IMAGE_PATH, 1);
    if (m.empty())
    {
        printf("[error]: cv::imread is failed\n");
        return -1;
    }
    printf("[ log ]: loaded image\n\n");
    std::vector<Object> objects;
    detect_mobilenetv3(m, objects);

    draw_objects(m, objects);

    end_time = time(NULL);
    execution_time = difftime(end_time, start_time);
    // printf("程序执行时间: %.2f 秒\n", execution_time);

    #ifdef FORWARD_ON_CPU
        printf("[ log ]: mobilenetv2ssd-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: mobilenetv2ssd-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif    
    return 0;
}
}
