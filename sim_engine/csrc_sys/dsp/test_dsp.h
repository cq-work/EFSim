#ifndef __TEST_DSP_H_
#define __TEST_DSP_H_

#include "../ncnn/option.h"
#include "math.h"
/*待定
#include "../hw/alu_math.h"
#include "../hw/alu_mat.h"
*/
#include "../veri.h"
#include "../utils/testutil.h"


namespace test{


//void forward_cpu_atan(ncnn::Mat& data_in, ncnn::Mat& data_out);
//void forward_npu_atan(ncnn::Mat& data_in, ncnn::Mat& data_out);
//void test_dsp_atan();

void forward_cpu_sin(ncnn::Mat& data_in, ncnn::Mat& data_out);
void forward_npu_sin(ncnn::Mat& data_in, ncnn::Mat& data_out);
void test_dsp_sin();

void forward_cpu_cos(ncnn::Mat& data_in, ncnn::Mat& data_out);
void forward_npu_cos(ncnn::Mat& data_in, ncnn::Mat& data_out);
void test_dsp_cos();
/*
void forward_cpu_iexp(ncnn::Mat& data_in, ncnn::Mat& data_out);
void forward_npu_iexp(ncnn::Mat& data_in, ncnn::Mat& data_out);
void test_dsp_iexp();

void forward_cpu_log(ncnn::Mat& data_in, ncnn::Mat& data_out);
void forward_npu_log(ncnn::Mat& data_in, ncnn::Mat& data_out);
void test_dsp_log();

void forward_cpu_sin(ncnn::Mat& data_in, ncnn::Mat& data_out);
void forward_npu_sin(ncnn::Mat& data_in, ncnn::Mat& data_out);
void test_dsp_sin();

void forward_cpu_sqrt(ncnn::Mat& data_in, ncnn::Mat& data_out);
void forward_npu_sqrt(ncnn::Mat& data_in, ncnn::Mat& data_out);
void test_dsp_sqrt();

void forward_cpu_add(ncnn::Mat& data_a, ncnn::Mat& data_b, ncnn::Mat& data_c);
void forward_npu_add(ncnn::Mat& data_a, ncnn::Mat& data_b, ncnn::Mat& data_c);
void test_dsp_add();

void forward_cpu_dot(ncnn::Mat& data_a, ncnn::Mat& data_b, ncnn::Mat& data_c);
void forward_npu_dot(ncnn::Mat& data_a, ncnn::Mat& data_b, ncnn::Mat& data_c);
void test_dsp_dot();
*/
}

#endif