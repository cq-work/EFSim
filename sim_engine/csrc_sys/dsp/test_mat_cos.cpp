#include "test_dsp.h"
#include "../hw/alu_math.h"

namespace test{

void forward_cpu_cos(ncnn::Mat& data_in, ncnn::Mat& data_out){
    for(int c=0; c<data_in.c; c++){
        float* data_in_ptr = data_in.channel(c);
        float* data_out_ptr = data_out.channel(c);
        for(int wh=0; wh<data_in.w*data_in.h; wh++){
            // *data_out_ptr++ = cos(2*M_PI*(*data_in_ptr++));
            float data_in = *data_in_ptr++;
            float data_out = cos(2*M_PI*(data_in));
            *data_out_ptr++ = data_out;
            printf("data_in_cpu = %f\n", data_in);
            printf("data_out_cpu = %f\n", data_out);
        }
    }
}

void forward_npu_cos(ncnn::Mat& data_in, ncnn::Mat& data_out){
    alu_math inst;
    inst.initial();
    inst.weight_update();
    for(int c=0; c<data_in.c; c++){
        float* data_in_ptr = data_in.channel(c);
        float* data_out_ptr = data_out.channel(c);
        /*
                for(int wh=0; wh<data_in.w*data_in.h; wh++){
            accel::alu_math inst(ALU_COS);
            inst.forward(*data_in_ptr++);
            axi_lite_wait();
            *data_out_ptr++ = *((float*)&alu_math_data);
        }*/
        for(int wh=0; wh<data_in.w*data_in.h; wh++){
            int a = 0;
            
            float data_in = *data_in_ptr++;
            int sin_flag = 0;                //执行cosine
            float alu_math_data = inst.forward(sin_flag,data_in);
            *data_out_ptr++ = alu_math_data;
            printf("data_in_npu = %f\n", data_in);
            printf("data_out_npu = %f\n", alu_math_data);
        }
    }
}

void test_dsp_cos(){
    SRAND(7767517);
    ncnn::Option opt;
    // ncnn::Mat data_in = RandomMat(5,5,3,-100.0f,100.0f);
    ncnn::Mat data_in = RandomMat(200,200,3,-100.0f,100.0f);
    printf("\n[ log ]: the data_in shape is (%d, %d, %d)\n",data_in.w, data_in.h, data_in.c);
    ncnn::Mat data_out_sw(data_in.w,data_in.h,data_in.c,4u,opt.blob_allocator);
    ncnn::Mat data_out_hw(data_in.w,data_in.h,data_in.c,4u,opt.blob_allocator);
    forward_cpu_cos(data_in, data_out_sw);
    forward_npu_cos(data_in, data_out_hw);

    if(CompareMat(data_out_sw,data_out_hw,0.0001) == 0)
        printf("\033[;32m[ log ]: TEST DSP COS BETWEEN NCNN AND SIMULATION PASS\n\033[0m");
    else
        printf("\033[;31m[ log ]: TEST DSP COS BETWEEN NCNN AND SIMULATION FAILED\n\033[0m");
}

}
