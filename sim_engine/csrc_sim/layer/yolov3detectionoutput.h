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

#ifndef LAYER_YOLOV3DETECTIONOUTPUT_H
#define LAYER_YOLOV3DETECTIONOUTPUT_H

#include "../ncnn/layer.h"

namespace ncnn {

class Yolov3DetectionOutput : public Layer
{
public:
    Yolov3DetectionOutput();
    ~Yolov3DetectionOutput();

    virtual int load_param(const ParamDict& pd);

    virtual int forward(const std::vector<Mat>& bottom_blobs, std::vector<Mat>& top_blobs, const Option& opt) const;

public:
    int num_class;
    int num_box;
    float confidence_threshold;
    float nms_threshold;
    Mat biases;
    Mat mask;
    Mat anchors_scale;
    int mask_group_num;
    ncnn::Layer* softmax;

public:
    struct BBoxRect
    {
        float score;
        float xmin;
        float ymin;
        float xmax;
        float ymax;
        float area;
        int label;
    };

    void qsort_descent_inplace(std::vector<BBoxRect>& datas, int left, int right) const;
    void qsort_descent_inplace(std::vector<BBoxRect>& datas) const;
    void nms_sorted_bboxes(std::vector<BBoxRect>& bboxes, std::vector<size_t>& picked, float nms_threshold) const;
};

} // namespace ncnn

#endif // LAYER_YOLODETECTIONOUTPUT_H
