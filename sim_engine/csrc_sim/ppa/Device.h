#ifndef DEVICE_H
#define DEVICE_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class Device
{
public:

    double calculate_device_area();
    double calculate_device_read_power();
    double calculate_device_write_power();
    // double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    // double calculate_addertree_energy(double power, double latency);

    // double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);
};

} // namespace ncnn

#endif // ADDERTREE_H