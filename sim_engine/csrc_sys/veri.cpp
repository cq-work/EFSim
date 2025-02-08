#include "veri.h"
#include "hw/accel_params.h"
#include "hw/hw_cim.h"
#include "config.h"
#include "utils/utils.h"
#include "net/cnn_demo.h"
#include "ppa/ppa.h"
#include "verilated_vcd_c.h"

//时钟步进一个周期
vluint64_t main_time = 0;  //initial 仿真时间
extern double execution_time_hw, AT_forward_counts;
extern int sim_cnt, wu_cnt, fc_cnt;
extern double fc_real_cnt;
extern long long operations;
static int my_clock = 0;

Vtop *top = new Vtop("top");

#ifdef WAVE_LOG
VerilatedVcdC *tfp = new VerilatedVcdC(); // 导出vcd波形需要加此语句
#endif

int main(int argc, char **argv)
{
    time_t start_time, end_time;
    double execution_time;
    start_time = time(NULL);

    char task[30];
    Verilated::commandArgs(argc,argv);
    Verilated::traceEverOn(true); //导出vcd波形需要加此语句

    #ifdef WAVE_LOG
    top->trace(tfp, 0);
    tfp->open("wave.vcd"); //打开vcd
    #endif

    #ifdef TEST_YOLOV3_TINY
        strcpy(task, "YOLOv3_Tiny");
        demo::yolov3_tiny_inference();
    #endif
    #ifdef TEST_YOLOV3
        strcpy(task, "YOLOv3");
        demo::yolov3_inference();
    #endif
    #ifdef TEST_YOLOV4_TINY
        strcpy(task, "YOLOv4_Tiny");
        demo::yolov4_tiny_inference();
    #endif
    #ifdef TEST_YOLOV5S
        strcpy(task, "YOLOv5s");
        demo::yolov5s_inference();
    #endif
    #ifdef TEST_YOLOV6N
        strcpy(task, "YOLOv6n");
        demo::yolov6n_inference();
    #endif
    #ifdef TEST_YOLOV7_TINY
        strcpy(task, "YOLOv7_Tiny");
        demo::yolov7_tiny_inference();
    #endif
    #ifdef TEST_YOLOV7
        strcpy(task, "YOLOv7");
        demo::yolov7_inference();
    #endif
    #ifdef TEST_RESNET18
        strcpy(task, "ResNet18");
        demo::resnet18_inference();
    #endif
    #ifdef TEST_RESNET50
        strcpy(task, "ResNet50");
        demo::resnet50_inference();
    #endif
    #ifdef TEST_RESNET101
        strcpy(task, "ResNet101");
        demo::resnet101_inference();
    #endif
    #ifdef TEST_GOOGLENET
        strcpy(task, "GoogleNet");
        demo::googlenet_inference();
    #endif
    #ifdef TEST_MOBILENETSSD
        strcpy(task, "MobileNet-SSD");
        demo::mobilenetssd_inference();
    #endif
    #ifdef TEST_MOBILENETV2SSD
        strcpy(task, "MobileNetv2-SSD");
        demo::mobilenetv2ssd_inference();
    #endif
    #ifdef TEST_MOBILENETV3SSD
        strcpy(task, "MobileNetv3-SSD");
        demo::mobilenetv3ssd_inference();
    #endif
    #ifdef TEST_MOBILENETYOLO
        strcpy(task, "MobileNetYolo");
        demo::mobilenet_yolo_inference();
    #endif
    #ifdef TEST_MOBILENETV2YOLO
        strcpy(task, "MobileNetv2Yolo");
        demo::mobilenetv2_yolo_inference();
    #endif
    #ifdef TEST_SHUFFLENETV2
        strcpy(task, "ShuffleNetv2");
        demo::shufflenetv2_inference();
    #endif
    #ifdef TEST_SIMPLEPOSE
        strcpy(task, "SimplePose");
        demo::simplepose_inference();
    #endif
    #ifdef TEST_SQUEEZENET
        strcpy(task, "SqueezeNet");
        demo::squeezenet_inference(); 
    #endif
    #ifdef TEST_RETINAFACE
        strcpy(task, "RetinaFace");
        demo::retinaface_inference();
    #endif   
    #ifdef TEST_SIN
        strcpy(task, "YOLOv3_Tiny");
        test::test_dsp_sin();
    #endif
    #ifdef TEST_COS
        strcpy(task, "YOLOv3_Tiny");
        test::test_dsp_cos();
    #endif

    #ifdef WAVE_LOG
    tfp->close();
    #endif    
    
    printf("[ log ]: The waveform of the IMC macro is stored in ./wave.vcd!!!");

    printf("\n***************************************************************\n");

    int sim_cycle = sim_cnt/2;

    float hw_exc_time = sim_cycle/HARDWARE_FREQUENCY;

    // printf("operations=%lld\n",operations);
    double peak_tops = ppa::peak_tops();
    // printf("peak_tops=%.4f\n",peak_tops);
    double real_tops = ppa::real_tops(operations * 2, hw_exc_time);
    // printf("real_tops=%.4f\n",real_tops);

    //utiliz ratio
    double utiliz_ratio = fc_real_cnt/(fc_cnt * 1.0);

    //erea
    double cim_area = ppa::calculate_area();

    //energy
    // double AT_forward_counts = 100;
    double cim_energy = ppa::calculate_energy(AT_forward_counts, wu_cnt, fc_cnt);

    double cim_power = ppa::calculate_power(sim_cycle, cim_energy);

    // printf("real_tops=%.4f\n",real_tops);
    // printf("cim_power=%.4f\n",cim_power);
    double cim_ef = real_tops / cim_power;

    end_time = time(NULL);
    execution_time = difftime(end_time, start_time);
    printf("\n***********************Simulation Result***********************\n");
    printf("Simulation Runtime is %.2fs\n", execution_time);
    printf("Hardware Simulation Time is %.2fs\n", execution_time_hw);
    printf("Hardware Execution Time is %.4fs, Total Simulation Cycles: %d\n", hw_exc_time, sim_cnt/2);
    printf("Weight Update Counts: %d, Forward Compute Counts: %d\n", wu_cnt, fc_cnt);

    printf("---------------------------------------------------------------\n");

    printf("Peak Throughput TOPS (I:%db, W:%db): %.4f TOPS\n", BIT_NUM, BIT_NUM, peak_tops);
    printf("Real Throughput TOPS (I:%db, W:%db) for %s: %.4f TOPS\n", BIT_NUM, BIT_NUM, task, real_tops);
    printf("Utilization of Compute Units: %.2f%\n", utiliz_ratio*100);
    // printf("Area mm^2: %.5f um2\n", cim_area);
    printf("Area um^2: %.5f mm2\n", cim_area/1.0E+6);
    printf("Energy J: %.10f J\n", cim_energy);
    printf("Power W: %.10f W\n", cim_power);

    printf("Energy Efficiency TOPS/W for %s: %.4f TOPS/W\n", task, cim_ef);
    
    printf("************************Simulation Done ************************\n\n");
    return 0;
}