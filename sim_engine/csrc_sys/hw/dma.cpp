#include "dma.h"
#include "Vtop.h"
#include "hw_cim.h"
#include "../config.h"
#include <queue>

extern Vtop *top;
#ifdef WAVE_LOG
extern VerilatedVcdC *tfp; // 导出vcd波形需要加此语句
#endif

extern double execution_time_hw;
extern int sim_cnt;

int prr_cnt = 10;

static int dma_ch1_read_busy = 0;
static uint32_t dma_ch1_read_size = 0;
static uint64_t dma_ch1_read_addr = 0;
static int dma_ch1_read_count = 0;
static int dma_ch1_write_busy = 0;
static uint32_t dma_ch1_write_size = -1;
static uint64_t dma_ch1_write_addr = 0;
static int dma_ch1_write_count = 0;

static char flag_dma_ch1_read_valid = 0;
static int dma_ch1_read_valid_delay = 0;

static int dma_ch2_read_busy = 0;
static uint32_t dma_ch2_read_size = 0;
static uint64_t dma_ch2_read_addr = 0;
static int dma_ch2_read_count = 0;
static int dma_ch2_write_busy = 0;
static uint32_t dma_ch2_write_size = -1;
static uint64_t dma_ch2_write_addr = 0;
static int dma_ch2_write_count = 0;

static char flag_dma_ch2_read_valid = 0;
static int dma_ch2_read_valid_delay = 0;

static int dma_ch1_write_gp = 0;
static int dma_ch1_read_gp = 0;
static int dma_ch2_write_gp = 0;
static int dma_ch2_read_gp = 0;

int ch1_r_finish, ch2_r_finish, ch1_w_finish, ch2_w_finish = 0;

hw_cim inst;
int consis_cnt0 = 0;
int consis_cnt1 = 0;
int consis_out_cnt0 = 0;
int consis_out_cnt1 = 0;

// belowing is the new code
#define DELAY_VALID_R_ch1 24
#define DELAY_VALID_R_ch2 30
#define DELAY_VALID_W_ch1 24
#define DELAY_VALID_W_ch2 30
#define OUTSTANDING_DEPTH 16

static int align_check(uint64_t addr) {
    if (addr % (DMA_DATA_WIDTH / 8) == 0)
        return 0;
    return -1;
}

static std::queue<uint64_t> axi_ch1_read_addr;
static std::queue<uint32_t> axi_ch1_read_len;
static int axi_ch1_read_wait_cnt = 0;
static int io_axi_ch1_m_arready = 1;
static int io_axi_ch1_m_rvalid = 0;
static int io_axi_ch1_m_rlast = 0;
static uint32_t io_axi_ch1_m_rdata[4];
void axi_ch1_r() {
    if (axi_ch1_read_len.size() == 0) { // 4. delay control
        if (top->io_axi_ch1_m_arvalid && top->io_axi_ch1_m_arready) {
            axi_ch1_read_wait_cnt = 0;
        }
    } else if (!top->io_axi_ch1_m_rvalid) {
        if (axi_ch1_read_wait_cnt <= DELAY_VALID_R_ch1) {
            axi_ch1_read_wait_cnt++;
        } else {
            io_axi_ch1_m_rvalid = 1;
            // printf("[ log ]:main_time=%ld, axi_ch1_read_wait_cnt = %d, axi_ch1_read_len.size=%d\n", main_time, axi_ch1_read_wait_cnt,
            //        axi_ch1_read_len.size());
        }
    }

    if (top->io_axi_ch1_m_arvalid && top->io_axi_ch1_m_arready) { // 1. transaction req start
        axi_ch1_read_len.push(top->io_axi_ch1_m_arlen + 1);
        assert(top->io_axi_ch1_m_arsize == log2(DMA_DATA_WIDTH / 8));
        assert(top->io_axi_ch1_m_arburst == 1);
		// printf("read address : %lx\n", top->io_axi_ch1_m_araddr);
        for (int i = 0; i < (top->io_axi_ch1_m_arlen + 1); i++) {
            axi_ch1_read_addr.push((uint64_t)top->io_axi_ch1_m_araddr + i * AXI_TRANSFER_BYTE);
        }
        // printf("len_size:%d\n", axi_ch1_read_len.size());
#ifdef CHECK_ALIGN
        if (align_check(top->io_axi_ch1_m_araddr)) {
            printf("[ error ]: top->io_axi_ch1_m_araddr = %lx, NOT ALIGN!\n", top->io_axi_ch1_m_araddr);
            assert(0);
        }
#endif
        if (top->io_axi_ch1_m_araddr / 4096 != (top->io_axi_ch1_m_araddr + (top->io_axi_ch1_m_arlen + 1) * AXI_TRANSFER_BYTE - 1) / 4096) {
            printf("[ error ]: single transaction cross 4K address!\n");
        }

        if (axi_ch1_read_len.size() == OUTSTANDING_DEPTH) {
            io_axi_ch1_m_arready = 0;
        }
    } else if (!top->io_axi_ch1_m_arready && (axi_ch1_read_len.size() < OUTSTANDING_DEPTH) &&
               (top->io_axi_ch1_m_rvalid && top->io_axi_ch1_m_rlast)) { // outstanding depth not full
        io_axi_ch1_m_arready = 1;
    }

    if (top->io_axi_ch1_m_rlast && top->io_axi_ch1_m_rvalid && top->io_axi_ch1_m_rready) { // 3. after last read
        if (axi_ch1_read_len.size() == 0) {
            io_axi_ch1_m_rvalid = 0;
            io_axi_ch1_m_rlast = 0;
        } else if (axi_ch1_read_len.front() != 1) {
            io_axi_ch1_m_rvalid = 0;
            io_axi_ch1_m_rlast = 0;
        }
    }

    if (io_axi_ch1_m_rvalid) { // 2. read data
        assert(axi_ch1_read_len.size() != 0);
        assert(axi_ch1_read_len.front() != 0);
        for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
            io_axi_ch1_m_rdata[i] = *((int *)axi_ch1_read_addr.front() + i);
        }
        if (top->io_axi_ch1_m_rready) {
            axi_ch1_read_addr.pop();
            if (axi_ch1_read_len.front() == 1) { // 2.1 one transaction the last transfer
                axi_ch1_read_len.pop();
                io_axi_ch1_m_rlast = 1;
            } else { // 2.2 not the last transfer
                axi_ch1_read_len.front()--;
                io_axi_ch1_m_rlast = 0;
            }
        }
    }

    top->io_axi_ch1_m_arready = io_axi_ch1_m_arready;
    top->io_axi_ch1_m_rid = 0;
    top->io_axi_ch1_m_rresp = 0;
    top->io_axi_ch1_m_rvalid = io_axi_ch1_m_rvalid;
    for (int i = 0; i < 4; i++) {
        top->io_axi_ch1_m_rdata[i] = io_axi_ch1_m_rdata[i];
    }
    top->io_axi_ch1_m_rlast = io_axi_ch1_m_rlast;
}

static std::queue<uint64_t> axi_ch1_write_addr;
static std::queue<uint32_t> axi_ch1_write_len;
static int axi_ch1_write_resp = 0;
static int axi_ch1_write_wait_cnt = 0;
static int io_axi_ch1_m_awready = 1;
static int io_axi_ch1_m_wready = 0;
static int io_axi_ch1_m_bvalid = 0;
void axi_ch1_w() {
    if (axi_ch1_write_len.size() == 0) { // 4. delay control
        if (top->io_axi_ch1_m_awvalid && top->io_axi_ch1_m_awready) {
            axi_ch1_write_wait_cnt = 0;
        }
    } else if (!top->io_axi_ch1_m_wready) {
        if (axi_ch1_write_wait_cnt <= DELAY_VALID_W_ch1) {
            axi_ch1_write_wait_cnt++;
            // printf("wait_cnt:%d\n", axi_ch1_write_wait_cnt);
        } else {
            io_axi_ch1_m_wready = 1;
        }
    }

    if (top->io_axi_ch1_m_awvalid && top->io_axi_ch1_m_awready) { // 1. transaction req start
        // axi_ch1_write_addr.push(top->io_axi_ch1_m_awaddr);
        axi_ch1_write_len.push(top->io_axi_ch1_m_awlen + 1);
        
        assert(top->io_axi_ch1_m_awsize == log2(DMA_DATA_WIDTH / 8));
        assert(top->io_axi_ch1_m_awburst == 1);
        for (int i = 0; i < (top->io_axi_ch1_m_awlen + 1); i++) {
            axi_ch1_write_addr.push((uint64_t)top->io_axi_ch1_m_awaddr + i * AXI_TRANSFER_BYTE);
        }
#ifdef CHECK_ALIGN
        if (align_check(top->io_axi_ch1_m_awaddr)) {
            printf("[ error ]: top->io_axi_ch1_m_awaddr = %lx, NOT ALIGN!\n", top->io_axi_ch1_m_awaddr);
            assert(0);
        }
#endif
        if (top->io_axi_ch1_m_awaddr / 4096 != (top->io_axi_ch1_m_awaddr + (top->io_axi_ch1_m_awlen + 1) * AXI_TRANSFER_BYTE - 1) / 4096) {
            printf("[ error ]: single transaction cross 4K address!\n");
        }
        // printf("start:%lx, end:%lx, len:%d\n", top->io_axi_ch1_m_awaddr, (top->io_axi_ch1_m_awaddr + (top->io_axi_ch1_m_awlen + 1) * AXI_TRANSFER_BYTE - 1), top->io_axi_ch1_m_awlen);
        if (axi_ch1_write_len.size() == OUTSTANDING_DEPTH) {
            io_axi_ch1_m_awready = 0;
        }
    } else if (!top->io_axi_ch1_m_awready && (axi_ch1_write_len.size() < OUTSTANDING_DEPTH) &&
               top->io_axi_ch1_m_bvalid) { // 1.1 outstanding depth not full
        io_axi_ch1_m_awready = 1;
    }

    if (axi_ch1_write_resp) { // 3. transaction resp
        io_axi_ch1_m_bvalid = 1;
        axi_ch1_write_resp = 0;
    } else if (top->io_axi_ch1_m_bready && top->io_axi_ch1_m_bvalid) {
        io_axi_ch1_m_bvalid = 0;
    }

    if (top->io_axi_ch1_m_wvalid && io_axi_ch1_m_wready) { // 2. write data
        // printf("len:%d\n", axi_ch1_write_len.front());
        // if (axi_ch1_write_len.front() == 0) {
        //     printf("[ error ]: axi_ch1_write_len.front() == 0\n");
        //     printf("[ error ]: main_time:%ld\n", main_time);
        //     printf("[ error ]: top->io_axi_ch1_m_wvalid:%d\n", top->io_axi_ch1_m_wvalid);
        //     assert(0);
        // }
        assert(axi_ch1_write_len.size() != 0);
        assert(axi_ch1_write_len.front() != 0);
        assert(top->io_axi_ch1_m_wstrb == 0xFFFF);
        // printf("%zu\n", axi_ch1_write_addr.front());
        for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
            // printf("[ log ]:main_time=%ld, addr = %lx, data = %x\n", main_time, axi_ch1_write_addr.front(), top->io_axi_ch1_m_wdata[i]);
            *((int *)axi_ch1_write_addr.front() + i) = top->io_axi_ch1_m_wdata[i];
        }
        axi_ch1_write_addr.pop();
        if (axi_ch1_write_len.front() == 1) { // 2.1 one transaction the last transfer
            axi_ch1_write_len.pop();
            assert(top->io_axi_ch1_m_wlast);
            axi_ch1_write_resp = 1;
        } else { // 2.2 not the last transfer
            axi_ch1_write_len.front()--;
            assert(!top->io_axi_ch1_m_wlast);
        }
    }

    top->io_axi_ch1_m_bid = 0;
    top->io_axi_ch1_m_bresp = 0;
    top->io_axi_ch1_m_awready = io_axi_ch1_m_awready;
    top->io_axi_ch1_m_wready = io_axi_ch1_m_wready;
    top->io_axi_ch1_m_bvalid = io_axi_ch1_m_bvalid;
}

static std::queue<uint64_t> axi_ch2_read_addr;
static std::queue<uint32_t> axi_ch2_read_len;
static int axi_ch2_read_wait_cnt = 0;
static int io_axi_ch2_m_arready = 1;
static int io_axi_ch2_m_rvalid = 0;
static int io_axi_ch2_m_rlast = 0;
static uint32_t io_axi_ch2_m_rdata[4];
void axi_ch2_r() {
    if (axi_ch2_read_len.size() == 0) { // 4. delay control
        if (top->io_axi_ch2_m_arvalid && top->io_axi_ch2_m_arready) {
            axi_ch2_read_wait_cnt = 0;
        }
    } else if (!top->io_axi_ch2_m_rvalid) {
        if (axi_ch2_read_wait_cnt <= DELAY_VALID_R_ch2) {
            axi_ch2_read_wait_cnt++;
        } else {
            io_axi_ch2_m_rvalid = 1;
        }
    }

    if (top->io_axi_ch2_m_arvalid && top->io_axi_ch2_m_arready) { // 1. transaction req start
        axi_ch2_read_len.push(top->io_axi_ch2_m_arlen + 1);
        assert(top->io_axi_ch2_m_arsize == log2(DMA_DATA_WIDTH / 8));
        assert(top->io_axi_ch2_m_arburst == 1);
        for (int i = 0; i < (top->io_axi_ch2_m_arlen + 1); i++) {
            axi_ch2_read_addr.push((uint64_t)top->io_axi_ch2_m_araddr + i * AXI_TRANSFER_BYTE);
        }
#ifdef CHECK_ALIGN
        if (align_check(top->io_axi_ch2_m_araddr)) {
            printf("[ error ]: top->io_axi_ch2_m_araddr = %lx, NOT ALIGN!\n", top->io_axi_ch2_m_araddr);
            assert(0);
        }
#endif
        if (top->io_axi_ch2_m_araddr / 4096 != (top->io_axi_ch2_m_araddr + (top->io_axi_ch2_m_arlen + 1) * AXI_TRANSFER_BYTE - 1) / 4096) {
            printf("[ error ]: single transaction cross 4K address!\n");
        }

        if (axi_ch2_read_len.size() == OUTSTANDING_DEPTH) {
            io_axi_ch2_m_arready = 0;
        }
    } else if (!top->io_axi_ch2_m_arready && (axi_ch2_read_len.size() < OUTSTANDING_DEPTH) &&
               (top->io_axi_ch2_m_rvalid && top->io_axi_ch2_m_rlast)) { // outstanding depth not full
        io_axi_ch2_m_arready = 1;
    }

    if (top->io_axi_ch2_m_rlast && top->io_axi_ch2_m_rvalid && top->io_axi_ch2_m_rready) { // 3. after last read
        if (axi_ch2_read_len.size() == 0) {
            io_axi_ch2_m_rvalid = 0;
            io_axi_ch2_m_rlast = 0;
        } else if (axi_ch2_read_len.front() != 1) {
            io_axi_ch2_m_rvalid = 0;
            io_axi_ch2_m_rlast = 0;
        }
    }

    if (io_axi_ch2_m_rvalid) { // 2. read data
        assert(axi_ch2_read_len.size() != 0);
        assert(axi_ch2_read_len.front() != 0);
        for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
            io_axi_ch2_m_rdata[i] = *((int *)axi_ch2_read_addr.front() + i);
        }
        if (top->io_axi_ch2_m_rready) {
            axi_ch2_read_addr.pop();
            if (axi_ch2_read_len.front() == 1) { // 2.1 one transaction the last transfer
                axi_ch2_read_len.pop();
                io_axi_ch2_m_rlast = 1;
            } else { // 2.2 not the last transfer
                axi_ch2_read_len.front()--;
                io_axi_ch2_m_rlast = 0;
            }
        }
    }

    top->io_axi_ch2_m_arready = io_axi_ch2_m_arready;
    top->io_axi_ch2_m_rid = 0;
    top->io_axi_ch2_m_rresp = 0;
    top->io_axi_ch2_m_rvalid = io_axi_ch2_m_rvalid;
    for (int i = 0; i < 4; i++) {
        top->io_axi_ch2_m_rdata[i] = io_axi_ch2_m_rdata[i];
    }
    top->io_axi_ch2_m_rlast = io_axi_ch2_m_rlast;
}

static std::queue<uint64_t> axi_ch2_write_addr;
static std::queue<uint32_t> axi_ch2_write_len;
static int axi_ch2_write_resp = 0;
static int axi_ch2_write_wait_cnt = 0;
static int io_axi_ch2_m_awready = 1;
static int io_axi_ch2_m_wready = 0;
static int io_axi_ch2_m_bvalid = 0;
void axi_ch2_w() {
    if (axi_ch2_write_len.size() == 0) { // 4. delay control
        if (top->io_axi_ch2_m_awvalid && top->io_axi_ch2_m_awready) {
            axi_ch2_write_wait_cnt = 0;
        }
    } else if (!top->io_axi_ch2_m_wready) {
        if (axi_ch2_write_wait_cnt <= DELAY_VALID_W_ch2) {
            axi_ch2_write_wait_cnt++;
        } else {
            io_axi_ch2_m_wready = 1;
        }
    }

    if (top->io_axi_ch2_m_awvalid && top->io_axi_ch2_m_awready) { // 1. transaction req start
        // axi_ch2_write_addr.push(top->io_axi_ch2_m_awaddr);
        axi_ch2_write_len.push(top->io_axi_ch2_m_awlen + 1);
        assert(top->io_axi_ch2_m_awsize == log2(DMA_DATA_WIDTH / 8));
        assert(top->io_axi_ch2_m_awburst == 1);
        for (int i = 0; i < (top->io_axi_ch2_m_awlen + 1); i++) {
            axi_ch2_write_addr.push((uint64_t)top->io_axi_ch2_m_awaddr + i * AXI_TRANSFER_BYTE);
        }
#ifdef CHECK_ALIGN
        if (align_check(top->io_axi_ch2_m_awaddr)) {
            printf("[ error ]: top->io_axi_ch2_m_awaddr = %lx, NOT ALIGN!\n", top->io_axi_ch2_m_awaddr);
            assert(0);
        }
#endif
        if (top->io_axi_ch2_m_awaddr / 4096 != (top->io_axi_ch2_m_awaddr + (top->io_axi_ch2_m_awlen + 1) * AXI_TRANSFER_BYTE - 1) / 4096) {
            printf("[ error ]: single transaction cross 4K address!\n");
        }
        if (axi_ch2_write_len.size() == OUTSTANDING_DEPTH) {
            io_axi_ch2_m_awready = 0;
        }
    } else if (!top->io_axi_ch2_m_awready && (axi_ch2_write_len.size() < OUTSTANDING_DEPTH) &&
               top->io_axi_ch2_m_bvalid) { // 1.1 outstanding depth not full
        io_axi_ch2_m_awready = 1;
    }

    if (axi_ch2_write_resp) { // 3. transaction resp
        io_axi_ch2_m_bvalid = 1;
        axi_ch2_write_resp = 0;
    } else if (top->io_axi_ch2_m_bready && top->io_axi_ch2_m_bvalid) {
        io_axi_ch2_m_bvalid = 0;
    }

    if (top->io_axi_ch2_m_wvalid && io_axi_ch2_m_wready) { // 2. write data
        assert(axi_ch2_write_len.size() != 0);
        assert(axi_ch2_write_len.front() != 0);
        for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
            // printf("[ log ]:main_time=%ld, addr = %lx, data = %x\n", main_time, axi_ch1_write_addr.front(), top->io_axi_ch1_m_wdata[i]);
            *((int *)axi_ch2_write_addr.front() + i) = top->io_axi_ch2_m_wdata[i];
            // if (prr_cnt) {
            //     printf("%d, w_data:%d\n", i, top->io_axi_ch2_m_wdata[i]);
            // }
        }
        axi_ch2_write_addr.pop();
        // if (prr_cnt) {
        //     printf("len:%d\n", axi_ch2_write_len.front());
        //     prr_cnt += -1;
        // }
        if (axi_ch2_write_len.front() == 1) { // 2.1 one transaction the last transfer
            axi_ch2_write_len.pop();
            assert(top->io_axi_ch2_m_wlast);
            axi_ch2_write_resp = 1;
        } else { // 2.2 not the last transfer
            axi_ch2_write_len.front()--;
            assert(!top->io_axi_ch2_m_wlast);
        }
    }

    top->io_axi_ch2_m_bid = 0;
    top->io_axi_ch2_m_bresp = 0;
    top->io_axi_ch2_m_awready = io_axi_ch2_m_awready;
    top->io_axi_ch2_m_wready = io_axi_ch2_m_wready;
    top->io_axi_ch2_m_bvalid = io_axi_ch2_m_bvalid;
}

void dma_wait() {
    while (1) {
    // for (int i = 0; i < 5000; i++) {
        // printf("main_time = %ld, i = %d\n", main_time,i);
        { // dma0 read  channels
            axi_ch1_r();
        }
        { // dma0 write channels
            axi_ch1_w();
        }
        { // dma1 read  channels
            axi_ch2_r();
        }
        { // dma1 write channels
            axi_ch2_w();
        }




// #endif

        inst.update();
        
        if (top->io_ofm_buffer_done == 1) {
            break;
        }
        if (top->io_wgt_buffer_done == 1) {
            break;
        }
        if (top->io_dout_valid_ConV == 1) {
            break;
        }
    }
}



// void dma_wait() {
//     while (1) {
//         { // dma0 read  channels
//             if (top->io_dma_ch_0_dma_ch_r___05Fareq == 1) {
//                 top->io_dma_ch_0_dma_ch_r___05Fbusy = 1;
//                 dma_ch1_read_busy = 1;
//                 dma_ch1_read_size = top->io_dma_ch_0_dma_ch_r___05Fsize;
//                 dma_ch1_read_addr = top->io_dma_ch_0_dma_ch_r___05Faddr;
//                 top->io_dma_ch_0_dma_ch_r_areq_dmaAreq = 0;
//                 top->io_dma_ch_0_dma_ch_r___05Fvalid = 1;
//                 for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
//                     top->io_dma_ch_0_dma_ch_r___05Fdata[i] = *((int *)dma_ch1_read_addr + i + dma_ch1_read_count * DMA_DATA_WIDTH / 32);
//                 }
//                 dma_ch1_read_count++;
//             } else if (dma_ch1_read_busy == 1 && top->io_dma_ch_0_dma_ch_r___05Fareq == 0) {
//                 if ((dma_ch1_read_count == 2) && (consis_cnt0) && (top->io_input_data_valid)) {       //sim the unconsis dma_valid
//                     top->io_dma_ch_0_dma_ch_r___05Fvalid = 0;
//                     consis_cnt0 += -1;
//                 } else {
//                     top->io_dma_ch_0_dma_ch_r___05Fvalid = 1;
//                     for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
//                         top->io_dma_ch_0_dma_ch_r___05Fdata[i] = *((int *)dma_ch1_read_addr + i + dma_ch1_read_count * DMA_DATA_WIDTH / 32);
//                     }
//                     dma_ch1_read_count++;
//                 }
//             }

//             if (dma_ch1_read_count == dma_ch1_read_size + 1) {
//                 top->io_dma_ch_0_dma_ch_r___05Fbusy = 0;
//                 top->io_dma_ch_0_dma_ch_r___05Fvalid = 0;
//                 for (int i = 0; i < DMA_DATA_WIDTH / 32; i++)
//                     top->io_dma_ch_0_dma_ch_r___05Fdata[i] = 0;
//                 dma_ch1_read_busy = 0;
//                 dma_ch1_read_size = 0;
//                 dma_ch1_read_addr = 0;
//                 dma_ch1_read_count = 0;
//                 ch1_r_finish = 1;
//             }
//         }

//         { // dma0 write channels
//             if (top->io_dma_ch_0_dma_ch_w___05Fareq == 1) {
//                 top->io_dma_ch_0_dma_ch_w___05Fbusy = 1;
//                 dma_ch1_write_busy = 1;
//                 dma_ch1_write_size = top->io_dma_ch_0_dma_ch_w___05Fsize;
//                 dma_ch1_write_addr = top->io_dma_ch_0_dma_ch_w___05Faddr;
//                 top->io_dma_ch_0_dma_ch_w_areq_dmaAreq = 0;
//                 top->io_dma_ch_0_dma_ch_w___05Fvalid = 1;
//             } else if (dma_ch1_write_busy && top->io_dma_ch_0_dma_ch_w___05Fareq == 0) {
//                 if (top->io_dma_ch_0_dma_ch_w___05Fvalid == 1) {
//                     for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
//                         *((int *)dma_ch1_write_addr + i + dma_ch1_write_count * DMA_DATA_WIDTH / 32) = top->io_dma_ch_0_dma_ch_w___05Fdata[i];
//                     }
//                     dma_ch1_write_count++;
//                 }
//                 if ((dma_ch1_write_count == 2) && (consis_out_cnt0)) {
//                     top->io_dma_ch_0_dma_ch_w___05Fvalid = 0;
//                     consis_out_cnt0 += -1;
//                 } else {
//                     top->io_dma_ch_0_dma_ch_w___05Fvalid = 1;
//                 }
//             }

//             if (dma_ch1_write_count == dma_ch1_write_size) {
//                 top->io_dma_ch_0_dma_ch_w___05Fbusy = 0;
//                 top->io_dma_ch_0_dma_ch_w___05Fvalid = 0;
//                 dma_ch1_write_busy = 0;
//                 dma_ch1_write_size = -1;
//                 dma_ch1_write_addr = 0;
//                 dma_ch1_write_count = 0;
//                 ch1_w_finish = 1;
//             }
//         }
//         if (DMA_CH_WIDTH >= 2){
//         { // dma1 read channels
//             if (top->io_dma_ch_1_dma_ch_r___05Fareq == 1) {
//                 top->io_dma_ch_1_dma_ch_r___05Fbusy = 1;
//                 dma_ch2_read_busy = 1;
//                 dma_ch2_read_size = top->io_dma_ch_1_dma_ch_r___05Fsize;
//                 dma_ch2_read_addr = top->io_dma_ch_1_dma_ch_r___05Faddr;
//                 top->io_dma_ch_1_dma_ch_r_areq_dmaAreq = 0;
//                 top->io_dma_ch_1_dma_ch_r___05Fvalid = 1;
//                 for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
//                     top->io_dma_ch_1_dma_ch_r___05Fdata[i] = *((int *)dma_ch2_read_addr + i + dma_ch2_read_count * DMA_DATA_WIDTH / 32);
//                 }
//                 dma_ch2_read_count++;
//             } else if (dma_ch2_read_busy == 1 && top->io_dma_ch_1_dma_ch_r___05Fareq == 0) {
//                 if ((dma_ch2_read_count == 2) && (consis_cnt1) && (top->io_input_data_valid)) {
//                     top->io_dma_ch_1_dma_ch_r___05Fvalid = 0;
//                     consis_cnt1 = 0;
//                 } else {
//                     top->io_dma_ch_1_dma_ch_r___05Fvalid = 1;
//                     for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
//                         top->io_dma_ch_1_dma_ch_r___05Fdata[i] = *((int *)dma_ch2_read_addr + i + dma_ch2_read_count * DMA_DATA_WIDTH / 32);
//                     }
//                     dma_ch2_read_count++;
//                 }
//             }

//             if (dma_ch2_read_count == dma_ch2_read_size + 1) {
//                 top->io_dma_ch_1_dma_ch_r___05Fbusy = 0;
//                 top->io_dma_ch_1_dma_ch_r___05Fvalid = 0;
//                 for (int i = 0; i < DMA_DATA_WIDTH / 32; i++)
//                     top->io_dma_ch_1_dma_ch_r___05Fdata[i] = 0;
//                 dma_ch2_read_busy = 0;
//                 dma_ch2_read_size = 0;
//                 dma_ch2_read_addr = 0;
//                 dma_ch2_read_count = 0;
//                 ch2_r_finish = 1;
//             }
//         }
//         { // dma1 write channels
//             if (top->io_dma_ch_1_dma_ch_w___05Fareq == 1) {
//                 top->io_dma_ch_1_dma_ch_w___05Fbusy = 1;
//                 dma_ch2_write_busy = 1;
//                 dma_ch2_write_size = top->io_dma_ch_1_dma_ch_w___05Fsize;
//                 dma_ch2_write_addr = top->io_dma_ch_1_dma_ch_w___05Faddr;
//                 top->io_dma_ch_1_dma_ch_w_areq_dmaAreq = 0;
//                 top->io_dma_ch_1_dma_ch_w___05Fvalid = 1;
//             } else if (dma_ch2_write_busy && top->io_dma_ch_1_dma_ch_w___05Fareq == 0) {
//                 if (top->io_dma_ch_1_dma_ch_w___05Fvalid == 1) {
//                     for (int i = 0; i < DMA_DATA_WIDTH / 32; i++) {
//                         *((int *)dma_ch2_write_addr + i + dma_ch2_write_count * DMA_DATA_WIDTH / 32) = top->io_dma_ch_1_dma_ch_w___05Fdata[i];
//                     }
//                     dma_ch2_write_count++;
//                 }
//                 if ((dma_ch2_write_count == 1) && (consis_out_cnt1)) {
//                     top->io_dma_ch_1_dma_ch_w___05Fvalid = 0;
//                     consis_out_cnt1 += -1;
//                 } else {
//                     top->io_dma_ch_1_dma_ch_w___05Fvalid = 1;
//                 }
//             }

//             if (dma_ch2_write_count == dma_ch2_write_size) {
//                 top->io_dma_ch_1_dma_ch_w___05Fbusy = 0;
//                 top->io_dma_ch_1_dma_ch_w___05Fvalid = 0;
//                 dma_ch2_write_busy = 0;
//                 dma_ch2_write_size = -1;
//                 dma_ch2_write_addr = 0;
//                 dma_ch2_write_count = 0;
//                 ch2_w_finish = 1;
//             }
//         }
//         } else {
//             ch2_r_finish = 1;
//             ch2_w_finish = 1;
//         }

        
//         inst.update();
        
//         if (top->io_ofm_buffer_done == 1) {
//             break;
//         }
//         if (top->io_wgt_buffer_done == 1) {
//             break;
//         }
//         if (top->io_dout_valid_ConV == 1) {
//             break;
//         }
//     }
// }



