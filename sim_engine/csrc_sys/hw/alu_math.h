#ifndef __ALU_MATH_H_
#define __ALU_MATH_H_



class alu_math{
public :
    int op;

public :
    alu_math();
    float forward(int sin_flag, float x);
    void initial();
    void update();
    //void weight_update(std::vector<std::vector<unsigned char>>SIN_mat, std::vector<std::vector<unsigned char>>COS_mat);
    void weight_update();
};


#endif