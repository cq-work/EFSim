#include "../config.h"
#include "../veri.h"
#include "Device.h"

// 0.25 SRAM ref: A 1.041-Mb/mm2 27.38-TOPS/W Signed-INT8 Dynamic-Logic- Based
// ADC-less SRAM Compute-In-Memory Macro in 28nm with Reconfigurable Bitwise 
// Operation for AI and Embedded Applications
namespace ppa {

double calculate_device_area()
{
    double device_area = 0;
    double SRAM_Area = 5.1;
// 3.38 RRAM ref: A Fully Integrated Analog ReRAM Based 78.4TOPS/W Compute-In-Memory Chip with Fully Parallel MAC Computing
// 0.205 RRAM ref: A 1Mb Multibit ReRAM Computing-In-Memory Macro with 14.6ns Parallel MAC Computing Time for CNN- Based AI Edge Processors
// 1.44 RRAM ref: Suppress variations of analog resistive memory for neuromorphic computing by localizing Vo formation
// 0.25 SRAM ref: A 1.041-Mb/mm2 27.38-TOPS/W Signed-INT8 Dynamic-Logic- Based ADC-less SRAM Compute-In-Memory Macro in 28nm with Reconfigurable Bitwise Operation for AI and Embedded Applications
// area unit: um^2
    if (DEVICE_TYPE == 0) {           //NVM
        printf("[ log ]: USER NOT DEFINE!\n");
        device_area = 0;
    }
    else if (DEVICE_TYPE == 1)        //SRAM
    {
        device_area = SRAM_Area;
    }

    return device_area;
}


double calculate_device_read_power()
{
    double device_read_power = 0;
    double SRAM_Read_Latency = 3.16;
    // read latency unit: ns, 3.16 NTHU ISSCC19
    double SRAM_Read_Energy = 7.12e-16;
    // only used for SRAM, energy per bit
    if (DEVICE_TYPE == 0) {           //NVM
        printf("[ log ]: USER NOT DEFINE!\n");
        // while(1){
        //     int a=0;
        // }
        device_read_power = 0;
    }
    else if (DEVICE_TYPE == 1)        //SRAM
    {
        device_read_power = SRAM_Read_Energy / (SRAM_Read_Latency *  1e-9);
    }

    return device_read_power;
}

double calculate_device_write_power()
{
    double device_write_power = 0;
    double SRAM_Write_Latency = 10;
    // write latency unit: ns
    // double SRAM_Write_Energy = 1.6e-15;
    double SRAM_Write_Energy = 1.8e-12;
    //# only used for SRAM, energy per bit
    if (DEVICE_TYPE == 0) {           //NVM
        printf("[ log ]: USER NOT DEFINE!\n");
        device_write_power = 0;
    }
    else if (DEVICE_TYPE == 1)        //SRAM
    {
        device_write_power = SRAM_Write_Energy / (SRAM_Write_Latency * 1e-9);
    }


    return device_write_power;
}


}