//#include "alu_math.h"
#include "../config.h"
#include "accel_params.h"
#include "alu_math.h"
#include "../veri.h"
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>

#define MAX_ROWS 128
#define MAX_COLS 256
#define MAX_FIELD_LENGTH 100

alu_math::alu_math(){
    // top->function_mode = 0;
}

void alu_math::initial() {
    // top->function_mode = 0;
    // top->clk = 0;
    // top->rst_n = 0;
    // top->sin_op_en = 0;
    // top->cos_op_en = 0;
    unsigned char buffer_bl1[256] = {0}, buffer_bl2[256] = {0}, buffer_wl[16] = {0}, sin_rb[4] = {0}, cos_rb[4] = {0};
    // memcpy(&top->BL_1, buffer_bl1, sizeof(buffer_bl1));
    // memcpy(&top->BL_2, buffer_bl2, sizeof(buffer_bl2));
    // memcpy(&top->WL, buffer_wl, sizeof(buffer_wl));
    // memcpy(&top->sin_rb, buffer_wl, sizeof(sin_rb));
    // memcpy(&top->cos_rb, buffer_wl, sizeof(cos_rb));
    // top->din_valid_ConV = 0;
    update();
    update();
}

void alu_math::update() {
    // top->clk = 1;
    top->eval();
    
    // top->clk = 0;
    top->eval();
}

// void alu_math::weight_update(std::vector<std::vector<unsigned char>>SIN_mat, std::vector<std::vector<unsigned char>>COS_mat) {       
void alu_math::weight_update() {       
    initial();
    // printf("111\n");
	std::ifstream inFile_BL1("/SSD/cq/Compute-in-memory/simulation_sin_cos/csrc/dsp/data_for_CIM_BL1.csv", std::ios::in);
    // printf("1111\n");
	std::string lineStr_BL1;
	std::vector<std::vector<unsigned char>> data_BL1;
	while (std::getline(inFile_BL1, lineStr_BL1))
	{
		// 打印整行字符串
		//std::cout << lineStr_BL1 << std::endl;
		// 存成二维表结构
		std::stringstream ss(lineStr_BL1);
		std::string str_BL1;
		std::vector<unsigned char> lineArray_BL1;
		// 按照逗号分隔
        unsigned char value_BL1_U8;
        int value_BL1;
		while (std::getline(ss, str_BL1, ',')) {
            value_BL1 = std::stoi(str_BL1);
            value_BL1_U8 = (unsigned char)value_BL1;
            // value_BL1 = static_cast<unsigned char>(std::stoi(str_BL1));
            // std::cout << str_BL1 << std::endl;
            // std::cout << value_BL1 << std::endl;
            // printf("value_BL1_U8 = %d\n", value_BL1_U8);   
			lineArray_BL1.push_back(value_BL1);
        }
		data_BL1.push_back(lineArray_BL1);

	}
    // printf("111111111\n");


	std::ifstream inFile_BL2("/SSD/cq/Compute-in-memory/simulation_sin_cos/csrc/dsp/data_for_CIM_BL2.csv", std::ios::in);
	std::string lineStr_BL2;
	std::vector<std::vector<unsigned char>> data_BL2;
	while (std::getline(inFile_BL2, lineStr_BL2))
	{
		// 打印整行字符串
		// std::cout << lineStr_BL2 << std::endl;
		// 存成二维表结构
        // printf("1111\n");
		std::stringstream ss(lineStr_BL2);
		std::string str_BL2;
		std::vector<unsigned char> lineArray_BL2;
		// 按照逗号分隔
        unsigned char value_BL2_U8;
        int value_BL2;
		while (std::getline(ss, str_BL2, ',')) {
            value_BL2 = std::stoi(str_BL2);
            value_BL2_U8 = (unsigned char)value_BL2;
			lineArray_BL2.push_back(value_BL2);
        }
		data_BL2.push_back(lineArray_BL2);
	}
    // printf("sizeof_row(data_BL1) = %zu\n", data_BL1.size());
    // printf("sizeof_col(data_BL1) = %zu\n", data_BL1[0].size());
    // printf("sizeof_row(data_BL2) = %zu\n", data_BL2.size());
    // printf("sizeof_col(data_BL2) = %zu\n", data_BL2[0].size());
    // printf("data_BL1[0][0] = %d\n", data_BL1[0][0]);
    // printf("data_BL1[0][1] = %d\n", data_BL1[0][1]);
    // printf("data_BL1[0][255] = %d\n", data_BL1[0][255]);


    for (int wl = 0; wl < WL_NUM; wl++) {
        unsigned char buffer_bl1[256] = {0}, buffer_bl2[256] = {0}, buffer_wl[16] = {0};
        for (int bl = 0; bl < 256; bl++) {
            unsigned char wr_data;
            //printf("data_BL1[wl][bl]= %d",data_BL1[wl][bl]);                
            buffer_bl1[bl] = data_BL1[wl][255-bl];       //在这里写硬件，一步步把权重写进去
            buffer_bl2[bl] = data_BL2[wl][255-bl];
        }
        if (wl == 127){
            printf("buffer_bl1[0] = %d\n",buffer_bl1[0]);                   
            printf("buffer_bl1[255] = %d\n",buffer_bl1[255]);                 
            printf("buffer_wl[0] = %d\n",buffer_wl[0]);
            printf("buffer_bl2[0] = %d\n",buffer_bl2[0]);                   
            printf("buffer_bl2[255] = %d\n",buffer_bl2[255]);                 
            // while(1){
            //     int a = 1;
            // }   
        }
                
        buffer_wl[wl/8] = (unsigned char) pow(2, wl % 8);     
        // memcpy(&top->BL_1, buffer_bl1, sizeof(buffer_bl1));
        // memcpy(&top->BL_2, buffer_bl2, sizeof(buffer_bl2));
        // memcpy(&top->WL, buffer_wl, sizeof(buffer_wl));
        update();

        buffer_wl[wl/8] = 0;
    } 
    unsigned char buffer_bl1[256] = {0}, buffer_bl2[256] = {0}, buffer_wl[16] = {0};
    // memcpy(&top->BL_1, buffer_bl1, sizeof(buffer_bl1));
    // memcpy(&top->BL_2, buffer_bl2, sizeof(buffer_bl2));
    // memcpy(&top->WL, buffer_wl, sizeof(buffer_wl));
    update();
    printf("[ log ]: Weight update complete.\n");   
}

float alu_math::forward(int sin_flag, float x){
    update();
    float f_zero = 0.1;
    // top->rst_n = 1;
    // top->sin_op_en = sin_flag;
    // top->sin_op_en = sin_flag;
    // top->cos_op_en = ~sin_flag;
    // top->sin_rb = *((uint32_t*)&x);
    // top->cos_rb = *((uint32_t*)&x);
    //printf("top->sin_rb = %f\n", float(top->sin_rb));
    //printf("top->cos_rb = %f\n", float(top->cos_rb));

    // while ((top->dout_valid_sin == 0)) {
    //     update();
    //     // printf("computing\n");
    //     // printf("top->sin_ra = %f\n", *((float*)&top->sin_ra));
    // }
    // printf("top->dout_valid_sin = %d\n", int(top->dout_valid_sin));
    // printf("top->sin_ra = %f\n", float(top->sin_ra));
    float alu_math_data;
    // alu_math_data = *((float*)&top->sin_ra);
    // top->rst_n = 0;
    update();
    // printf("top->sin_ra = %f\n", *((float*)&top->sin_ra));
    // while(1){
    //     int a = 1;
    // }
    return alu_math_data;
}


