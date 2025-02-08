
#include "Vtop.h"
#include "hw_cim.h"

static int align_check(uint64_t addr);
void axi_ch0_w();
void axi_ch1_w();
void axi_ch0_r();
void axi_ch1_r();

void dma_wait();