#include "../config.h"
#include "accel_params.h"
#include "hw_cim.h"
#include "../veri.h"
// #include "Vtop.h"



extern Vtop *top;
#ifdef WAVE_LOG
extern VerilatedVcdC *tfp; // export .vcd waveform
#endif
int wave_cnt = 1;
int sim_cycle = 600;       // wave.vcd simulation cycles
int sim_cnt = 0;
int wu_cnt = 0;
int fc_cnt = 0;
double fc_real_cnt = 0.0;
int pr_cnt = 3;

time_t start_time, end_time;
double execution_time_hw = 0;

hw_cim::hw_cim(){
    this->ifm_in = 0;
    this->ifm_wgt = 0;
}

void hw_cim::initial() {
    // top->io_function_mode = 1;
    top->clock = 0;
    top->reset = 1;
    top->io_din_valid_ConV = 0;
    update();
    top->reset = 0;
    update();
    // update();
}

void hw_cim::update() {
    start_time = time(NULL);
    top->clock = 1;
    top->eval();
    #ifdef WAVE_LOG
    if (sim_cnt < sim_cycle) {
        tfp->dump(sim_cnt);
    } else {
        tfp->close();
        if (wave_cnt) {
            printf("[ log ]: wave finished\n");
            wave_cnt = 0;
        }
    }
    #endif
    sim_cnt += 1;
    
    top->clock = 0;
    top->eval();
    end_time = time(NULL);
    execution_time_hw += difftime(end_time, start_time);

    #ifdef WAVE_LOG
    if (sim_cnt < sim_cycle) {
        tfp->dump(sim_cnt);
    } else {
        tfp->close();
        if (wave_cnt) {
            printf("[ log ]: wave finished\n");
            wave_cnt = 0;
        }
    }
    #endif
    sim_cnt += 1;
}

void hw_cim::weight_update(std::vector<std::vector<signed char>>weight_mat) {      //weight_mat的尺寸是列×行 
    initial();
    wu_cnt += 1;
    int occupy_array = (std::ceil((float (weight_mat[0].size())) / 128.0));
    int reuse_time = NUM_ARRAY_ROW / occupy_array;  
    int reuse_time_col1 = (TOTAL_COL/BIT_NUM) / weight_mat.size();   
    int reuse_time_col2 = (TOTAL_ROW/reuse_time) / (weight_mat[0].size()/3) - 2;
    int reuse_time_col = std::min(reuse_time_col1, reuse_time_col2);
    for (int wl = 0; wl < WL_NUM; wl++) {
        unsigned char buffer_bl1[64] = {0}, buffer_wl[16] = {0};
        for (int r = 0; r < reuse_time; r++) {
            for (int array_col_cnt = 0; array_col_cnt < occupy_array; array_col_cnt++) {
                for (int bl = 0; bl < NUM_COL; bl++) {
                    unsigned char wr_data;
                    int bl_cnt = r*occupy_array*NUM_COL + array_col_cnt*NUM_COL + bl;
                    
                    if (((array_col_cnt*WL_NUM+wl) > weight_mat[0].size()-1) || (bl > weight_mat.size()-1)) {
                        wr_data = 0;
                    } else {
                        wr_data = weight_mat[bl][array_col_cnt*WL_NUM+wl];
                    }

                    // if ((bl == 0) && (r == 0) && (array_col_cnt == 0)) {
                    //     printf("wr_data:%d\n", wr_data);
                    // }

                    if (bl_cnt < 64) {
                        buffer_bl1[bl_cnt] = wr_data;       //在这里写硬件，一步步把权重写进去
                        // buffer_bl1[bl_cnt] = 255;       //在这里写硬件，一步步把权重写进去
                    } else {
                        buffer_bl1[bl_cnt-64] = wr_data;
                        // buffer_bl2[bl_cnt-256] = 255;
                    }
                }
            }    
        }                      

        buffer_wl[wl/8] = (unsigned char) pow(2, wl % 8);     
        memcpy(&top->io_BL_1, buffer_bl1, sizeof(buffer_bl1));
        // memcpy(&top->io_BL_2, buffer_bl2, sizeof(buffer_bl2));
        memcpy(&top->io_WL, buffer_wl, sizeof(buffer_wl));
        update();
        // if (pr_cnt) {
        //     unsigned int a = top->BL_1[0];
        //     printf("top->BL_1[0]:%d\n", a & 255);
        //     printf("buffer_bl[0]:%d\n", buffer_bl1[0]);
        // }
        buffer_wl[wl/8] = 0;
    }

    unsigned char buffer_bl1[64] = {0}, buffer_bl2[256] = {0}, buffer_wl[16] = {0};
    memcpy(&top->io_BL_1, buffer_bl1, sizeof(buffer_bl1));
    // memcpy(&top->io_BL_2, buffer_bl2, sizeof(buffer_bl2));
    memcpy(&top->io_WL, buffer_wl, sizeof(buffer_wl));
    update();
    printf("[ log ]: Weight update complete.\n");
}

std::vector<std::vector<int>> hw_cim::forward(int occupy_array, std::vector<signed char>input_mat, double utili_compute_unit){
    std::vector<std::vector<int>> out;
    fc_real_cnt += utili_compute_unit;
    fc_cnt += 1;
    top->io_din_valid_ConV = 1;
    // top->eval();
    update();
    // if (clock_cnt) {
    //     update();
    //     clock_cnt = 0;
    //     printf("fuck?\n");
    // } else {
    //     // top->eval();
    //     update();
    // }
    for (int ii = 7; ii < BIT_NUM+7; ii++) {
        int i = ii % BIT_NUM;
        unsigned char buffer_in1[32] = {0}, buffer_in2[64] = {0};
        for (int j = 0; j < input_mat.size(); j++) {
            unsigned char input_data_tmp = input_mat[j];
            // if (j == input_mat.size()-1){
            //     printf("input_mat %d = %d\n",j,input_mat[j]);   
            // }
            unsigned char in_bit = (input_data_tmp >> i) & 1;
            // unsigned char in_bit = 1;

            if (j < 512) {
                buffer_in1[j/8] += in_bit * (unsigned char) pow(2, j % 8);
            } else {
                buffer_in2[(j-512)/8] += in_bit * (unsigned char) pow(2, j % 8);
            }       //得到1024*1的向量

            // if ((j < 128) && (pr_cnt)) {
            //     printf("in_data:%d,bit_num:%d,in_bit:%d\n", input_mat[j], i,in_bit);
            // }

            // if ((j < 512) && (i<7)) {
            //     buffer_in1[0] = 176;
            //     buffer_in1[1] = 97;
            //     buffer_in1[2] = 195;
            //     buffer_in1[3] = 6;
            // } else {
            //     buffer_in2[15] = 1;
            // }       
        }       //在这写硬件，一次输入1024个值
        
        memcpy(&top->io_IN_1, buffer_in1, sizeof(buffer_in1));
        // memcpy(&top->io_IN_2, buffer_in2, sizeof(buffer_in2));
        update();

        // if (pr_cnt) {
        //     unsigned int a = top->IN_1[0];
        //     printf("topin1:\n");
        //     for (int i = 0; i < 32; i++) {  
        //         printf("%d,", (a & (unsigned int) pow(2, i)) && 1);
        //     }
        //     printf("\n");
        // }
    }
    
    while ((top->io_dout_valid_ConV == 0)) {
        update();
    }
    update();
    out = get_output(occupy_array); //得到64个部分积
    // update();
    // while(1){
    //     int a = 1;
    // }
    return out;
}

std::vector<std::vector<int>> hw_cim::get_output(int occupy_array) {
    std::vector<int> output_tmp, output_data0, output_data1, output_data2, output_data3, output_data4, output_data5, output_data6, output_data7, 
                        output_data8, output_data9, output_data10, output_data11, output_data12, output_data13, output_data14, output_data15, 
                        output_data16, output_data17, output_data18, output_data19, output_data20, output_data21, output_data22, output_data23,
                        output_data24, output_data25, output_data26, output_data27, output_data28, output_data29, output_data30, output_data31;
    
    std::vector<std::vector<int>> output_data_row0, output_data_row1, output_data_row2, output_data_row3, output_data_row4, output_data_row5, output_data_row6, output_data_row7;
    output_data_row0 = {output_data0, output_data1, output_data2, output_data3};
    output_data_row1 = {output_data4, output_data5, output_data6, output_data7};
    output_data_row2 = {output_data8, output_data9, output_data10, output_data11};
    output_data_row3 = {output_data12, output_data13, output_data14, output_data15};
    output_data_row4 = {output_data16, output_data17, output_data18, output_data19};
    output_data_row5 = {output_data20, output_data21, output_data22, output_data23};
    output_data_row6 = {output_data24, output_data25, output_data26, output_data27};
    output_data_row7 = {output_data28, output_data29, output_data30, output_data31};
    
    std::vector<std::vector<std::vector<int>>> output_data = {output_data_row0, output_data_row1, output_data_row2, output_data_row3, output_data_row4, output_data_row5, output_data_row6, output_data_row7};
    
    std::vector<std::vector<int>> output;
    int reuse_time = (TOTAL_ROW/WL_NUM) / occupy_array;
    for (int i = 0; i < reuse_time; i++) {
        output.push_back(output_tmp);
    }
    unsigned char buffer[4][64] = {{0}};
    memcpy(buffer[3], &top->io_sum_out_1_0_0, 64);
    memcpy(buffer[2], &top->io_sum_out_1_0_1, 64);
    // memcpy(buffer[13], &top->io_sum_out_1_0_2, 64);
    // memcpy(buffer[12], &top->io_sum_out_1_0_3, 64);
    memcpy(buffer[1], &top->io_sum_out_1_1_0, 64);
    memcpy(buffer[0], &top->io_sum_out_1_1_1, 64);
    // memcpy(buffer[9], &top->io_sum_out_1_1_2, 64);
    // memcpy(buffer[8], &top->io_sum_out_1_1_3, 64);
    // memcpy(buffer[7], &top->io_sum_out_1_2_0, 64);
    // memcpy(buffer[6], &top->io_sum_out_1_2_1, 64);
    // memcpy(buffer[5], &top->io_sum_out_1_2_2, 64);
    // memcpy(buffer[4], &top->io_sum_out_1_2_3, 64);
    // memcpy(buffer[3], &top->io_sum_out_1_3_0, 64);
    // memcpy(buffer[2], &top->io_sum_out_1_3_1, 64);
    // memcpy(buffer[1], &top->io_sum_out_1_3_2, 64);
    // memcpy(buffer[0], &top->io_sum_out_1_3_3, 64);
    // memcpy(buffer[31], &top->io_sum_out_2_0_0, 64);
    // memcpy(buffer[30], &top->io_sum_out_2_0_1, 64);
    // memcpy(buffer[29], &top->io_sum_out_2_0_2, 64);
    // memcpy(buffer[28], &top->io_sum_out_2_0_3, 64);
    // memcpy(buffer[27], &top->io_sum_out_2_1_0, 64);
    // memcpy(buffer[26], &top->io_sum_out_2_1_1, 64);
    // memcpy(buffer[25], &top->io_sum_out_2_1_2, 64);
    // memcpy(buffer[24], &top->io_sum_out_2_1_3, 64);
    // memcpy(buffer[23], &top->io_sum_out_2_2_0, 64);
    // memcpy(buffer[22], &top->io_sum_out_2_2_1, 64);
    // memcpy(buffer[21], &top->io_sum_out_2_2_2, 64);
    // memcpy(buffer[20], &top->io_sum_out_2_2_3, 64);
    // memcpy(buffer[19], &top->io_sum_out_2_3_0, 64);
    // memcpy(buffer[18], &top->io_sum_out_2_3_1, 64);
    // memcpy(buffer[17], &top->io_sum_out_2_3_2, 64);
    // memcpy(buffer[16], &top->io_sum_out_2_3_3, 64);

    // if (pr_cnt) {
    //     for (int i = 0; i < 32; i++) {
    //         printf("\nbuffer[%d]:",i);
    //         for (int j = 15; j > -1; j--) {
    //             printf("\n");
    //             for (int k = 3; k > -1; k--) {
    //                 printf("%d,",buffer[i][j*4+k]);
    //             }
    //         }
    //     }
    //     pr_cnt += -1;
    // }
    for (int ou = 0; ou < 16; ou++) {
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 2; j++) {
                int ou_tmp = buffer[i*2+j][63-(ou*4+3)] + buffer[i*2+j][63-(ou*4+2)]*256 + buffer[i*2+j][63-(ou*4+1)]*65536 + buffer[i*2+j][63-ou*4]*16777216;
                output_data[i][j].push_back(ou_tmp);
            }
        }
    }
    // if (pr_cnt) {
    //     printf("sum:\n");
    //     for (int i = 0; i < 4; i++) {  
    //         printf("%d\n",buffer[0][63-i]);
    //     }
    //     printf("%d\n", output_data[0][0][0]);
    //     pr_cnt += -1;

    //     for (int i = 0; i < 8; i++) {
    //         for (int j = 0; j < 4; j++) {
    //             for (int ou = 0; ou < 16; ou++) {
    //                 printf("output[%d][%d][%d]:%d\n", i,j,ou,output_data[i][j][ou]);
    //             }
    //         }
    //     }

    // }

    if (pr_cnt) {
        // for (int i = 0; i < 4; i++) {
        //     printf("outputdata[%d][0][0]:%d.\n",i,output_data[i][0][1]);
        // }
        // printf("outputdata0:%d.\n",output_data[0][0][1]+output_data[1][0][1]+output_data[2][0][1]+output_data[3][0][1]);
        pr_cnt += -1;
    }

    for (int k = 0; k < reuse_time; k++) {
        for (int l = 0; l < 2; l++) {
            for (int p = 0; p < 16; p++) {
                int num_tmp;
                for (int j = 0; j < occupy_array; j++) {
                    if (j == 0) {
                        num_tmp = output_data[k*occupy_array][l][p];
                    } else {
                        num_tmp += output_data[k*occupy_array+j][l][p];
                    }
                }
                output[k].push_back(num_tmp);
            }
        }
    }
    return output;      //output的尺寸是8/reuse time行，64列
}




