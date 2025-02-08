#ifndef __PPA_H_
#define __PPA_H_


namespace ppa{
    double peak_tops();
    double real_tops(long long operation, float time);
    double calculate_energy(double AT_forward_counts, double XB_write_counts, double XB_read_counts);
    double calculate_power(int sim_cycle, double energy);

    double calculate_area();
    double calculate_adder_area(int adder_bitwidth);
    double calculate_addertree_area(int num_in, int level, int adder_bit_width);

    double calculate_adder_power(int adder_bitwidth);
    double calculate_addertree_power(int num_in, int level, int bitwidth_1st);
    double calculate_addertree_ratio(int num_in_real, int bitwidth_1st);

    double calculate_xbar_area();
    // double calculate_xbar_area();
    double calculate_xbar_read_power();
    double calculate_xbar_write_power();


    double calculate_array_area();
    double calculate_array_read_power();
    double calculate_array_write_power();



    double calculate_pe_area();
    double calculate_pe_read_power();
    double calculate_pe_write_power();



    double calculate_tile_area();
    double calculate_tile_read_power();
    double calculate_tile_write_power();

    double calculate_adder_shift_area(int adder_bitwidth, int reg_bitwidth);
    double calculate_adder_shift_power(int adder_bitwidth, int reg_bitwidth);    

    double calculate_device_area();
    double calculate_device_read_power();
    double calculate_device_write_power();

    double calculate_reg_area(int reg_bitwidth);
    double calculate_reg_power(int reg_bitwidth);


}



#endif