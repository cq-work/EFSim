// Tencent is pleased to support the open source community by making ncnn available.
//
// Copyright (C) 2021 THL A29 Limited, a Tencent company. All rights reserved.
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

#ifndef LAYER_POOLING1D_H
#define LAYER_POOLING1D_H

#include "../ncnn/layer.h"

namespace ncnn {

class Pooling1D : public Layer
{
public:
    Pooling1D();

    virtual int load_param(const ParamDict& pd);

    virtual int forward(const Mat& bottom_blob, Mat& top_blob, const Option& opt) const;

    enum PoolMethod
    {
        PoolMethod_MAX = 0,
        PoolMethod_AVE = 1
    };

protected:
    void make_padding(const Mat& bottom_blob, Mat& bottom_blob_bordered, const Option& opt) const;

public:
    // param
    int pooling_type;
    int kernel_w;
    int stride_w;
    int pad_left;
    int pad_right;
    int global_pooling;
    int pad_mode; // 0=full 1=valid 2=SAME_UPPER 3=SAME_LOWER
    int avgpool_count_include_pad;
    int adaptive_pooling;
    int out_w;
};

} // namespace ncnn

#endif // LAYER_POOLING1D_H
