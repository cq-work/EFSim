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

#include "threshold.h"

namespace ncnn {

Threshold::Threshold()
{
    one_blob_only = true;
    support_inplace = true;
}

int Threshold::load_param(const ParamDict& pd)
{
    threshold = pd.get(0, 0.f);

    return 0;
}

int Threshold::forward_inplace(Mat& bottom_top_blob, const Option& opt) const
{
    printf("log: Threshold::forward_inplace\n");
    int w = bottom_top_blob.w;
    int h = bottom_top_blob.h;
    int channels = bottom_top_blob.c;
    int size = w * h;

     
    for (int q = 0; q < channels; q++)
    {
        float* ptr = bottom_top_blob.channel(q);

        for (int i = 0; i < size; i++)
        {
            ptr[i] = ptr[i] > threshold ? 1.f : 0.f;
        }
    }

    return 0;
}

} // namespace ncnn
