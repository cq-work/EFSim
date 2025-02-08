#include "../config.h"
#include "../veri.h"
#include "PE.h"
#include "ppa.h"

namespace ppa {
double calculate_pe_area()
{
    double array_area;
    double pe_area;

    
    
    array_area = ppa::calculate_array_area();

    int num_array = PE2ARRAY_NUM;
    pe_area = num_array * array_area;
    return pe_area;
}

double calculate_pe_read_power()
{
    double array_read_power;
    double pe_read_power;

    
    
    array_read_power = ppa::calculate_array_read_power();

    int num_array = PE2ARRAY_NUM;
    pe_read_power = num_array * array_read_power;
    return pe_read_power;
}

double calculate_pe_write_power()
{
    double array_write_power;
    double pe_write_power;

    
    
    array_write_power = ppa::calculate_array_write_power();

    int num_array = PE2ARRAY_NUM;
    pe_write_power = num_array * array_write_power;
    return pe_write_power;
}
}