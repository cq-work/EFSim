#ifndef TILE_H
#define TILE_H

#include "../config.h"
#include "../veri.h"

namespace ppa {

class Tile
{
public:

    double calculate_tile_area();
    double calculate_tile_read_power();
    double calculate_tile_write_power();
    // double calculate_pe_area(double device_area);
    // double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    // double calculate_addertree_energy(double power, double latency);

    // double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);
};

} // namespace ncnn

#endif // TILE_H