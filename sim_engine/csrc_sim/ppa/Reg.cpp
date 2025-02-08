#include "../config.h"
#include "../veri.h"
#include "Reg.h"

namespace ppa {

double calculate_reg_area(int bitwidth)
{
    // unit: um^2
    double reg_area = 0;
    // double transistor_tech = TECH_NODE;
    static const std::map<int, double> reg_area_dict = {
            {4, 1.4256},    
            {8, 1.4256*2},                  
            {16, 1.4256*4},
            {32, 1.4256*8}
        };
    if (bitwidth <= 4) reg_area = reg_area_dict.at(4) * pow((TECH_NODE/65),2);
    else if (bitwidth <= 8) reg_area = reg_area_dict.at(8) * pow((TECH_NODE/65),2);
    else if (bitwidth <= 16) reg_area = reg_area_dict.at(16) * pow((TECH_NODE/65),2);
    else reg_area = reg_area_dict.at(32) * pow((TECH_NODE/65),2);
    return reg_area;
}

double calculate_reg_power(int bitwidth)
{
    double reg_power = 0;
    static const std::map<int, double> reg_power_dict = {
        {4, 18.8e-9},    
        {8, 2*18.8e-9},                  
        {16, 4*18.8e-9},
        {32, 8*18.8e-9}
    };
    if (bitwidth <= 4) reg_power = reg_power_dict.at(4) * pow((TECH_NODE/65),2);
    else if (bitwidth <= 8) reg_power = reg_power_dict.at(8) * pow((TECH_NODE/65),2);
    else if (bitwidth <= 16) reg_power = reg_power_dict.at(16) * pow((TECH_NODE/65),2);
    else reg_power = reg_power_dict.at(32) * pow((TECH_NODE/65),2);

    return reg_power;

}
}
