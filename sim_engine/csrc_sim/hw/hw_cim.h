#ifndef __HW_GEMM_H_
#define __HW_GEMM_H_

#include "../ncnn/mat.h"
#include "../veri.h"
#include "Vtop.h"

// extern Vtop *top;

class hw_cim{
public :
    int ifm_in;
    int ifm_wgt;

public :
    hw_cim();
    void initial();
    void update();
    // void weight_update(std::vector<std::vector<unsigned char>>weight_mat, int occupy_array);
    void weight_update(std::vector<std::vector<signed char>>weight_mat);
    std::vector<std::vector<int>> forward(int occupy_array, std::vector<signed char>input_mat, double utili_compute_unit);
    std::vector<std::vector<int>> get_output(int occupy_array);
};




#endif