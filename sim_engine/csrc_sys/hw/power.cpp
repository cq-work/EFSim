#include "../config.h"

float sram_dynamic = 1;
float sram_static = 1;

float powercal_arrayupdate(int cim_array[TOTAL_ROW][PE2ARRAY_NUM*ARRAY_COL]) {
    float update_power;
    for(int i = 0; i < TOTAL_ROW*PE2ARRAY_NUM*ARRAY_COL; i++) {
        update_power += cim_array[i/PE2ARRAY_NUM*ARRAY_COL][i%PE2ARRAY_NUM*ARRAY_COL] * sram_dynamic;
    }

    return update_power;
}
