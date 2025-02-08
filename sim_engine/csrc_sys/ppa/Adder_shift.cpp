#include "../config.h"
#include "../veri.h"
#include "Adder_shift.h"
#include "ppa.h"

// 3 * 23bit reg +  2 * 23bit input adder 

namespace ppa {
double calculate_adder_shift_area(int adder_bitwidth, int reg_bitwidth)
{
    // printf("[ log ]: adder_shift area calculation\n");
    // unit: um^2
    double adder_shift_area = 0;
    double adder_area = ppa::calculate_adder_area(adder_bitwidth);

    double reg_area = ppa::calculate_reg_area(reg_bitwidth);


    adder_shift_area = 3 * reg_area + 2 * adder_area;
    return adder_shift_area;
}

double calculate_adder_shift_power(int adder_bitwidth, int reg_bitwidth)
{
    // unit: W
    // printf("[ log ]: adder_shift power calculation\n");
    double adder_shift_power = 0;
    double adder_power = ppa::calculate_adder_power(adder_bitwidth);

    double reg_power = ppa::calculate_reg_power(reg_bitwidth);


    adder_shift_power = 3 * reg_power + 2 * adder_power;

    return adder_shift_power;
}

}


// 3 * 23bit reg +  2 * 23bit input adder 