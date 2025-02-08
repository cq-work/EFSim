#include "../config.h"
#include "../veri.h"
#include "Tile.h"
#include "ppa.h"

namespace ppa {
double calculate_tile_area()
{
    double pe_area;
    double tile_area;

    
    
    pe_area = ppa::calculate_pe_area();

    int num_pe = TILE2PE_NUM;
    tile_area = num_pe * pe_area;
    return tile_area;
}

double calculate_tile_read_power()
{
    double pe_read_power;
    double tile_read_power;

    
    
    pe_read_power = ppa::calculate_pe_read_power();

    int num_pe = TILE2PE_NUM;
    tile_read_power = num_pe * pe_read_power;
    return tile_read_power;
}

double calculate_tile_write_power()
{
    double pe_write_power;
    double tile_write_power;

    
    
    pe_write_power = ppa::calculate_pe_write_power();

    int num_pe = TILE2PE_NUM;
    tile_write_power = num_pe * pe_write_power;
    return tile_write_power;
}
}