#include "test_dsp.h"
#include "../hw/alu_math.h"

namespace test{

void forward_cpu_sin(ncnn::Mat& data_in, ncnn::Mat& data_out){
    for(int c=0; c<data_in.c; c++){
        float* data_in_ptr = data_in.channel(c);
        float* data_out_ptr = data_out.channel(c);
        for(int wh=0; wh<data_in.w*data_in.h; wh++){
            float data_in = *data_in_ptr++;
            float data_out = sin(2*M_PI*(data_in));
            *data_out_ptr++ = data_out;
            printf("data_in_cpu = %f\n", data_in);
            printf("data_out_cpu = %f\n", data_out);
        }
    }
}

void forward_npu_sin(ncnn::Mat& data_in, ncnn::Mat& data_out){
    alu_math inst;
    inst.initial();
    inst.weight_update();
    for(int c=0; c<data_in.c; c++){
        float* data_in_ptr = data_in.channel(c);
        float* data_out_ptr = data_out.channel(c);
        /*
        for(int wh=0; wh<data_in.w*data_in.h; wh++){
            *data_out_ptr++ = sin(2*M_PI*(*data_in_ptr++));
        } 
        */
        for(int wh=0; wh<data_in.w*data_in.h; wh++){
            int a = 0;
            
            float data_in = *data_in_ptr++;
            int sin_flag = 1;
            float alu_math_data = inst.forward(sin_flag,data_in);
            *data_out_ptr++ = alu_math_data;
            printf("data_in_npu = %f\n", data_in);
            printf("data_out_npu = %f\n", alu_math_data);
        }
    }
}

void test_dsp_sin(){
    SRAND(7767517);
    ncnn::Option opt;
    ncnn::Mat data_in = RandomMat(10,10,3,-100.0f,100.0f);
    // ncnn::Mat data_in = RandomMat(2,2,3,-100.0f,100.0f);
    printf("\n[ log ]: the data_in shape is (%d, %d, %d)\n",data_in.w, data_in.h, data_in.c);
    ncnn::Mat data_out_sw(data_in.w,data_in.h,data_in.c,4u,opt.blob_allocator);
    ncnn::Mat data_out_hw(data_in.w,data_in.h,data_in.c,4u,opt.blob_allocator);
    forward_cpu_sin(data_in, data_out_sw);
    printf("\nfinish CPU!!!\n");
    forward_npu_sin(data_in, data_out_hw);

    if(CompareMat(data_out_sw,data_out_hw,0.0001) == 0)
        printf("\033[;32m[ log ]: TEST DSP SIN BETWEEN NCNN AND SIMULATION PASS\n\033[0m");
    else
        printf("\033[;31m[ log ]: TEST DSP SIN BETWEEN NCNN AND SIMULATION FAILED\n\033[0m");
}

}
