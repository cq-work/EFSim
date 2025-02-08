//该工程主要实现了将ncnn的卷积层放入硬件进行加速，目前正在实现的过程中

#ifndef __CONFIG_H_
#define __CONFIG_H_

//----------------------------running platform settings-------------------------------//
// #define FORWARD_ON_CPU
#define FORWARD_ON_CIM

// #define FORWARD_ON_CIM_CONV
// #define FORWARD_ON_CIM_POOL
// #define FORWARD_ON_CIM_ALU

// #define FORWARD_ON_CPU_CONV
// #define FORWARD_ON_CPU_POOL
// #define FORWARD_ON_CPU_ALU

#ifdef FORWARD_ON_CPU
    #define FORWARD_ON_CPU_CONV
    #define FORWARD_ON_CPU_POOL
    #define FORWARD_ON_CPU_ALU
#endif
#ifdef FORWARD_ON_CIM
    #define FORWARD_ON_NPU_CONV
    #define FORWARD_ON_CPU_POOL
    #define FORWARD_ON_CPU_ALU
#endif

//-----------------------------simulation param settings-------------------------------//
// #define TEST_SINGLE_LAYER
// #define CHECK_ALIGN
// #define PRINT_MAT

#define WAVE_LOG
#define AREA_CALCULATION_METHOD 1     //normal
#define PIM_TYPE 1     //0: analog   1: digital
#define DEVICE_TYPE 1     //0: NVM   1: SRAM
// #define MAT_LOG
// #define BATCH_TEST
#define TECH_NODE  28       //28, 45, 55, 65, 130
#define AXI_LITE_DATA_SUPPORT
#define DMA_SUPPORT
// #define ONLY_RESET
#define ACCMEM_GAP 1000

//---------------------------test tasks--------------------------------//
// #define TEST_SHUFFLENETV2
// #define TEST_SIMPLEPOSE
#define TEST_SQUEEZENET

// #define TEST_YOLOV3
// #define TEST_YOLOV3_TINY
// #define TEST_YOLOV4_TINY
// #define TEST_YOLOV5S
// #define TEST_YOLOV6N
// #define TEST_YOLOV7_TINY
// #define TEST_YOLOV7

// #define TEST_RESNET18
// #define TEST_RESNET50
// #define TEST_RESNET101
// #define TEST_GOOGLENET

// #define TEST_MOBILENETSSD
// #define TEST_MOBILENETV2SSD     //not work
// #define TEST_MOBILENETV3SSD     //not work
// #define TEST_MOBILENETYOLO
// #define TEST_MOBILENETV2YOLO

// #define TEST_SHUFFLENETV2
// #define TEST_SIMPLEPOSE
// #define TEST_RETINAFACE

// #define TEST_SIN
// #define TEST_COS



#if defined(TEST_YOLOV3) || defined(TEST_YOLOV3_TINY)
    #define INFERENCE_NET
#endif

#define IMAGE_PATH "testImages/person.jpg"
// #define IMAGEFILE_PATH_YOLOV3_TINY "imagelist/image_for_yolov3-tiny.txt"
// #define LABELFILE_PATH_YOLOV3_TINY "imagelist/label_for_yolov3-tiny.txt"
#define IMAGEFILE_PATH_SQUEEZENET "imagelist/image_for_squeezenet.txt"
#define LABELFILE_PATH_SQUEEZENET "imagelist/label_for_squeezenet.txt"
#define IMAGEFILE_PATH_SHUFFLENETV2 "imagelist/image_for_shufflenetv2.txt"
#define LABELFILE_PATH_SHUFFLENETV2 "imagelist/label_for_shufflenetv2.txt"
#define IMAGEFILE_PATH_MOBILENETSSD "imagelist/image_for_mobilenetssd.txt"
#define LABELFILE_PATH_MOBILENETSSD "imagelist/label_for_mobilenetssd.txt"
#define IMAGEFILE_PATH_RESNET18 "imagelist/image_for_resnet18.txt"
#define LABELFILE_PATH_RESNET18 "imagelist/label_for_resnet18.txt"

//--------------------------hareware parameters---------------------------//
#define HARDWARE_FREQUENCY 1.0E+8
#define IFM_BUFFER_WIDTH  1024
#define IFM_BUFFER_DEPTH  65536 // (65536/64)  //2MB
#define WGT_BUFFER_DEPTH  16384  //512KB

// #define SQ_MAPPING
#define TILE_NUM        1     //ws
#define TILE2PE_NUM     2     //ws
#define PE2ARRAY_NUM    2     //ws
#define ARRAY_ROW       128   //ws  
#define ARRAY_COL       128   //ws  
#define UNIT_COL        8
#define UNIT_NUM        ARRAY_COL/UNIT_COL
#define O_WIDTH         32


#define PIPELINE_CNT      0
#define TOTAL_ROW       TILE_NUM*TILE2PE_NUM*ARRAY_ROW
#define TOTAL_COL       TILE_NUM*TILE2PE_NUM*PE2ARRAY_NUM*UNIT_NUM
#define BIT_NUM         8                   //BIT_WIDTH
#define WL_NUM          ARRAY_ROW
#define NUM_ARRAY_ROW TILE_NUM*TILE2PE_NUM
#define NUM_ARRAY_COL PE2ARRAY_NUM

#define NUM_COL         PE2ARRAY_NUM*UNIT_NUM   //64    总共表示多少列完整数字
#define INPUT_NUM       TILE2PE_NUM*ARRAY_ROW    //512   一个tile里的输入端口数
#define BL_NUM          TILE2PE_NUM*PE2ARRAY_NUM*ARRAY_COL    //2048  一个tile里的BL数
#define ARRAY_NUM       TILE_NUM*TILE2PE_NUM*PE2ARRAY_NUM

// #define WEIGHT_SIGN         权重是否有符号
// #define INPUT_SIGN          IFM是否有符号



#define DMA_ADDR_WIDTH    32
#define DMA_SIZE_WIDTH    32
#define DMA_DATA_WIDTH    128
#define DMA_CH_WIDTH      2
#define DMA_DATA_NUM  (DMA_DATA_WIDTH/32)
#define AXI_TRANSFER_BYTE (DMA_DATA_WIDTH/8) // axi single transfer byte num
#define PIPELINE_CNT      0
// #define PIPELINE_CNT      (TOTAL_ROW*BIT_NUM+TOTAL_COL*O_WIDTH)/(DMA_CH_WIDTH*DMA_DATA_WIDTH)<=14
#define HW_FREQ_MHZ  200
#if defined(TEST_ALU_MAT) || defined(TEST_LAYER_ELTWISE) || defined(INFERENCE_NET) || defined(TEST_DSP_ADD) || defined(TEST_DSP_DOT)
    #define USE_HW_ALU
#endif

#if defined(TEST_LAYER_POOL) || defined(INFERENCE_NET)
    #define USE_HW_POOL
#endif

#if defined(TEST_LAYER_CONV) || defined(INFERENCE_NET)
    #define USE_HW_GEMM
#endif

#endif