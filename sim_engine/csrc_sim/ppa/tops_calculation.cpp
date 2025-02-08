#include "../config.h"
#include "../veri.h"


namespace ppa {
double peak_tops() {

    int capacity = TILE_NUM * TILE2PE_NUM * PE2ARRAY_NUM * ARRAY_ROW * ARRAY_COL;
    // printf("capacity=%d\n",capacity);
    int operation = capacity / BIT_NUM;
    // printf("operation=%d\n",operation);
    long long ops = operation * HARDWARE_FREQUENCY /BIT_NUM;
    // printf("ops=%lld\n",ops);
    double peak_tops = ops/(1.0E+12);
    return peak_tops;

}

double real_tops(long long operation, float time) {
    double real_tops = operation/time/(1.0E+12);
    return real_tops;
}
}

