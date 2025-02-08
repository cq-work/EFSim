#ifndef REG_H
#define REG_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class Reg
{
public:

    double calculate_reg_area(int bitwidth);
    double calculate_reg_power(int bitwidth);
    // double calculate_xbar_area();
    // double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    // double calculate_addertree_energy(double power, double latency);

    // double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);
};

} // namespace ncnn

#endif // REG_H