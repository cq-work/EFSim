#include "../config.h"
#include "accel_params.h"
#include "hw_cim.h"
#include "Vtop.h"
#include "dma.h"




extern Vtop *top;
#ifdef WAVE_LOG
extern VerilatedVcdC *tfp; // 导出vcd波形需要加此语句
#endif
int wave_cnt = 1;
int sim_cycle = 600;
int sim_cnt = 0;
int wu_cnt = 0;
int fc_cnt = 0;
double fc_real_cnt = 0.0;
int pr_cnt = 100;
int ppr_cnt = 100;

time_t start_time, end_time;
double execution_time_hw = 0;


hw_cim::hw_cim(){
    this->ifm_in = 0;
    this->ifm_wgt = 0;
}

void hw_cim::initial() {
    top->clock = 0;
    top->reset = 1;
    top->io_din_valid_ConV = 0;
    update();
    update();
    top->reset = 0;
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
    // initial();
    wu_cnt += 1;
    top->io_input_data_valid = 0;
    int occupy_array = (std::ceil((float (weight_mat[0].size())) / float (WL_NUM)));
    int reuse_time = (TILE_NUM*TILE2PE_NUM) / occupy_array;  
    signed int buffer_bl1[WL_NUM*BL_NUM*TILE_NUM/(DMA_CH_WIDTH*32)] = {0}, buffer_bl2[WL_NUM*BL_NUM*TILE_NUM/(DMA_CH_WIDTH*32)] = {0};      //32 is datawidth of int.
    int cim_array[TOTAL_ROW][PE2ARRAY_NUM*ARRAY_COL] = {{0}};

    for (int wl = 0; wl < WL_NUM; wl++) {           
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
                    for (int i = 0; i < 8; i++) {
                        cim_array[wl + WL_NUM*r*occupy_array + WL_NUM*array_col_cnt][bl*8 + i] = (wr_data >> (7-i)) & 1;   //to calculate power
                    }
                    
                    if (bl_cnt < TOTAL_COL / DMA_CH_WIDTH) {
                        buffer_bl1[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + bl_cnt/(32/UNIT_COL)] = buffer_bl1[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + bl_cnt/(32/UNIT_COL)] | (wr_data << (BIT_NUM*(bl_cnt % (32/UNIT_COL))));        //在这里写硬件，一步步把权重写进去
                    } else {
                        buffer_bl2[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + (bl_cnt-TOTAL_COL/DMA_CH_WIDTH)/(32/UNIT_COL)] = buffer_bl2[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + (bl_cnt-TOTAL_COL/DMA_CH_WIDTH)/(32/UNIT_COL)] | (wr_data << (BIT_NUM*((bl_cnt-TOTAL_COL/DMA_CH_WIDTH) % (32/UNIT_COL))));
                    }
                }
            }    
        }   
    }
    
    signed int *io_dma_ch0_r_addr = buffer_bl1;
    signed int *io_dma_ch1_r_addr = buffer_bl2;
    top->io_dma_ch0_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch0_r_addr);
    top->io_dma_ch0_r_dmaSize = BL_NUM*WL_NUM*TILE_NUM/(DMA_DATA_WIDTH*DMA_CH_WIDTH);
    top->io_dma_ch0_r_dmaAreq = 1; 
    top->io_dma_ch0_r_dmaEn = 1;

    if (DMA_CH_WIDTH >= 2) {
        top->io_dma_ch1_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch1_r_addr);
        top->io_dma_ch1_r_dmaSize = BL_NUM*WL_NUM*TILE_NUM/(DMA_DATA_WIDTH*DMA_CH_WIDTH);
        top->io_dma_ch1_r_dmaAreq = 1;
        top->io_dma_ch1_r_dmaEn = 1;
    }
    top->io_wgt_data_valid = 1;
    dma_wait();  
    top->io_dma_ch0_r_dmaAreq = 0; 
    top->io_dma_ch1_r_dmaAreq = 0;   
    printf("[ log ]: Weight update complete.\n");
}

std::vector<std::vector<int>> hw_cim::forward(int occupy_array, std::vector<signed char>input_mat, double utili_compute_unit){
    fc_real_cnt += utili_compute_unit;
    fc_cnt += 1;
    top->io_wgt_data_valid = 0;
    top->io_input_data_valid = 1;
    int pipeline_cnt = 0;
    if (PIPELINE_CNT) {
        pipeline_cnt = 2;
    }
    std::vector<std::vector<int>> out;
    if (pipeline_cnt) {
        out = get_output(occupy_array); //得到64个部分积
        top->io_din_valid_ConV = 1;
        while(top->io_buffer_busy) {
            update();
        }
    }
    
    signed int buffer_in1[TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*32)] = {0}, buffer_in2[TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*32)] = {0};
    for (int i = 0; i < BIT_NUM; i++) {
        for (int j = 0; j < input_mat.size(); j++) {
            unsigned char input_data_tmp = input_mat[j];
            unsigned char in_bit = (input_data_tmp >> i) & 1;
            if (j < TOTAL_ROW/DMA_CH_WIDTH) {
                buffer_in1[(j+i*TOTAL_ROW/DMA_CH_WIDTH)/32] += in_bit * (unsigned int) pow(2, j % 32);
            } else {
                buffer_in2[(j-TOTAL_ROW/DMA_CH_WIDTH+i*TOTAL_ROW/DMA_CH_WIDTH)/32] += in_bit * (unsigned int) pow(2, j % 32);
            }
        }       //在这写硬件，一次输入1024个值
    }

    signed int *io_dma_ch0_r_addr = buffer_in1;
    signed int *io_dma_ch1_r_addr = buffer_in2;
    top->io_dma_ch0_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch0_r_addr);
    top->io_dma_ch0_r_dmaSize = TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
    top->io_dma_ch0_r_dmaAreq = 1;
    top->io_dma_ch0_r_dmaEn = 1;

    if (DMA_CH_WIDTH >= 2) {
        top->io_dma_ch1_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch1_r_addr);
        top->io_dma_ch1_r_dmaSize = TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
        top->io_dma_ch1_r_dmaAreq = 1;
        top->io_dma_ch1_r_dmaEn = 1;
    }

    if (!pipeline_cnt) {
        top->io_din_valid_ConV = 1;
    }

    dma_wait();
    top->io_dma_ch0_r_dmaAreq = 0;
    top->io_dma_ch1_r_dmaAreq = 0;
    if (!pipeline_cnt) {
        top->io_din_valid_ConV = 0;
        out = get_output(occupy_array); //得到64个部分积
    }
    return out;
}



std::vector<std::vector<int>> hw_cim::get_output(int occupy_array) {
    std::vector<int> output_tmp;
    std::vector<std::vector<int>> output_data_row;
    std::vector<std::vector<std::vector<int>>> output_data;
    for (int i = 0; i < TILE_NUM*TILE2PE_NUM; i++) {
        output_data.push_back(output_data_row);
        for (int j = 0; j < PE2ARRAY_NUM; j++) {
            output_data[i].push_back(output_tmp);
        }
    }

    std::vector<std::vector<int>> output;
    int reuse_time = (TILE_NUM*TILE2PE_NUM) / occupy_array;
    for (int i = 0; i < reuse_time; i++) {
        output.push_back(output_tmp);
    }
    int buffer[DMA_CH_WIDTH][ARRAY_NUM/DMA_CH_WIDTH + 1][UNIT_NUM] = {{{1}}};
    int (*io_dma_ch0_w_addr)[UNIT_NUM] = buffer[0];

    top->io_dma_ch0_w_dmaAddr = reinterpret_cast<QData>(io_dma_ch0_w_addr);
    top->io_dma_ch0_w_dmaSize = TOTAL_COL*O_WIDTH/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
    top->io_dma_ch0_w_dmaAreq = 1;
    top->io_dma_ch0_w_dmaEn = 1;

    if (DMA_CH_WIDTH >= 2) {
        int (*io_dma_ch1_w_addr)[UNIT_NUM] = buffer[1];
        top->io_dma_ch1_w_dmaAddr = reinterpret_cast<QData>(io_dma_ch1_w_addr);
        top->io_dma_ch1_w_dmaSize = TOTAL_COL*O_WIDTH/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
        top->io_dma_ch1_w_dmaAreq = 1;
        top->io_dma_ch1_w_dmaEn = 1;
    }

    dma_wait();
    top->io_dma_ch0_w_dmaAreq = 0;
    top->io_dma_ch1_w_dmaAreq = 0;
    
    for (int ou = 0; ou < UNIT_NUM; ou++) {
        for (int i = 0; i < ARRAY_NUM/DMA_CH_WIDTH; i++) {
            int ou_tmp = buffer[0][ARRAY_NUM/DMA_CH_WIDTH-1-i][UNIT_NUM-1-ou];
            output_data[i/PE2ARRAY_NUM+(DMA_CH_WIDTH-1)*TILE_NUM*TILE2PE_NUM/DMA_CH_WIDTH][i%PE2ARRAY_NUM].push_back(ou_tmp);
            if (DMA_CH_WIDTH >= 2) {
                int ou_tmp2 = buffer[1][ARRAY_NUM/DMA_CH_WIDTH-1-i][UNIT_NUM-1-ou];
                output_data[i/PE2ARRAY_NUM][i%PE2ARRAY_NUM].push_back(ou_tmp2);   
            }
        }
    }
    for (int k = 0; k < reuse_time; k++) {
        for (int l = 0; l < PE2ARRAY_NUM; l++) {
            for (int p = 0; p < UNIT_NUM; p++) {
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




// void hw_cim::initial() {
//     top->clock = 0;
//     top->reset = 1;
//     top->io_din_valid_ConV = 0;
//     update();
//     update();
//     top->reset = 0;
// }

// void hw_cim::update() {
//     start_time = time(NULL);
//     top->clock = 1;
//     top->eval();
//     #ifdef WAVE_LOG
//     if (sim_cnt < sim_cycle) {
//         tfp->dump(sim_cnt);
//     } else {
//         tfp->close();
//         if (wave_cnt) {
//             printf("wave finished\n");
//             wave_cnt = 0;
//         }
//     }
//     #endif
//     sim_cnt += 1;

//     top->clock = 0;
//     top->eval();
//     end_time = time(NULL);
//     execution_time_hw += difftime(end_time, start_time);
    
//     #ifdef WAVE_LOG
//     if (sim_cnt < sim_cycle) {
//         tfp->dump(sim_cnt);
//     } else {
//         tfp->close();
//         if (wave_cnt) {
//             printf("wave finished\n");
//             wave_cnt = 0;
//         }
//     }
//     #endif
//     sim_cnt += 1;
// }

// void hw_cim::weight_update(std::vector<std::vector<signed char>>weight_mat) {      //weight_mat的尺寸是列×行 
//     // initial();
//     top->io_input_data_valid = 0;
//     int occupy_array = (std::ceil((float (weight_mat[0].size())) / float (WL_NUM)));
//     int reuse_time = (TILE_NUM*TILE2PE_NUM) / occupy_array;  
//     signed int buffer_bl1[WL_NUM*BL_NUM*TILE_NUM/(DMA_CH_WIDTH*32)] = {0}, buffer_bl2[WL_NUM*BL_NUM*TILE_NUM/(DMA_CH_WIDTH*32)] = {0};      //32 is datawidth of int.
//     int cim_array[TOTAL_ROW][PE2ARRAY_NUM*ARRAY_COL] = {{0}};

//     for (int wl = 0; wl < WL_NUM; wl++) {           
//         for (int r = 0; r < reuse_time; r++) {
//             for (int array_col_cnt = 0; array_col_cnt < occupy_array; array_col_cnt++) {
//                 for (int bl = 0; bl < NUM_COL; bl++) {
//                     unsigned char wr_data;
//                     int bl_cnt = r*occupy_array*NUM_COL + array_col_cnt*NUM_COL + bl;
                    
//                     if (((array_col_cnt*WL_NUM+wl) > weight_mat[0].size()-1) || (bl > weight_mat.size()-1)) {
//                         wr_data = 0;
//                     } else {
//                         wr_data = weight_mat[bl][array_col_cnt*WL_NUM+wl];
//                     }
//                     for (int i = 0; i < 8; i++) {
//                         cim_array[wl + WL_NUM*r*occupy_array + WL_NUM*array_col_cnt][bl*8 + i] = (wr_data >> (7-i)) & 1;   //to calculate power
//                     }
                    
//                     if (bl_cnt < TOTAL_COL / DMA_CH_WIDTH) {
//                         buffer_bl1[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + bl_cnt/(32/UNIT_COL)] = buffer_bl1[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + bl_cnt/(32/UNIT_COL)] | (wr_data << (BIT_NUM*(bl_cnt % (32/UNIT_COL))));        //在这里写硬件，一步步把权重写进去
//                     } else {
//                         buffer_bl2[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + (bl_cnt-TOTAL_COL/DMA_CH_WIDTH)/(32/UNIT_COL)] = buffer_bl2[wl*TILE_NUM*BL_NUM / (DMA_CH_WIDTH*32) + (bl_cnt-TOTAL_COL/DMA_CH_WIDTH)/(32/UNIT_COL)] | (wr_data << (BIT_NUM*((bl_cnt-TOTAL_COL/DMA_CH_WIDTH) % (32/UNIT_COL))));
//                     }
//                 }
//             }    
//         }   
//     }
    
//     signed int *io_dma_ch0_r_addr = buffer_bl1;
//     signed int *io_dma_ch1_r_addr = buffer_bl2;
//     top->io_dma_ch0_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch0_r_addr);
//     top->io_dma_ch0_r_dmaSize = BL_NUM*WL_NUM*TILE_NUM/(DMA_DATA_WIDTH*DMA_CH_WIDTH);
//     top->io_dma_ch0_r_dmaAreq = 1;
//     top->io_dma_ch0_r_dmaEn = 1;

//     if (DMA_CH_WIDTH >= 2) {
//         top->io_dma_ch1_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch1_r_addr);
//         top->io_dma_ch1_r_dmaSize = BL_NUM*WL_NUM*TILE_NUM/(DMA_DATA_WIDTH*DMA_CH_WIDTH);
//         top->io_dma_ch1_r_dmaAreq = 1;
//         top->io_dma_ch1_r_dmaEn = 1;
//     }

//     top->io_wgt_data_valid = 1;
    
//     dma_wait();
//     printf("[ log ]: Weight update complete.\n");
// }

// std::vector<std::vector<int>> hw_cim::forward(int occupy_array, std::vector<signed char>input_mat){
//     top->io_wgt_data_valid = 0;
//     top->io_input_data_valid = 1;
//     int pipeline_cnt = 0;
//     if (PIPELINE_CNT) {
//         pipeline_cnt = 2;
//     }
//     std::vector<std::vector<int>> out;
//     if (pipeline_cnt) {
//         out = get_output(occupy_array); //得到64个部分积
//         top->io_din_valid_ConV = 1;
//         while(top->io_buffer_busy) {
//             update();
//         }
//     }
    
//     signed int buffer_in1[TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*32)] = {0}, buffer_in2[TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*32)] = {0};
//     for (int i = 0; i < BIT_NUM; i++) {
//         for (int j = 0; j < input_mat.size(); j++) {
//             unsigned char input_data_tmp = input_mat[j];
//             unsigned char in_bit = (input_data_tmp >> i) & 1;
//             if (j < TOTAL_ROW/DMA_CH_WIDTH) {
//                 buffer_in1[(j+i*TOTAL_ROW/DMA_CH_WIDTH)/32] += in_bit * (unsigned int) pow(2, j % 32);
//             } else {
//                 buffer_in2[(j-TOTAL_ROW/DMA_CH_WIDTH+i*TOTAL_ROW/DMA_CH_WIDTH)/32] += in_bit * (unsigned int) pow(2, j % 32);
//             }
//         }       //在这写硬件，一次输入1024个值
//     }

//     signed int *io_dma_ch0_r_addr = buffer_in1;
//     signed int *io_dma_ch1_r_addr = buffer_in2;
//     top->io_dma_ch0_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch0_r_addr);
//     top->io_dma_ch0_r_dmaSize = TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
//     top->io_dma_ch0_r_dmaAreq = 1;
//     top->io_dma_ch0_r_dmaEn = 1;

//     if (DMA_CH_WIDTH >= 2) {
//         top->io_dma_ch1_r_dmaAddr = reinterpret_cast<QData>(io_dma_ch1_r_addr);
//         top->io_dma_ch1_r_dmaSize = TOTAL_ROW*BIT_NUM/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
//         top->io_dma_ch1_r_dmaAreq = 1;
//         top->io_dma_ch1_r_dmaEn = 1;
//     }


//     if (!pipeline_cnt) {
//         top->io_din_valid_ConV = 1;
//     }
//     dma_wait();
//     if (!pipeline_cnt) {
//         top->io_din_valid_ConV = 0;
//         out = get_output(occupy_array); //得到64个部分积
//     }
    
//     return out;
// }



// std::vector<std::vector<int>> hw_cim::get_output(int occupy_array) {
//     std::vector<int> output_tmp;
//     std::vector<std::vector<int>> output_data_row;
//     std::vector<std::vector<std::vector<int>>> output_data;
//     for (int i = 0; i < TILE_NUM*TILE2PE_NUM; i++) {
//         output_data.push_back(output_data_row);
//         for (int j = 0; j < PE2ARRAY_NUM; j++) {
//             output_data[i].push_back(output_tmp);
//         }
//     }

//     std::vector<std::vector<int>> output;
//     int reuse_time = (TILE_NUM*TILE2PE_NUM) / occupy_array;
//     for (int i = 0; i < reuse_time; i++) {
//         output.push_back(output_tmp);
//     }
//     int buffer[DMA_CH_WIDTH][ARRAY_NUM/DMA_CH_WIDTH][UNIT_NUM] = {{{0}}};
//     int (*io_dma_ch0_w_addr)[UNIT_NUM] = buffer[0];

//     top->io_dma_ch0_w_dmaAddr = reinterpret_cast<QData>(io_dma_ch0_w_addr);
//     top->io_dma_ch0_w_dmaSize = TOTAL_COL*O_WIDTH/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
//     top->io_dma_ch0_w_dmaAreq = 1;
//     top->io_dma_ch0_w_dmaEn = 1;

//     if (DMA_CH_WIDTH >= 2) {
//         int (*io_dma_ch1_w_addr)[UNIT_NUM] = buffer[1];
//         top->io_dma_ch1_w_dmaAddr = reinterpret_cast<QData>(io_dma_ch1_w_addr);
//         top->io_dma_ch1_w_dmaSize = TOTAL_COL*O_WIDTH/(DMA_CH_WIDTH*DMA_DATA_WIDTH);
//         top->io_dma_ch1_w_dmaAreq = 1;
//         top->io_dma_ch1_w_dmaEn = 1;
//     }
    
//     dma_wait();
    
//     for (int ou = 0; ou < UNIT_NUM; ou++) {
//         for (int i = 0; i < ARRAY_NUM/DMA_CH_WIDTH; i++) {
//             int ou_tmp = buffer[0][ARRAY_NUM/DMA_CH_WIDTH-1-i][UNIT_NUM-1-ou];
//             output_data[i/PE2ARRAY_NUM+(DMA_CH_WIDTH-1)*TILE_NUM*TILE2PE_NUM/DMA_CH_WIDTH][i%PE2ARRAY_NUM].push_back(ou_tmp);
//             if (DMA_CH_WIDTH >= 2) {
//                 int ou_tmp2 = buffer[1][ARRAY_NUM/DMA_CH_WIDTH-1-i][UNIT_NUM-1-ou];
//                 output_data[i/PE2ARRAY_NUM][i%PE2ARRAY_NUM].push_back(ou_tmp2);
//             }
            
//         }
//     }

//     for (int k = 0; k < reuse_time; k++) {
//         for (int l = 0; l < PE2ARRAY_NUM; l++) {
//             for (int p = 0; p < UNIT_NUM; p++) {
//                 int num_tmp;
//                 for (int j = 0; j < occupy_array; j++) {
//                     if (j == 0) {
//                         num_tmp = output_data[k*occupy_array][l][p];
//                     } else {
//                         num_tmp += output_data[k*occupy_array+j][l][p];
//                     }
//                 }
//                 output[k].push_back(num_tmp);
//             }
//         }
//     }
    
//     return output;      //output的尺寸是8/reuse time行，64列
// }