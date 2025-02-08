#ifndef ARRAY_H
#define ARRAY_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class Array
{
public:

    double calculate_array_area();
    double calculate_array_read_power();
    double calculate_array_write_power();
    // double calculate_array_area(double device_area);
    // double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    // double calculate_addertree_energy(double power, double latency);

    // double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);
};

} // namespace ncnn

#endif // ARRAY_H