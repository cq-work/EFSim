#include "../config.h"
#include "../veri.h"
#include "Adder.h"

namespace ppa {
double calculate_adder_area(int adder_bitwidth)
{
    // printf("[ log ]: adder area calculation\n");
    // unit: um^2
    static const std::map<int, double> adder_area_dict = {
            {130, 10 * 14 * 130 * 130 / 1e6},    //#ref: Implementation of an Efficient 14-Transistor Full Adder (.18��m technology) Using DTMOS 2.5e-9
            {65, 1.42},                     //10*14*65*65/1e6,
            {55, 10 * 14 * 55 * 55 / 1e6},
            {45, 10 * 14 * 45 * 45 / 1e6},
            {28, 10 * 14 * 28 * 28 / 1e6}
        };
    double adder_area = 0;
    if (TECH_NODE <= 28) adder_area = adder_area_dict.at(28) * adder_bitwidth;
    else if (TECH_NODE <= 45) adder_area = adder_area_dict.at(45) * adder_bitwidth;
    else if (TECH_NODE <= 55) adder_area = adder_area_dict.at(55) * adder_bitwidth;
    else if (TECH_NODE <= 65) adder_area = adder_area_dict.at(65) * adder_bitwidth;
    else if (TECH_NODE <= 130) adder_area = adder_area_dict.at(130) * adder_bitwidth;
    else printf("[ log ]: Selected TECH_NODE is not support!\n");
    return adder_area;
}

double calculate_adder_power(int adder_bitwidth)
{
    // unit: W
    static const std::map<int, double> adder_power_dict = {
        {130, 2.5e-9},    //#ref: Implementation of an Efficient 14-Transistor Full Adder (.18��m technology) Using DTMOS 2.5e-9
        {65, 3e-7},                     //10*14*65*65/1e6,
        {55, 2.5e-9},
        {45, 2.5e-9},
        {28, 2.5e-9}
    };
    double adder_power = 0;
    if (TECH_NODE <= 28) adder_power = adder_power_dict.at(28) * adder_bitwidth;
    else if (TECH_NODE <= 45) adder_power = adder_power_dict.at(45) * adder_bitwidth;
    else if (TECH_NODE <= 55) adder_power = adder_power_dict.at(55) * adder_bitwidth;
    else if (TECH_NODE <= 65) adder_power = adder_power_dict.at(65) * adder_bitwidth;
    else if (TECH_NODE <= 130) adder_power = adder_power_dict.at(130) * adder_bitwidth;
    else printf("[ log ]: Selected TECH_NODE is not support!\n");

    return adder_power;
}
double calculate_adder_energy(double power, double latency)
{
    double adder_energy;
    double adder_power = power;
    double adder_latency = latency;
    assert(adder_power >= 0 && adder_latency >= 0);
    return adder_energy = adder_latency * adder_power;
}
}