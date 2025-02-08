#include "../config.h"
#include "../veri.h"
#include "Array.h"
#include "ppa.h"

namespace ppa {
double calculate_array_area()
{
    double array_area;
    double xbar_area;
    // double addertree_area_1, addertree_area;
    
    
    // xbar_area = ppa::calculate_xbar_area();
    xbar_area = ppa::calculate_xbar_area();

    // int num_in = ARRAY_ROW;
    // int level = log(ARRAY_ROW)/log(2);
    // int bitwidth_1st = BIT_NUM;
    // addertree_area_1 = ppa:calculate_addertree_area(num_in, level, bitwidth_1st);
    // int adddertree_num = UNIT_NUM;
    // addertree_area = UNIT_NUM * addertree_area_1;



    array_area = xbar_area;
    return array_area;
}

double calculate_array_read_power()
{
    double array_read_power;
    double xbar_read_power;
    // double addertree_area_1, addertree_area;
    
    
    // xbar_area = ppa::calculate_xbar_area();
    xbar_read_power = ppa::calculate_xbar_read_power();

    // int num_in = ARRAY_ROW;
    // int level = log(ARRAY_ROW)/log(2);
    // int bitwidth_1st = BIT_NUM;
    // addertree_area_1 = ppa:calculate_addertree_area(num_in, level, bitwidth_1st);
    // int adddertree_num = UNIT_NUM;
    // addertree_area = UNIT_NUM * addertree_area_1;



    array_read_power = xbar_read_power;
    return array_read_power;
}

double calculate_array_write_power()
{
    double array_write_power;
    double xbar_write_power;
    // double addertree_area_1, addertree_area;
    
    
    // xbar_area = ppa::calculate_xbar_area();
    xbar_write_power = ppa::calculate_xbar_write_power();

    // int num_in = ARRAY_ROW;
    // int level = log(ARRAY_ROW)/log(2);
    // int bitwidth_1st = BIT_NUM;
    // addertree_area_1 = ppa:calculate_addertree_area(num_in, level, bitwidth_1st);
    // int adddertree_num = UNIT_NUM;
    // addertree_area = UNIT_NUM * addertree_area_1;



    array_write_power = xbar_write_power;
    return array_write_power;
}
}