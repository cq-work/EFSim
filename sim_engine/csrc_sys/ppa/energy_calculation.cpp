#include "../config.h"
#include "../veri.h"
#include "ppa.h"


namespace ppa {
double calculate_energy(double AT_forward_counts, double XB_write_counts, double XB_read_counts)
{
    printf("[ log ]: Energy calculation\n");
    // printf("[ log ]: AT_forward_counts = %.5f\n", AT_forward_counts);
    // printf("[ log ]: XB_write_counts = %.5f\n", XB_write_counts);
    // printf("[ log ]: XB_read_counts = %.5f\n", XB_read_counts);
    double cim_energy = 0;

    // CrossBar module
    int num_tile = TILE_NUM;

    double XB_write_latency = XB_write_counts * 1 / HARDWARE_FREQUENCY;
    double tile_write_power = ppa::calculate_tile_write_power();
    // printf("[ log ]: XB_write_latency = %.10f\n", XB_write_latency);
    // printf("[ log ]: tile_write_power = %.10f\n", tile_write_power);

    double XB_write_power = num_tile * tile_write_power;
    double XB_write_energy = XB_write_latency * XB_write_power;

    double XB_read_period = BIT_NUM;
    double XB_read_latency = XB_read_counts * XB_read_period / HARDWARE_FREQUENCY;
    double tile_read_power = ppa::calculate_tile_read_power();
    // printf("[ log ]: XB_read_latency = %.10f\n", XB_read_latency);
    // printf("[ log ]: tile_read_power = %.10f\n", tile_read_power);

    
    double XB_read_power = num_tile * tile_read_power * 0.5;                //exist 0   
    double XB_read_energy = XB_read_latency * XB_read_power;


    // AdderTree module
    int AT_period = BIT_NUM;
    double AT_latency = AT_forward_counts * AT_period / HARDWARE_FREQUENCY;

    int adddertree_num_in = ARRAY_ROW;
    double addertree_level = log(ARRAY_ROW)/log(2);      //ARRAY_ROW=128
    double addertree_power = ppa::calculate_addertree_power(adddertree_num_in, addertree_level, BIT_NUM);
    int num_addertree = UNIT_NUM * PE2ARRAY_NUM * TILE2PE_NUM * TILE_NUM;


    double AT_power = num_addertree * addertree_power;
    double AT_energy = AT_latency * AT_power;

    //Adder Shift module
    int AS_period = BIT_NUM;
    double AS_latency = AT_forward_counts * AS_period / HARDWARE_FREQUENCY;

    int bitwidth = BIT_NUM + log(ARRAY_ROW)/log(2) + BIT_NUM;
    // double addertree_level = log(ARRAY_ROW)/log(2);      //ARRAY_ROW=128
    double adder_shift_power = ppa::calculate_adder_shift_power(bitwidth, bitwidth);
    int num_adder_shift = UNIT_NUM * PE2ARRAY_NUM * TILE2PE_NUM * TILE_NUM;


    double AS_power = num_adder_shift * adder_shift_power;
    double AS_energy = AS_latency * AS_power;



    printf("[ log ]: XB_write_energy = %.10f J\n", XB_write_energy );
    printf("[ log ]: XB_read_energy = %.10f J\n", XB_read_energy );
    printf("[ log ]: AT_energy = %.10f J\n", AT_energy);
    printf("[ log ]: AS_energy = %.10f J\n", AS_energy);


    cim_energy = XB_write_energy + XB_read_energy + AT_energy + AS_energy; 

    return cim_energy;
}
}