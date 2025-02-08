#include "../config.h"
#include "../veri.h"
#include "ppa.h"


namespace ppa {
double calculate_power(int sim_cycle, double energy)
{
    printf("[ log ]: Power calculation\n");
    double sim_time = sim_cycle * 1.0 / (HARDWARE_FREQUENCY * 1.0);

    double cim_power = energy / sim_time;

    // int adddertree_num_in = ARRAY_ROW;
    // int addertree_level = log(128)/log(2);
    // int addertree_cycles = forword_counts * AT_cycles;
    // double addertree_area = ppa::calculate_addertree_area(adddertree_num_in, addertree_level, BIT_NUM);

    // int num_addertree = UNIT_NUM * PE2ARRAY_NUM * TILE2PE_NUM * TILE_NUM;
    // cim_area += num_addertree * addertree_area; 


    return cim_power;
}
}