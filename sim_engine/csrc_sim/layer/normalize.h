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

#ifndef LAYER_NORMALIZE_H
#define LAYER_NORMALIZE_H

#include "../ncnn/layer.h"

namespace ncnn {

class Normalize : public Layer
{
public:
    Normalize();

    virtual int load_param(const ParamDict& pd);

    virtual int load_model(const ModelBin& mb);

    virtual int forward_inplace(Mat& bottom_top_blob, const Option& opt) const;

public:
    // param
    int across_spatial;
    int across_channel;
    int channel_shared;
    float eps;
    int scale_data_size;

    // 0 = v / sqrt(v2 + eps) caffe/mxnet
    // 1 = v / max(sqrt(v2), eps) pytorch
    // 2 = v / sqrt(max(v2, eps)) tensorflow
    int eps_mode;

    Mat scale_data;
};

} // namespace ncnn

#endif // LAYER_NORMALIZE_H
