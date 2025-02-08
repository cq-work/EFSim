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

#include "convolution.h"
#include "../ncnn/layer_type.h"
#include "fused_activation.h"
#include "../utils/testutil.h"
#include "../config.h"
#include "assert.h"
#include "../utils/utils.h"
#include "../hw/hw_cim.h"
#include "../ppa/ppa.h"
#include "../hw/accel_params.h"
#include <vector>


long long operations = 0;
double AT_forward_counts = 0;

namespace ncnn {

Convolution::Convolution()
{
    one_blob_only = true;
    support_inplace = false;
}

int Convolution::load_param(const ParamDict& pd)
{
    // printf("[ log ]: load param\n");
    num_output = pd.get(0, 0);
    kernel_w = pd.get(1, 0);
    kernel_h = pd.get(11, kernel_w);
    dilation_w = pd.get(2, 1);
    dilation_h = pd.get(12, dilation_w);
    stride_w = pd.get(3, 1);
    stride_h = pd.get(13, stride_w);
    pad_left = pd.get(4, 0);
    pad_right = pd.get(15, pad_left);
    pad_top = pd.get(14, pad_left);
    pad_bottom = pd.get(16, pad_top);
    pad_value = pd.get(18, 0.f);
    bias_term = pd.get(5, 0);
    weight_data_size = pd.get(6, 0);
    int8_scale_term = pd.get(8, 0);
    activation_type = pd.get(9, 0);
    activation_params = pd.get(10, Mat());

    dynamic_weight = pd.get(19, 0);

    if (dynamic_weight)
    {
        one_blob_only = false;
    }

    if (int8_scale_term)
    {
#if NCNN_INT8
        support_int8_storage = true;
#else
        NCNN_LOGE("please build ncnn with NCNN_INT8 enabled for int8 inference");
        return -1;
#endif
    }

    return 0;
}

int Convolution::load_model(const ModelBin& mb)
{
    // printf("[ log ]: load model\n");
    if (dynamic_weight)
        return 0;

    weight_data = mb.load(weight_data_size, 0);
    if (weight_data.empty())
        return -100;

    if (bias_term)
    {
        bias_data = mb.load(num_output, 1);
        if (bias_data.empty())
            return -100;
    }

#if NCNN_INT8
    if (int8_scale_term)
    {
        weight_data_int8_scales = mb.load(num_output, 1);
        bottom_blob_int8_scales = mb.load(1, 1);
    }

    if (int8_scale_term > 100)
    {
        top_blob_int8_scales = mb.load(1, 1);
    }
#endif // NCNN_INT8

    return 0;
}

int Convolution::create_pipeline(const Option& opt)
{
    if (dynamic_weight)
        return 0;

#if NCNN_INT8
    // runtime quantize the weight data
    if (opt.use_int8_inference && weight_data.elemsize == (size_t)4u && int8_scale_term)
    {
        printf("[ log ]: runtime quantize the weight data\n");
        const int maxk = kernel_w * kernel_h;
        const int num_input = weight_data_size / num_output / maxk;

        Mat weight_data_r2 = weight_data.reshape(maxk, num_input, num_output);

        Mat weight_data_int8;

        Option opt_q = opt;
        opt_q.blob_allocator = weight_data.allocator;
        opt_q.use_packing_layout = false;
        quantize_to_int8(weight_data_r2, weight_data_int8, weight_data_int8_scales, opt_q);
        if (weight_data_int8.empty())
            return -100;

        weight_data = weight_data_int8.reshape(weight_data_size);
    }
#else
    (void)(opt);
#endif // NCNN_INT8

    return 0;
}

static int convolution(const Mat& bottom_blob, Mat& top_blob, const Mat& weight_data, const Mat& bias_data, int kernel_w, int kernel_h, int stride_w, int stride_h, int dilation_w, int dilation_h, int activation_type, const Mat& activation_params, const Option& opt)
{
    printf("no use [ log ]: static int convolution(const Mat& bottom_blob, Mat& top_blob, const Mat& weight_data, const Mat& bias_data, int kernel_w, int kernel_h, int stride_w, int stride_h, int dilation_w, int dilation_h, int activation_type, const Mat& activation_params, const Option& opt)\n");
    const int w = bottom_blob.w;
    const int inch = bottom_blob.c;

    const int outw = top_blob.w;
    const int outh = top_blob.h;
    const int outch = top_blob.c;

    const int bias_term = bias_data.empty() ? 0 : 1;

    const int maxk = kernel_w * kernel_h;

    // kernel offsets
    std::vector<int> _space_ofs(maxk);
    int* space_ofs = &_space_ofs[0];
    {
        int p1 = 0;
        int p2 = 0;
        int gap = w * dilation_h - kernel_w * dilation_w;
        for (int i = 0; i < kernel_h; i++)
        {
            for (int j = 0; j < kernel_w; j++)
            {
                space_ofs[p1] = p2;
                p1++;
                p2 += dilation_w;
            }
            p2 += gap;
        }
    }

     
    for (int p = 0; p < outch; p++)
    {
        float* outptr = top_blob.channel(p);

        for (int i = 0; i < outh; i++)
        {
            for (int j = 0; j < outw; j++)
            {
                float sum = 0.f;

                if (bias_term)
                    sum = bias_data[p];

                const float* kptr = (const float*)weight_data + maxk * inch * p;

                for (int q = 0; q < inch; q++)
                {
                    const Mat m = bottom_blob.channel(q);
                    const float* sptr = m.row(i * stride_h) + j * stride_w;

                    for (int k = 0; k < maxk; k++) // 29.23
                    {
                        float val = sptr[space_ofs[k]]; // 20.72
                        float wt = kptr[k];
                        sum += val * wt; // 41.45
                    }

                    kptr += maxk;
                }

                outptr[j] = activation_ss(sum, activation_type, activation_params);
            }

            outptr += outw;
        }
    }

    return 0;
}

int Convolution::forward(const Mat& bottom_blob, Mat& top_blob, const Option& opt) const
{
    printf("\n\n[ log ]: 2 -> Convolution::forward(const Mat& bottom_blob, Mat& top_blob, const Option& opt)\n");
#if NCNN_INT8
    if (opt.use_int8_inference && weight_data.elemsize == (size_t)1u)
    {
        #ifdef FORWARD_ON_CPU_CONV
        return forward_int8_cpu(bottom_blob, top_blob, opt);
        #else
        return forward_int8_npu(bottom_blob, top_blob, opt);
        #endif
    }
#endif

    // flattened blob, implement as InnerProduct
    if (bottom_blob.dims == 1 && kernel_w == 1 && kernel_h == 1)
    {
        int num_input = weight_data_size / num_output;
        if (bottom_blob.w * bottom_blob.elempack == num_input)
        {
            // call InnerProduct
            ncnn::Layer* op = ncnn::create_layer(ncnn::LayerType::InnerProduct);

            // set param
            ncnn::ParamDict pd;
            pd.set(0, num_output);
            pd.set(1, bias_term);
            pd.set(2, weight_data_size);
            pd.set(8, int8_scale_term);
            pd.set(9, activation_type);
            pd.set(10, activation_params);

            op->load_param(pd);

            // set weights
            ncnn::Mat weights[4];
            weights[0] = weight_data;
            weights[1] = bias_data;

#if NCNN_INT8
            if (int8_scale_term)
            {
                weights[2] = weight_data_int8_scales;
                weights[3] = bottom_blob_int8_scales;
            }
#endif

            op->load_model(ModelBinFromMatArray(weights));

            op->create_pipeline(opt);

            // forward
            op->forward(bottom_blob, top_blob, opt);

            op->destroy_pipeline(opt);

            delete op;

            return 0;
        }
    }

    Mat bottom_blob_bordered;
    make_padding(bottom_blob, bottom_blob_bordered, opt);
    if (bottom_blob_bordered.empty())
        return -100;

    const int w = bottom_blob_bordered.w;
    const int h = bottom_blob_bordered.h;
    const size_t elemsize = bottom_blob_bordered.elemsize;

    const int kernel_extent_w = dilation_w * (kernel_w - 1) + 1;
    const int kernel_extent_h = dilation_h * (kernel_h - 1) + 1;

    const int outw = (w - kernel_extent_w) / stride_w + 1;
    const int outh = (h - kernel_extent_h) / stride_h + 1;

    top_blob.create(outw, outh, num_output, elemsize, opt.blob_allocator);
    if (top_blob.empty())
        return -100;

    int ret = convolution(bottom_blob_bordered, top_blob, weight_data, bias_data, kernel_w, kernel_h, stride_w, stride_h, dilation_w, dilation_h, activation_type, activation_params, opt);
    if (ret != 0)
        return ret;

    return 0;
}

int Convolution::forward(const std::vector<Mat>& bottom_blobs, std::vector<Mat>& top_blobs, const Option& opt) const
{
    assert(0);
    printf("[ log ]: Convolution::forward(const std::vector<Mat>& bottom_blobs, std::vector<Mat>& top_blobs, const Option& opt)\n");
    const Mat& bottom_blob = bottom_blobs[0];
    const Mat& _weight_data = bottom_blobs[1];
    Mat& top_blob = top_blobs[0];

    const int _kernel_w = _weight_data.w;
    const int _kernel_h = _weight_data.h;
    const int _num_output = _weight_data.c;

    Mat weight_data_flattened;
    flatten(_weight_data, weight_data_flattened, opt);
    if (weight_data_flattened.empty())
        return -100;

    Mat bias_data_flattened;
    if (bias_term)
    {
        const Mat& _bias_data = bottom_blobs[2];
        flatten(_bias_data, bias_data_flattened, opt);
        if (bias_data_flattened.empty())
            return -100;
    }

    Mat bottom_blob_bordered;
    make_padding(bottom_blob, bottom_blob_bordered, _kernel_w, _kernel_h, opt);
    if (bottom_blob_bordered.empty())
        return -100;

    const int w = bottom_blob_bordered.w;
    const int h = bottom_blob_bordered.h;
    const size_t elemsize = bottom_blob_bordered.elemsize;

    const int kernel_extent_w = dilation_w * (_kernel_w - 1) + 1;
    const int kernel_extent_h = dilation_h * (_kernel_h - 1) + 1;

    const int outw = (w - kernel_extent_w) / stride_w + 1;
    const int outh = (h - kernel_extent_h) / stride_h + 1;

    top_blob.create(outw, outh, _num_output, elemsize, opt.blob_allocator);
    if (top_blob.empty())
        return -100;

    int ret = convolution(bottom_blob_bordered, top_blob, weight_data_flattened, bias_data_flattened, _kernel_w, _kernel_h, stride_w, stride_h, dilation_w, dilation_h, activation_type, activation_params, opt);
    if (ret != 0)
        return ret;

    return 0;
}

void Convolution::make_padding(const Mat& bottom_blob, Mat& bottom_blob_bordered, const Option& opt) const
{
    make_padding(bottom_blob, bottom_blob_bordered, kernel_w, kernel_h, opt);
}

void Convolution::make_padding(const Mat& bottom_blob, Mat& bottom_blob_bordered, int _kernel_w, int _kernel_h, const Option& opt) const
{
    int w = bottom_blob.w;
    int h = bottom_blob.h;

    const int kernel_extent_w = dilation_w * (_kernel_w - 1) + 1;
    const int kernel_extent_h = dilation_h * (_kernel_h - 1) + 1;

    bottom_blob_bordered = bottom_blob;
    if (pad_left > 0 || pad_right > 0 || pad_top > 0 || pad_bottom > 0)
    {
        Option opt_b = opt;
        opt_b.blob_allocator = opt.workspace_allocator;
        copy_make_border(bottom_blob, bottom_blob_bordered, pad_top, pad_bottom, pad_left, pad_right, BORDER_CONSTANT, pad_value, opt_b);
    }
    else if (pad_left == -233 && pad_right == -233 && pad_top == -233 && pad_bottom == -233)
    {
        // tensorflow padding=SAME or onnx padding=SAME_UPPER
        int wpad = kernel_extent_w + (w - 1) / stride_w * stride_w - w;
        int hpad = kernel_extent_h + (h - 1) / stride_h * stride_h - h;
        if (wpad > 0 || hpad > 0)
        {
            Option opt_b = opt;
            opt_b.blob_allocator = opt.workspace_allocator;
            copy_make_border(bottom_blob, bottom_blob_bordered, hpad / 2, hpad - hpad / 2, wpad / 2, wpad - wpad / 2, BORDER_CONSTANT, pad_value, opt_b);
        }
    }
    else if (pad_left == -234 && pad_right == -234 && pad_top == -234 && pad_bottom == -234)
    {
        // onnx padding=SAME_LOWER
        int wpad = kernel_extent_w + (w - 1) / stride_w * stride_w - w;
        int hpad = kernel_extent_h + (h - 1) / stride_h * stride_h - h;
        if (wpad > 0 || hpad > 0)
        {
            Option opt_b = opt;
            opt_b.blob_allocator = opt.workspace_allocator;
            copy_make_border(bottom_blob, bottom_blob_bordered, hpad - hpad / 2, hpad / 2, wpad - wpad / 2, wpad / 2, BORDER_CONSTANT, pad_value, opt_b);
        }
    }
}

#if NCNN_INT8
static inline signed char float2int8(float v)
{
    int int32 = static_cast<int>(round(v));
    if (int32 > 127) return 127;
    if (int32 < -127) return -127;
    return (signed char)int32;
}


int Convolution::forward_int8_cpu(const Mat& bottom_blob, Mat& top_blob, const Option& opt) const
{
    // printf("[ log ]: 3 -> Convolution::forward_int8_cpu(const Mat& bottom_blob, Mat& top_blob, const Option& opt)\n");
    printf("[ log ]: start forward ncnn conv on cpu ...\n");
    int w = bottom_blob.w;                           //输入特征图的w,h,c,数据类型（自定义？？？）
    int h = bottom_blob.h;
    int channels = bottom_blob.c;
    size_t elemsize = bottom_blob.elemsize;
    //kernel_w和stride_w由param读取或者
    printf("[ log ]: ifm_w = %d, ifm_h = %d, ifm_c = %d, kernel = %d, stride = %d\n",w,h,channels,kernel_w,stride_w);
    printf("[ log ]: pad_left = %d, pad_right = %d, pad_top = %d, pad_bottom = %d\n",pad_left, pad_right, pad_top, pad_bottom);
    //卷积核的扩展，相当于是膨胀，dilation_w为1，不膨胀
    const int kernel_extent_w = dilation_w * (kernel_w - 1) + 1;
    const int kernel_extent_h = dilation_h * (kernel_h - 1) + 1;

    Mat bottom_blob_unbordered = bottom_blob;
    if (elemsize != 1)               //非int8类型，在这儿量化？？？图像数据(进来的数据类型0-255-浮点预处理-量化)
    {
        Option opt_g = opt;
        opt_g.blob_allocator = opt.workspace_allocator;

        quantize_to_int8(bottom_blob, bottom_blob_unbordered, bottom_blob_int8_scales, opt_g);
    }
    //打padding
    Mat bottom_blob_bordered;
    make_padding(bottom_blob_unbordered, bottom_blob_bordered, opt);
    if (bottom_blob_bordered.empty())
        return -100;

    w = bottom_blob_bordered.w;
    h = bottom_blob_bordered.h;
    //输出特征图的大小
    int outw = (w - kernel_extent_w) / stride_w + 1;
    int outh = (h - kernel_extent_h) / stride_h + 1;
    //卷积核内的乘加
    const int maxk = kernel_w * kernel_h;

    // kernel offsets   卷积数据的排布
    std::vector<int> _space_ofs(maxk);
    int* space_ofs = &_space_ofs[0];
    {
        int p1 = 0;
        int p2 = 0;
        int gap = w * dilation_h - kernel_w * dilation_w;
        for (int i = 0; i < kernel_h; i++)
        {
            for (int j = 0; j < kernel_w; j++)
            {
                space_ofs[p1] = p2;                       //连续的地址
                p1++;
                p2 += dilation_w;
            }
            p2 += gap;
        }
    }

    // int8   这一块是什么意思呢？
    bool use_int8_requantize = int8_scale_term > 100;           //int8_scale_term大于100  101
    size_t out_elemsize = use_int8_requantize ? 1u : 4u;
    //生成一个空间这么大的输出特征图矩阵   num_output为什么是channel
    top_blob.create(outw, outh, num_output, out_elemsize, opt.blob_allocator);
    if (top_blob.empty())
        return -100;

    // num_output
     
    for (int p = 0; p < num_output; p++)            //输出特征图的channel
    {
        signed char* outptr = top_blob.channel(p);

        for (int i = 0; i < outh; i++)              //具体位置
        {
            for (int j = 0; j < outw; j++)
            {
                int sum = 0;

                const signed char* kptr = (const signed char*)weight_data + maxk * channels * p;

                // channels
                for (int q = 0; q < channels; q++)          //输入特征图的位置
                {
                    const Mat m = bottom_blob_bordered.channel(q);
                    const signed char* sptr = m.row<signed char>(i * stride_h) + j * stride_w;

                    for (int k = 0; k < maxk; k++)              //卷积运算
                    {
                        int val = sptr[space_ofs[k]];
                        int wt = kptr[k];
                        sum += val * wt;
                    }

                    kptr += maxk;
                }
                //这一块儿的收缩是因为什么呢？？   反量化
                float scale_in;
                if (weight_data_int8_scales[p] == 0)
                    scale_in = 0;
                else
                    scale_in = 1.f / (bottom_blob_int8_scales[0] * weight_data_int8_scales[p]);

                float sumfp32 = sum * scale_in;
                //加偏置
                if (bias_term)
                    sumfp32 += bias_data[p];
                //激活
                sumfp32 = activation_ss(sumfp32, activation_type, activation_params);
                //重量化或者反量化
                if (use_int8_requantize)
                {
                    // requantize
                    float scale_out = top_blob_int8_scales[0];
                    signed char sums8 = float2int8(sumfp32 * scale_out);
                    outptr[0] = sums8;
                    outptr += 1;
                }
                else
                {
                    // dequantize
                    ((float*)outptr)[0] = sumfp32;
                    outptr += 4;
                }
                
            }
        }
    }

    return 0;
}
int Convolution::forward_int8_npu(const Mat& bottom_blob, Mat& top_blob, const Option& opt) const
{
    // printf("[ log ]: 3 -> Convolution::forward_int8_cpu(const Mat& bottom_blob, Mat& top_blob, const Option& opt)\n");
    printf("[ log ]: start forward ncnn conv on npu ...\n");
    int w = bottom_blob.w;                           //输入特征图的w,h,c,数据类型（自定义？？？）
    int h = bottom_blob.h;
    int channels = bottom_blob.c;
    size_t elemsize = bottom_blob.elemsize;
    //kernel_w和stride_w由param读取或者
    printf("[ log ]: ifm_w = %d, ifm_h = %d, ifm_c = %d, kernel = %d, stride = %d\n",w,h,channels,kernel_w,stride_w);
    printf("[ log ]: pad_left = %d, pad_right = %d, pad_top = %d, pad_bottom = %d\n",pad_left, pad_right, pad_top, pad_bottom);
    //卷积核的扩展，相当于是膨胀，dilation_w为1，不膨胀
    const int kernel_extent_w = dilation_w * (kernel_w - 1) + 1;
    const int kernel_extent_h = dilation_h * (kernel_h - 1) + 1;

    Mat bottom_blob_unbordered = bottom_blob;
    if (elemsize != 1)               //非int8类型，在这儿量化？？？图像数据(进来的数据类型0-255-浮点预处理-量化)
    {
        Option opt_g = opt;
        opt_g.blob_allocator = opt.workspace_allocator;

        quantize_to_int8(bottom_blob, bottom_blob_unbordered, bottom_blob_int8_scales, opt_g);
    }
    //打padding
    Mat bottom_blob_bordered;
    make_padding(bottom_blob_unbordered, bottom_blob_bordered, opt);
    if (bottom_blob_bordered.empty())
        return -100;

    w = bottom_blob_bordered.w;
    h = bottom_blob_bordered.h;
    //输出特征图的大小
    int outw = (w - kernel_extent_w) / stride_w + 1;
    int outh = (h - kernel_extent_h) / stride_h + 1;
    //卷积核内的乘加
    const int maxk = kernel_w * kernel_h;

    // kernel offsets   卷积数据的排布
    std::vector<int> _space_ofs(maxk);
    int* space_ofs = &_space_ofs[0];
    {
        int p1 = 0;
        int p2 = 0;
        int gap = w * dilation_h - kernel_w * dilation_w;
        for (int i = 0; i < kernel_h; i++)
        {
            for (int j = 0; j < kernel_w; j++)
            {
                space_ofs[p1] = p2;                       //连续的地址
                p1++;
                p2 += dilation_w;
            }
            p2 += gap;
        }
    }

    // int8   这一块是什么意思呢？
    bool use_int8_requantize = int8_scale_term > 100;           //int8_scale_term大于100  101
    size_t out_elemsize = use_int8_requantize ? 1u : 4u;
    //生成一个空间这么大的输出特征图矩阵   num_output为什么是channel
    top_blob.create(outw, outh, num_output, out_elemsize, opt.blob_allocator);
    if (top_blob.empty())
        return -100;

    // num_output
    hw_cim inst;
    
    int mapping_time_row = static_cast<int>(std::ceil(float (maxk*channels)/(float (TOTAL_ROW))));      //映射次数，这是把两个tile在行方向并成一个1024*512的大阵列
    int mapping_time_col = static_cast<int>(std::ceil(float (num_output)/(float (NUM_COL))));           //因为每8列表示一个数，512列只能映射64个数
    


    inst.initial();
    #ifdef TEST_SINGLE_LAYER
    if ((maxk*channels == 512))                    //YOLOV3-Tiny
    // if ((maxk*channels == 512) || (maxk*channels == 1024))
    #else
    if (1)
    #endif
    {
        operations += bottom_blob.w * bottom_blob.h * bottom_blob.c * kernel_w * kernel_h * num_output;
        int pipeline_cnt = 0;
        if (PIPELINE_CNT) {
            pipeline_cnt = 2;
        }
        
        std::vector<int> tmp_wgt, tmp_in;
        int stride_sq = kernel_h * stride_w * channels;
        std::vector<std::vector<int>> sum_p;
        const signed char* weight_index = (const signed char*)weight_data;
        printf("[ log ]: Hardware simulation start.\n");
        for (int p = 0; p < mapping_time_col; p++){
            for (int q = 0; q < mapping_time_row; q++){
                std::vector<std::vector<signed char>> weight_mat;
                int start_index_col = p*NUM_COL;
                int start_index_row = q*TOTAL_ROW;
                int end_index_row, end_index_col;
                if (q!=(mapping_time_row-1)) {
                    end_index_row = (q+1)*TOTAL_ROW;
                } else {
                    end_index_row = maxk*channels;
                }
                if (p!=(mapping_time_col-1)) {
                    end_index_col = (p+1)*NUM_COL;
                } else {
                    end_index_col = num_output;
                }
                for (int c = start_index_col; c < end_index_col; c++) {
                    std::vector<signed char> weight_mat_c;
                    for (int r = start_index_row; r < end_index_row; r++) {
                        signed char weight_wr;
                        int wgt_index = r / (kernel_h * channels) + (r - (r / (kernel_h * channels)) * (kernel_h * channels)) * kernel_w;
                        weight_wr = weight_index[c*maxk*channels + wgt_index];
                        weight_mat_c.push_back(weight_wr);        //    一次性最多取1024*64个数据
                    }
                    weight_mat.push_back(weight_mat_c);
                }
                int occupy_array = (std::ceil((float (end_index_row - start_index_row)) / double (ARRAY_ROW)));
                int sq_cnt = 1;
                
                #if defined(SQ_MAPPING)     //判断阵列大小是否能容纳更多的weight
                    while ((weight_mat[0].size() + stride_sq <= occupy_array * WL_NUM) && (weight_mat.size() + end_index_col - start_index_col <= PE2ARRAY_NUM*UNIT_NUM)) {
                        sq_cnt += 1;
                        std::list<signed char> zero_list_tail(stride_sq, 0);
                        std::list<signed char> zero_list_new(weight_mat[0].size() + stride_sq, 0);
                        std::vector<signed char> new_col(zero_list_new.begin(), zero_list_new.end());
                        for (int i = 0; i < weight_mat.size(); i++) {       //先把已有的列拓展长度
                            std::copy(zero_list_tail.begin(), zero_list_tail.end(), std::back_inserter(weight_mat[i]));
                        }
                        for (int i = 0; i < end_index_col - start_index_col; i++) {     //每次新增一列，然后给这列的特定位置赋值
                            weight_mat.push_back(new_col);
                            for (int j = weight_mat[0].size() - 1; j >= weight_mat[0].size() - (end_index_row - start_index_row); j--) {
                                weight_mat.back()[j] = weight_mat[weight_mat.size() - 1 - (end_index_col - start_index_col)][j - stride_sq];
                            }
                        }
                    }
                    inst.weight_update(weight_mat);
                #else
                    inst.weight_update(weight_mat); //在这进硬件
                #endif

                // printf("weight_mat size = %d,%d\n",weight_mat.size(),weight_mat[0].size());  //weight_mat.size()col    weight_mat[0].size()row
                int row = weight_mat[0].size();
                int col = weight_mat.size();
                int num_addertree = TILE_NUM * TILE2PE_NUM * PE2ARRAY_NUM * UNIT_NUM;
                int cp_time = floor(TILE_NUM * TILE2PE_NUM / ceil(row*1.0 / ARRAY_ROW*1.0));
                int addertree_1 = floor(row/ARRAY_ROW);          
                int row_last = row - addertree_1 * ARRAY_ROW;
                // printf("row_last= %d\n",row_last);
                double addertree_ratio = ppa::calculate_addertree_ratio(row_last, BIT_NUM);
                // printf("addertree_ratio= %.5f\n",addertree_ratio);
                double AT_ratio = cp_time * (addertree_1 * 1 * col + 1 * addertree_ratio * col)/(num_addertree);
                // printf("AT_ratio= %.5f\n",AT_ratio);
                // while(1){
                //     int a = 1;
                // }
                AT_forward_counts += AT_ratio * outh * outw;
                // printf("AT_forward_counts= %.5f\n",AT_forward_counts);

                double utili_compute_unit = (cp_time * row * col * BIT_NUM * 1.0) / (TILE_NUM * TILE2PE_NUM * PE2ARRAY_NUM * ARRAY_ROW * ARRAY_COL * 1.0);
                // printf("utili_compute_unit= %.5f\n",utili_compute_unit);


                std::vector<signed char> input_mat, input_mat_origin, input_mat_final;
                std::vector<std::vector<std::vector<int>>> out_mat_array;
                std::vector<int> reuse_time_array, out_mat_index_i, out_mat_index_j;
                int occupy_row = maxk*channels;
                int in_cnt = 0;
                int push_back_cnt_tmp = pipeline_cnt;
                for (int i = 0; i < outh; i++) {        //outh
                    for (int j = 0; j < outw; j++) {    //每次映射需要输入W*H次数据 outw
                        std::vector<signed char> input_mat_tmp;
                        int r = start_index_row;
                        while ( r < start_index_row + occupy_array*WL_NUM) {     //每次数据共1024个
                            int qc = (r % (kernel_h*channels)) / kernel_h;          //取通道
                            int k = (r % kernel_h) * kernel_w + (r / (kernel_h * channels));           //取卷积核对应输入的第k个元素
                            const Mat m = bottom_blob_bordered.channel(qc);
                            const signed char* input_index = m.row<signed char>(i * stride_h) + j * stride_w;
                            if (r < end_index_row) {
                                signed char input_wr;
                                input_wr = input_index[space_ofs[k]];
                                input_mat_tmp.push_back(input_wr);
                            } else {
                                input_mat_tmp.push_back(0);
                            }
                            r++;
                        }
                        
                        #if defined(SQ_MAPPING)        //先根据两个公式判断是否能用SQ，如果能，在每个SQ的分阵列（1个或2个）里面分别获取数据，这样和下面的代码不冲突
                            if (in_cnt == 0) {
                                input_mat = input_mat_tmp;
                            } else {
                                for (int k = 0; k < stride_sq; k++) {
                                    input_mat[occupy_row + k] = input_mat_tmp[k + channels * kernel_h * (kernel_w - stride_w)];
                                }
                                occupy_row += stride_sq;
                            }
                            in_cnt += 1;
                            if ((in_cnt == sq_cnt) || (j == outw-1)) {         //每行的最后一个元素和下一行的第一个元素之间是没有复用的
                                input_mat_final.insert(input_mat_final.end(), input_mat.begin(), input_mat.end());
                                in_cnt = 0;
                                occupy_row = maxk*channels;
                            }
                        #else 
                            input_mat_final.insert(input_mat_final.end(), input_mat_tmp.begin(),input_mat_tmp.end());
                        #endif
                        // printf("%d\n", input_mat_final.size());
                        std::vector<std::vector<int>> out_mat;
                        if ((input_mat_final.size() + occupy_array*WL_NUM <= TOTAL_ROW) && (!((i == outh -1) && (j == outw - 1)))) {
                            continue;
                        } else {
                            out_mat = inst.forward(occupy_array, input_mat_final, utili_compute_unit); //得到1024个数据后进行计算 ,每一次得到的是一个输出元素的64个输出通道
                        }
                        if (push_back_cnt_tmp) {
                            push_back_cnt_tmp += -1;
                        } else {
                            out_mat_array.push_back(out_mat);
                        }
                        out_mat_index_i.push_back(i);
                        out_mat_index_j.push_back(j);
                        int reuse_time = (input_mat_final.size()/WL_NUM) / occupy_array;
                        input_mat_final = input_mat_origin;
                        reuse_time_array.push_back(reuse_time);
                    }
                }
                for (int m = 0; m < pipeline_cnt; m++) {
                    out_mat_array.push_back(inst.forward(occupy_array, input_mat_final, utili_compute_unit));
                }
                
                int array_index = out_mat_array.size() - push_back_cnt_tmp;
                for (int m = 0; m < array_index; m ++) {
                    std::vector<std::vector<int>> out_mat = out_mat_array[m];
                    int i = out_mat_index_i[m];
                    int j = out_mat_index_j[m];
                    int reuse_time = reuse_time_array[m];
                    for (int reuse_cnt = 0; reuse_cnt < reuse_time; reuse_cnt++) {
                        std::vector<int> out_partial = out_mat[reuse_cnt];
                        if (q == 0) {
                            if (p == 0) {
                                #if defined(SQ_MAPPING)
                                    for (int k = 0; k < sq_cnt; k++) {                  
                                        std::vector<int> out_sq_partial;
                                        for (int l = 0; l < end_index_col - start_index_col; l++) {
                                            out_sq_partial.push_back(out_partial[k*(end_index_col - start_index_col)+l]);
                                        }
                                        sum_p.push_back(out_sq_partial);
                                        if ((sum_p.size() % outw) == 0) {
                                            break;
                                        }
                                    }
                                #else
                                    sum_p.push_back(out_partial);   //第一次输出直接添加进数组
                                #endif
                            }
                            else if (p != (mapping_time_col-1)) {       //如果是某一组64通道的第一个部分积，那么压入对应的输出位置上
                                sum_p[i*outw+j+1-reuse_time+reuse_cnt].insert(sum_p[i*outw+j+1-reuse_time+reuse_cnt].end(), out_partial.begin(), out_partial.end());  
                            } else {            //如果是最后的若干个通道，那么把之前补的0通道去掉再压入对应的输出位置上
                                std::vector<int> out_tmp;
                                for (int o_cnt = 0; o_cnt < end_index_col-start_index_col; o_cnt++) {
                                    out_tmp.push_back(out_partial[o_cnt]);
                                }
                                sum_p[i*outw+j+1-reuse_time+reuse_cnt].insert(sum_p[i*outw+j+1-reuse_time+reuse_cnt].end(), out_tmp.begin(), out_tmp.end());   
                            }
                        } else {
                            for (int c_cnt = start_index_col; c_cnt < end_index_col; c_cnt++) {
                                sum_p[i*outw+j+1-reuse_time+reuse_cnt][c_cnt] += out_partial[c_cnt-start_index_col];   //得到一组64通道的除第一次外的部分积，与之前的结果相加
                            }
                        }
                    }
                }
                printf("[ log ]: Partial input forward complete.\n");
            }
        }   //现在得到一个嵌套vector，大vector中共h*w个小vector，每个小的包含output channel个值
        printf("[ log ]: Input forward complete.\n");

        std::vector<int> sum_sw;
        for (int p = 0; p < num_output; p++)            //输出特征图的channel
        {
            for (int i = 0; i < outh; i++)              //具体位置
            {
                for (int j = 0; j < outw; j++)
                {
                    int sum = 0;
                    const signed char* kptr = (const signed char*)weight_data + maxk * channels * p;
                    // channels
                    for (int q = 0; q < channels; q++)          //输入特征图的位置
                    {
                        const Mat m = bottom_blob_bordered.channel(q);
                        const signed char* sptr = m.row<signed char>(i * stride_h) + j * stride_w;

                        for (int k = 0; k < maxk; k++)              //卷积运算
                        {
                            int val = sptr[space_ofs[k]];
                            int wt = kptr[k];
                            int out = val * wt;      
                            sum += out;
                        }
                        kptr += maxk;
                    }
                    sum_sw.push_back(sum);            
                }
            }
        }

        int match_cnt = 100;
        for (int p = 0; p < num_output; p++){
            signed char* outptr = top_blob.channel(p);
            float scale_in;
            if (weight_data_int8_scales[p] == 0)
                scale_in = 0;
            else
                scale_in = 1.f / (bottom_blob_int8_scales[0] * weight_data_int8_scales[p]);
            for (int k = 0;k < outh*outw;k++){
                if ((sum_p[k][p] != sum_sw[k+p*outh*outw]) && (match_cnt)) {
                // if ((sum_p[k][p] > 0) && (match_cnt)) {
                    printf("Here is an unmatched:%d,%d,sum_hw:%d, sum_sw:%d, 差值:%d.\n",k,p,sum_p[k][p],sum_sw[k+p*outh*outw], sum_p[k][p] - sum_sw[k+p*outh*outw]);
                    match_cnt += -1;
                    if (match_cnt == 50){
                        printf("[ log ]: ERROR OCCURRED!!!\n");
                        exit(0);
                    }
                }
                float sumfp32 = sum_p[k][p] * scale_in;
                //加偏置
                if (bias_term)
                    sumfp32 += bias_data[p];
                //激活
                sumfp32 = activation_ss(sumfp32, activation_type, activation_params);
                //重量化或者反量化
                if (use_int8_requantize)
                {
                    // requantize
                    float scale_out = top_blob_int8_scales[0];
                    signed char sums8 = float2int8(sumfp32 * scale_out);
                    outptr[0] = sums8;
                    outptr += 1;
                }
                else
                {
                    // dequantize
                    ((float*)outptr)[0] = sumfp32;
                    outptr += 4;
                }
            } 
        }
        return 0;
    } else {

        std::vector<int> sum_p;
        for (int p = 0; p < num_output; p++)            //输出特征图的channel
        {
            for (int i = 0; i < outh; i++)              //具体位置
            {
                for (int j = 0; j < outw; j++)
                {
                    int sum = 0;
                    const signed char* kptr = (const signed char*)weight_data + maxk * channels * p;
                    // channels
                    for (int q = 0; q < channels; q++)          //输入特征图的位置
                    {
                        const Mat m = bottom_blob_bordered.channel(q);
                        const signed char* sptr = m.row<signed char>(i * stride_h) + j * stride_w;

                        for (int k = 0; k < maxk; k++)              //卷积运算
                        {
                            int val = sptr[space_ofs[k]];
                            int wt = kptr[k];
                            int out = val * wt;      
                            sum += out;
                        }
                        kptr += maxk;
                    }
                    //这一块儿的收缩是因为什么呢？？   反量化
                    sum_p.push_back(sum);            
                }
            }
        }

        // if ((maxk*channels == 144) && (num_output == 32)) {
        //     for (int i = 0; i < 16; i++) {
        //         printf("sum_p[%d]:%d,%d,%d,%d\n", i, sum_p[0+i*outh*outw],sum_p[1+i*outh*outw],sum_p[2+i*outh*outw],sum_p[3+i*outh*outw]);
        //         printf("sum_p[%d]:%d,%d,%d,%d\n", i, sum_p[4+i*outh*outw],sum_p[5+i*outh*outw],sum_p[6+i*outh*outw],sum_p[7+i*outh*outw]);
        //     }
        //     // printf("%d,%d,%d,%d\n", sum_p[0+outh*outw*2],sum_p[30+outh*outw*2],sum_p[60+outh*outw*2],sum_p[100+outh*outw*2]);
        // }

        for (int p = 0; p < num_output; p++){
            signed char* outptr = top_blob.channel(p);
            float scale_in;
            if (weight_data_int8_scales[p] == 0)
                scale_in = 0;
            else
                scale_in = 1.f / (bottom_blob_int8_scales[0] * weight_data_int8_scales[p]);
            
            for (int k = 0;k < outh*outw;k++){
                float sumfp32 = sum_p[k+p*outh*outw] * scale_in;
                //加偏置
                if (bias_term)
                    sumfp32 += bias_data[p];
                //激活
                sumfp32 = activation_ss(sumfp32, activation_type, activation_params);
                //重量化或者反量化
                if (use_int8_requantize)
                {
                    // requantize
                    float scale_out = top_blob_int8_scales[0];
                    signed char sums8 = float2int8(sumfp32 * scale_out);
                    outptr[0] = sums8;
                    outptr += 1;
                }
                else
                {
                    // dequantize
                    ((float*)outptr)[0] = sumfp32;
                    outptr += 4;
                }
            } 
        }
    }
    return 0;
}

#endif // NCNN_INT8

} // namespace ncnn
