#ifndef ADDER_SHIFT_H
#define ADDER_SHIFT_H

#include "../config.h"
#include "../veri.h"


// 3 * 23bit reg +  2 * 23bit input adder 

namespace ppa {

class Adder_Shift
{
public:

    double calculate_adder_shift_area(int adder_bitwidth, int reg_bitwidth);
    double calculate_adder_shift_power(int adder_bitwidth, int reg_bitwidth);
};
}

#endif

// 3 * 23bit reg +  2 * 23bit input adder 