#ifndef CROSSBAR_H
#define CROSSBAR_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class Crossbar
{
public:

    double calculate_xbar_area();
    double calculate_xbar_read_power();
    double calculate_xbar_write_power();
    // double calculate_xbar_area();
    // double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    // double calculate_addertree_energy(double power, double latency);

    // double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);
};

} // namespace ncnn

#endif // ADDERTREE_H