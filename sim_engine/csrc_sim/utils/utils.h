#ifndef __UTILS_H_
#define __UTILS_H_

#include "../ncnn/mat.h"
#include <cstdio>
#include <unistd.h>
#include <string>
#include "assert.h"

#define random(x)  rand()%(x)
#define u_align(x,n)  ((x+n-1) & -n)  

static std::string uchar2string(unsigned char a){
    std::string str= "";
    str += a / 100 + 0x30;
    str += (a % 100) / 10 + 0x30;
    str += a % 10 + 0x30;
    return str;
}

static void cstr(std::string str, char* cstr){
    int len = str.length();
    for(int i=0; i<len; i++){
        cstr[i] = str[i]; 
    }
    cstr[len] = '\0';
}


template <typename T> static void log_mat_file(ncnn::Mat& data, char* filename, unsigned int limit_c=-1, int hex_out=0, int is_float = 0){
    FILE* fp = fopen(filename,"w+");
    if(fp == NULL){
        printf("[error]: %s open is failed\n",filename);
        assert(0);
    }
    fprintf(fp,"[ log ]: mat_elemsize = %ld, mat_dims = %d\n",data.elemsize,data.dims);
    fprintf(fp,"[ log ]: mat_w = %d, mat_h = %d, mat_c = %d\n",data.w,data.h,data.c);
    for(int ic=0; ic<data.c; ic++){
        if(ic >= limit_c) 
            break;
        fprintf(fp,"\n//----------------- oc = %d -----------------//\n",ic);
        T* i_ptr = data.channel(ic);
        fprintf(fp,"oc_ptr = %p\n",i_ptr);
        for(int h=0; h<data.h; h++){
            for(int w=0; w<data.w; w++){
                if(sizeof(T) == 1)
                    if(hex_out)
                        fprintf(fp,"%02x\t",*((unsigned char*)i_ptr++));
                    else
                        fprintf(fp,"% 3d\t",*((char*)i_ptr++));
                else
                    if(hex_out)
                        fprintf(fp,"%08x\t",*((unsigned int*)i_ptr++));                   
                    else if(is_float)
                        fprintf(fp,"%05.5f\t",*((float*)i_ptr++));
                    else
                        fprintf(fp,"%d\t",*((int*)i_ptr++));
            }
            fprintf(fp,"\n");
        }
        fprintf(fp,"\n");
    }
    fclose(fp);
}

static void delete_file(char* filename){
    if(access(filename,F_OK) == 0){
        if(remove(filename) == 1){
            printf("[error]: delete %s is failed\n",filename);
            assert(0);
        }
    }
}

template <typename T> static void log_block32x32_file(ncnn::Mat& data, char* filename, int ow, int oh, int oc, int owh, int kh, int kw, int ic, int hex_out=0, int is_float=0){
    FILE* fp = fopen(filename,"a+");
    if(fp == NULL){
        printf("[error]: %s open is failed\n",filename);
        assert(0);
    }
    fprintf(fp,"\n//------------------------------------------------------------//\n");
    fprintf(fp,"[ log ]: ow = %d, oh = %d, oc = %d\n",ow,oh,oc);
    fprintf(fp,"[ log ]: owh = %d, ic = %d\n",owh,ic);
    fprintf(fp,"[ log ]: kw = %d, kh = %d\n",kw,kh);

    for(int ic=0; ic<data.c; ic++){
        T* i_ptr = data.channel(ic);
        for(int wh=0; wh<data.w*data.h; wh++){
            if(sizeof(T) == 1)
                if(hex_out)
                    fprintf(fp,"%02x\t",*((unsigned char*)i_ptr++));
                else
                    fprintf(fp,"% 3d\t",*((char*)i_ptr++));
            else
                if(hex_out)
                    fprintf(fp,"%08x\t",*((unsigned int*)i_ptr++));                   
                else if(is_float)
                    fprintf(fp,"%05.5f\t",*((float*)i_ptr++));
                else
                    fprintf(fp,"%d\t",*((int*)i_ptr++));
        }
        fprintf(fp,"\n");
    }
    fclose(fp);
}

#endif