#ifndef __VERI_H__
#define __VERI_H__

//#include "verilated_vcd_c.h"
//#include "Vtcp.h"
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "ncnn/mat.h"
#include "hw/hw_cim.h"
#include <cerrno>

#include "verilated_vcd_c.h"
#include "Vtop.h"


extern vluint64_t main_time;

extern Vtop *top;
#ifndef BATCH_TEST
extern VerilatedVcdC* tfp;
#endif

void update();
#endif