#include "../config.h"
#include "../veri.h"
// #include<math.h>
#include "AdderTree.h"
#include "ppa.h"

namespace ppa {
double calculate_addertree_area(int num_in, int level, int bitwidth_1st)
{
    // printf("[ log ]: addertree area calculation\n");
    double addertree_area = 0;
    double adder_area = 0;
    int num_adder = 0;

    for (int i = 0; i < level; i++ ){
        int bitwidth = bitwidth_1st + i; 
        adder_area = ppa::calculate_adder_area(bitwidth);

        num_adder = num_in/pow(2,i+1);
        addertree_area += num_adder * adder_area;

    }
    return addertree_area;
}

double calculate_addertree_power(int num_in, int level, int bitwidth_1st)
{
    // printf("[ log ]: addertree power calculation\n");
    double addertree_power = 0;
    double adder_power = 0;
    int num_adder = 0;

    for (int i = 0; i < level; i++ ){
        int bitwidth = bitwidth_1st + i; 
        adder_power = ppa::calculate_adder_power(bitwidth);

        num_adder = num_in/pow(2,i+1);
        addertree_power += num_adder * adder_power;
    }

    return addertree_power;
}
double calculate_addertree_energy(double power, double latency)
{
    double addertree_energy = 0;
    double addertree_power = power;
    double addertree_latency = latency;
    assert(addertree_power >= 0 && addertree_latency >= 0);
    return addertree_energy = addertree_power * addertree_latency;
}

double calculate_addertree_ratio(int num_in_real, int bitwidth_1st)
{
    int num_in = ARRAY_ROW;
    int level = log(num_in)/log(2);
    double adddertree_ratio;
    int num_work = 0;
    int num_all = 0;
    int bitwidth, num_per_level, num_per_level_work;
    for (int i = 0; i < level; i++){
        bitwidth = bitwidth_1st + i;
        num_per_level = pow(2,level-1-i);        
        num_all += bitwidth * num_per_level;
        // printf("num_all= %d\n",num_all);
        num_per_level_work = ceil(num_in_real/pow(2,i));
        num_work += bitwidth * num_per_level_work;
        // printf("num_work= %d\n",num_work);

    }
    double addertree_ratio = (num_work*1.0)/(num_all*1.0);
    // printf("addertree_ratio= %.5f\n",addertree_ratio);

    return addertree_ratio;
}
}