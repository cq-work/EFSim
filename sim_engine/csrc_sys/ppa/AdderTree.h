#ifndef ADDER_TREE_H
#define ADDER_TREE_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class AdderTree
{
public:

    double calculate_addertree_area(int num_in, int level, int adder_bit_width);
    double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    double calculate_addertree_energy(double power, double latency);

    double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);
};

} // namespace ncnn

#endif // ADDERTREE_H