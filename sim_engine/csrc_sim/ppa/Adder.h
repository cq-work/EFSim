#ifndef ADDER_H
#define ADDER_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class Adder
{
public:

    double calculate_adder_area(int adder_bitwidth);
    double calculate_adder_power(int adder_bitwidth);
    double calculate_adder_energy(double power, double latency);
};

} // namespace ncnn

#endif // ADDER_H

