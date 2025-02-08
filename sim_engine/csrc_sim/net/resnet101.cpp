
#include "../ncnn/net.h"
#include "../ncnn/simpleocv.h"
#include <algorithm>

#include <stdio.h>
#include <vector>
#include <fstream>
#include <sstream>
#include "../config.h"
#include "../veri.h"

namespace demo {
static int detect_resnet101(const cv::Mat& bgr, std::vector<float>& cls_scores)
{
    ncnn::Net resnet101;

    resnet101.opt.use_int8_inference = true;

    
    if (resnet101.load_param("models/resnet101/resnet101_int8.param"))
        exit(-1);
    if (resnet101.load_model("models/resnet101/resnet101_int8.bin"))
        exit(-1);

    // if (resnet101.load_param_mem(resnet101.load_file2mem("models/resnet101/resnet101_opt.param")))
    //     exit(-1);
    // if (resnet101.load_model_mem(resnet101.load_file2mem("models/resnet101/resnet101_opt.bin")))
    //     exit(-1);

	//opencv读取图片是BGR格式，我们需要转换为RGB格式
    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR2RGB, bgr.cols, bgr.rows, 224, 224);
    
    //图像归一标准化，以R通道为例（x/225-0.485）/0.229，化简后可以得到下面的式子
    //需要注意的式substract_mean_normalize里的方差其实是方差的倒数，这样在算的时候就可以将除法转换为乘法计算
    //所以norm_vals里用的是1除
    const float mean_vals[3] = {0.485f*255.f, 0.456f*255.f, 0.406f*255.f};
    const float norm_vals[3] = {1/0.229f/255.f, 1/0.224f/255.f, 1/0.225f/255.f};
    in.substract_mean_normalize(mean_vals, norm_vals);

    ncnn::Extractor ex = resnet101.create_extractor();
	
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
static std::vector<std::string> loadLabels(const char* labelPath) {
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
static int print_topk(const std::vector<float>& cls_scores, const std::vector<std::string>& labels, int topk) {
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
    printf("\n******************Resnet101 Inference Result*****************\n");
    for (int i = 0; i < topk; i++) {
        float score = vec[i].first;
        int index = vec[i].second;
        // fprintf(stderr, "%d = %f - %s\n", index, score, labels[index].c_str());
        fprintf(stderr, "%s: %f\n", labels[index].c_str(), score);
    }

    return 0;
}

int resnet101_inference() {

    printf("This is a Resnet101 inference!\n");
    // 加载 ImageNet 标签
    const char* labelPath = "models/resnet/catagories.txt";  // 替换为实际路径
    std::vector<std::string> labels = loadLabels(labelPath);

    // 使用 OpenCV 读取图像
    cv::Mat m = cv::imread(IMAGE_PATH, 1);
    if (m.empty())
    {
        printf("[error]: cv::imread is failed\n");
        return -1;
    }

    std::vector<float> cls_scores;
    detect_resnet101(m, cls_scores);

    // 打印前 3 个带有标签的预测结果
    print_topk(cls_scores, labels, 3);

    // double time_ms = (main_time/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // double time_pool_ms = (time_pool/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // double time_gemm_ms = (time_gemm/2*1000.f) / (HW_FREQ_MHZ*1000000.f);
    // printf("[ log ]: FREQ = %dMHz, CYCLES = %ld, TIME = %.3fms, FPS = %.3f\n",HW_FREQ_MHZ,main_time/2,time_ms,1000.f/time_ms);
    // printf("[ log ]: POOL_TIME = %f, %.5f%%\n", time_pool_ms, time_pool_ms/time_ms*100.f);
    // printf("[ log ]: GEMM_TIME = %f, %.5f%%\n", time_gemm_ms, time_gemm_ms/time_ms*100.f);
    #ifdef FORWARD_ON_CPU
        printf("[ log ]: resnet101-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: resnet101-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif
    return 0;
}
}