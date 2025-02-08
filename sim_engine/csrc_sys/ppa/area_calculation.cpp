#include "../config.h"
#include "../veri.h"
#include "ppa.h"


namespace ppa {
double calculate_area()
{
    printf("[ log ]: Area calculation\n");
    double cim_area = 0;

    int tile_num = TILE_NUM;
    double tile_area = ppa::calculate_tile_area();
    printf("[ log ]: Tile Area is %.4f um2\n", tile_num * tile_area);
    cim_area += tile_num * tile_area;



    int adddertree_num_in = ARRAY_ROW;
    int addertree_level = log(ARRAY_ROW)/log(2);     //ARRAY_ROW=128
    double addertree_area = ppa::calculate_addertree_area(adddertree_num_in, addertree_level, BIT_NUM);
    int num_addertree = UNIT_NUM * PE2ARRAY_NUM * TILE2PE_NUM * TILE_NUM;
    printf("[ log ]: AdderTree Area is %.4f um2\n", num_addertree * addertree_area);
    cim_area += num_addertree * addertree_area;

    
    int bitwidth = BIT_NUM + log(ARRAY_ROW)/log(2) + BIT_NUM;
    double adder_shift_area = ppa::calculate_adder_shift_area(bitwidth, bitwidth);
    int num_adder_shift = UNIT_NUM * PE2ARRAY_NUM * TILE2PE_NUM * TILE_NUM;
    printf("[ log ]: Adder Shift Area is %.4f um2\n", num_adder_shift * adder_shift_area);
    cim_area += num_adder_shift * adder_shift_area;



    return cim_area;
}
}