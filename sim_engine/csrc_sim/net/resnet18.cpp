#include "../ncnn/net.h"

#include "../ncnn/simpleocv.h"

#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <time.h>
#include <fstream>
#include <sstream>
#include "../config.h"
#include "Vtop.h"

namespace demo{
static int detect_resnet18(const cv::Mat& bgr, std::vector<float>& cls_scores)
{
    ncnn::Net resnet18;

    resnet18.opt.use_vulkan_compute = false;
    resnet18.opt.use_int8_inference = true;

    //分别加载模型的参数和数据
    // if (resnet18.load_param("/home/cqi/models/resnet/resnet18.param"))
    if (resnet18.load_param("models/resnet/resnet18-opt-int8.param"))
        exit(-1);
    // if (resnet18.load_model("/home/cqi/models/resnet/resnet18.bin"))
    if (resnet18.load_model("models/resnet/resnet18-opt-int8.bin"))
        exit(-1);
	//opencv读取图片是BGR格式，我们需要转换为RGB格式
    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR2RGB, bgr.cols, bgr.rows, 224, 224);
    
    //图像归一标准化，以R通道为例（x/225-0.485）/0.229，化简后可以得到下面的式子
    //需要注意的式substract_mean_normalize里的方差其实是方差的倒数，这样在算的时候就可以将除法转换为乘法计算
    //所以norm_vals里用的是1除
    const float mean_vals[3] = {0.485f*255.f, 0.456f*255.f, 0.406f*255.f};
    const float norm_vals[3] = {1/0.229f/255.f, 1/0.224f/255.f, 1/0.225f/255.f};
    in.substract_mean_normalize(mean_vals, norm_vals);

    ncnn::Extractor ex = resnet18.create_extractor();
	
    //把图像数据放入in0这个blob里
    ex.input("in0", in);

    ncnn::Mat out;
    //提取出推理结果，推理结果存放在out0这个blob里
    ex.extract("out0", out);

    cls_scores.resize(out.w);
    for (int j = 0; j < out.w; j++)
    {
        cls_scores[j] = out[j];
    }

    return 0;
}

// 从文件加载 ImageNet 类别标签的函数
std::vector<std::string> loadLabels(const char* labelPath) {
    std::vector<std::string> labels;
    std::ifstream labelsFile(labelPath);

    if (!labelsFile.is_open()) {
        fprintf(stderr, "Could not open the label file: %s\n", labelPath);
        exit(-1);
    }

    std::string line;
    while (std::getline(labelsFile, line)) {
        // 取逗号前的部分作为类别名称
        size_t pos = line.find(',');
        if (pos != std::string::npos) {
            labels.push_back(line.substr(0, pos));
        } else {
            // 如果没有逗号，直接使用整个字符串
            labels.push_back(line);
        }
    }

    labelsFile.close();
    return labels;
}

// 打印带有标签的前 k 个预测结果的函数
static int print_topk(const std::vector<float>& cls_scores, const std::vector<std::string>& labels, int topk, int right_result, int& is_top1, int& is_top5) {
    // 使用索引对前 k 个元素进行部分排序
    int size = cls_scores.size();
    std::vector<std::pair<float, int>> vec;
    vec.resize(size);
    for (int i = 0; i < size; i++) {
        vec[i] = std::make_pair(cls_scores[i], i);
    }

    std::partial_sort(vec.begin(), vec.begin() + topk, vec.end(),
                      std::greater<std::pair<float, int>>());

    // 打印前 k 个带有标签和分数的结果
    // printf("This is resnet18 result\n");
    printf("\n******************Resnet18 Inference Result*****************\n");
    for (int i = 0; i < topk; i++) {
        float score = vec[i].first;
        int index = vec[i].second;
        // fprintf(stderr, "%d = %f - %s\n", index, score, labels[index].c_str()); 
        fprintf(stderr, "%s: %f\n", labels[index].c_str(), score);
    }
    printf("inference_index = %d\n", vec[0].second); 
    if (vec[0].second == right_result){
        is_top1 = 1;
    } else {
        is_top1 = 0;
    }
    if (vec[0].second == right_result || vec[1].second == right_result || vec[2].second == right_result || vec[3].second == right_result || vec[4].second == right_result){
        is_top5 = 1;
    } else {
        is_top5 = 0;
    }

    // printf("is_top1 = %d\n", is_top1);        
    // printf("is_top5 = %d\n", is_top5);   

    return 0;
}

int resnet18_inference() 
{
    printf("This is a Resnet18 inference\n");
    time_t start_time, end_time;
    double execution_time;
    start_time = time(NULL);   

    // 加载 ImageNet 标签
    const char* labelPath = "models/resnet/catagories.txt";  // 替换为实际路径
    std::vector<std::string> labels = loadLabels(labelPath);

    // 读取label文档
    FILE *file_label;    

    // 打开文件
    file_label = fopen(LABELFILE_PATH_RESNET18, "r");
    if (file_label == NULL) {
        printf("[ log ]: unable access to: %s\n", LABELFILE_PATH_RESNET18);
        return 1;
    }


    std::vector<std::string> image_name;
    std::vector<int> label; 

    char line[100];
    while (fgets(line, sizeof(line), file_label)) {
        char str[100];
        int num;
        if (sscanf(line, "%s %d", str, &num) == 2) {
            image_name.push_back(str);
            label.push_back(num);
        }
    }

    fclose(file_label); 


    FILE *file;
    char a[100];  // 假设每行的最大长度不超过100个字符
    file = fopen(IMAGEFILE_PATH_RESNET18, "r");
    if (file == NULL) {
        printf("[ log ]: unable access to: %s\n", IMAGEFILE_PATH_RESNET18);
        return 1;
    }
    int image_index = 0;
    int all_top1 = 0;
    int all_top5 = 0;
    while (fgets(a, sizeof(a), file) != NULL) {
        printf("[ log ]: get address is: %s\n", a);  // 在这里你可以使用 a 变量进行其他操作
        if (a[strlen(a) - 1] == '\n') {
            a[strlen(a) - 1] = '\0';
        }

        cv::Mat m = cv::imread(a, 1);
        if (m.empty())
        {
            fprintf(stderr, "[ log ]: cv::imread %s failed\n", a);
            return -1;
        }
        printf("[ log ]: loaded image\n\n");

        std::vector<float> cls_scores;
        int right_result = label[image_index];
        detect_resnet18(m, cls_scores);
        int is_top1, is_top5;
        print_topk(cls_scores, labels, 5, right_result, is_top1, is_top5);
    // 打印前 3 个带有标签的预测结果
    // print_topk(cls_scores, labels, 3);

        // printf("right_result = %d\n", right_result);        
        // printf("is_top1 = %d\n", is_top1);        
        // printf("is_top5 = %d\n", is_top5);  

        if (is_top1 == 1) {
            all_top1++;
        } else {
            all_top1 = all_top1;
        }
        if (is_top5 == 1) {
            all_top5++;
        } else {
            all_top5 = all_top5;
        }       
        // printf("all_top1 = %d\n", all_top1);        
        // printf("all_top5 = %d\n", all_top5);    
        image_index++;    
    }

    fclose(file);          
    // printf("all_top1 = %d\n", all_top1);        
    // printf("all_top5 = %d\n", all_top5);       
    float top1_acc = (float)all_top1/label.size();
    float top5_acc = (float)all_top5/label.size();

    
    printf("[ log ]: TOP1 Accuracy is %f %\n", top1_acc*100);
    printf("[ log ]: TOP5 Accuracy is %f %\n", top5_acc*100);
    #ifdef FORWARD_ON_CPU
        printf("[ log ]: resnet18-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: resnet18-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif

    end_time = time(NULL);
    execution_time = difftime(end_time, start_time);
    // printf("程序执行时间: %.2f 秒\n", execution_time);
    return 0;
}
}