#include "../config.h"
#include "../veri.h"
#include "Crossbar.h"
#include "ppa.h"

namespace ppa {

double calculate_xbar_area()
{
    double xbar_row = ARRAY_ROW;
    double xbar_col = ARRAY_COL;
    double xbar_area = 0;
    double transistor_tech = TECH_NODE;
    if (AREA_CALCULATION_METHOD == 0){
        double area_factor = 1;
        double device_area = 0;
        // when consider driver for digital PIM, the area is: self.xbar_row * (7.3*2.7+9.5*3.8)*(self.transistor_tech/65)**2
        if (PIM_TYPE) {    
            xbar_area = area_factor * xbar_row * xbar_col * device_area + 
                        xbar_row * (7.3 * 2.7 + 9.5 * 3.8) * pow((transistor_tech / 65.0), 2);
        } else {
            // # in A Fully Integrated Analog ReRAM Based 78.4TOPS/W Compute-In-Memory Chip with Fully Parallel MAC Computing, the driver area is 1150, 
            // for others, the driver area is (7.3*2.7+9.5*3.8)*(self.transistor_tech/65)**2, ref: Multi-level wordline driver for robust SRAM design in nano-scale CMOS technology
            xbar_area = area_factor * xbar_row * xbar_col * device_area + 1150 * xbar_row;
        }        
    }
    else{
        if (DEVICE_TYPE == 1) {
            // SRAM area calculation !!!     unit of SRAM!!!: 0.25 SRAM ref: A 1.041-Mb/mm2 27.38-TOPS/W Signed-INT8 Dynamic-Logic- Based ADC-less SRAM Compute-In-Memory Macro in 28nm with Reconfigurable Bitwise Operation for AI and Embedded Applications
            xbar_area = xbar_row * xbar_col * 2.65;
        } 
        else {
            printf("[ log ]: Not define now!");
            // double WL_ratio = 3
            // // WL_ratio is the technology parameter W/L of the transistor
            // if (cell_type[0] == '0':
            //     self.xbar_area = 4 * self.xbar_row * self.xbar_column * self.device_tech**2 * 1e-6
            // else:
            //     self.xbar_area = 3 * (WL_ratio + 1) * self.xbar_row * self.xbar_column * self.device_tech**2 * 1e-6
        }
    }
    return xbar_area;
}

// double calculate_xbar_read_power()
// {
//     // unit: W
//     // cal_mode: 0
//     // Notice: before calculating power, xbar_read_config must be executed
//     // xbar_read_config(read_matrix,read_vector)
//     double xbar_read_power = 0;
//     if (xbar_simulation_level == 0) {
//         assert(xbar_utilization <= 1.0)
//     }
//     return xbar_read_power;

// }


// double calculate_xbar_write_power()
// {
//     double xbar_write_power = 0;

//     return xbar_write_power;
// }

double calculate_xbar_read_power()
{
    // unit: nJ
    double xbar_read_power;
    double xbar_num_read_row = ARRAY_ROW;
    double xbar_num_read_col = ARRAY_COL;
    double device_read_power = ppa::calculate_device_read_power() ;
    // double xbar_read_latency = 1;     //unit: s
    // double xbar_read_power = 0;       //default
    if (DEVICE_TYPE == 0) {           //NVM
        xbar_read_power = 0;       //default
    }
    else if (DEVICE_TYPE == 1)        //SRAM
    {
        xbar_read_power = xbar_num_read_row * xbar_num_read_col * device_read_power;
        // printf("[ log ]: device_read_power = %.16f\n", device_read_power);
        // printf("[ log ]: xbar_read_power = %.16f\n", xbar_read_power);
    }
    return xbar_read_power;
}

double calculate_xbar_write_power()
{
    // unit: nJ
    double xbar_write_power;
    double xbar_num_write_row = ARRAY_ROW;
    double xbar_num_write_col = ARRAY_COL;
    double device_write_power = ppa::calculate_device_write_power();
    // double xbar_write_latency = 1;     //unit: s
    if (DEVICE_TYPE == 0) {           //NVM
        xbar_write_power = 0;         //default
    }
    else if (DEVICE_TYPE == 1)        //SRAM
    {
        xbar_write_power = xbar_num_write_row * xbar_num_write_col * device_write_power;
        // printf("[ log ]: device_write_power = %.16f\n", device_write_power);
        // printf("[ log ]: xbar_write_power = %.16f\n", xbar_write_power);
    }
    return xbar_write_power;
}


}
