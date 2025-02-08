#include "../ncnn/net.h"
#include "../ncnn/simpleocv.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <vector>
#include "../config.h"
#include "Vtop.h"

namespace demo{
struct Object
{
    cv::Rect_<float> rect;
    int label;
    float prob;
};
//bgr为输入特征图
static int detect_yolov3(const cv::Mat& bgr, std::vector<Object>& objects)
{
    ncnn::Net yolov3_tiny;

    yolov3_tiny.opt.use_vulkan_compute = false;
    yolov3_tiny.opt.use_int8_inference = true;

    if (yolov3_tiny.load_param("models/yolov3_tiny/yolov3-tiny-int8.param"))
        exit(-1);
    if (yolov3_tiny.load_model("models/yolov3_tiny/yolov3-tiny-int8.bin"))
        exit(-1);

    const int target_size = 416;

    int img_w = bgr.cols;
    int img_h = bgr.rows;
    ////用于将图像resize为416*416*3大小的规模，mat名为in
    ncnn::Mat in = ncnn::Mat::from_pixels_resize(bgr.data, ncnn::Mat::PIXEL_BGR, bgr.cols, bgr.rows, target_size, target_size);
    printf("[ log ]: in[0] = %d, in[416] = %d\n", int(in[0]), int(in[416]));
    //mean_vals and norm_vals is error     -均值 /归一化因子   参数
    const float mean_vals[3] = {104.0f, 117.0f, 123.0f};
    const float norm_vals[3] = {0.017f, 0.017f, 0.017f};
    in.substract_mean_normalize(mean_vals, norm_vals);

    ncnn::Extractor ex = yolov3_tiny.create_extractor();      //创建生成器

    ex.input("data", in);

    ncnn::Mat out;
    ex.extract("output", out);
    //mat(w,h,c)  out.h的值代表识别出的多个框，包含的信息的w维度，有6个：类别，可能性，框位置
    objects.clear();
    for (int i = 0; i < out.h; i++)
    {
        const float* values = out.row(i);

        Object object;
        object.label = values[0];
        object.prob = values[1];
        object.rect.x = values[2] * img_w;
        object.rect.y = values[3] * img_h;
        object.rect.width = values[4] * img_w - object.rect.x;
        object.rect.height = values[5] * img_h - object.rect.y;

        objects.push_back(object);
    }

    return 0;
}

static int draw_objects(const cv::Mat& bgr, const std::vector<Object>& objects)
{
    static const char* class_names[] = {"background", "person", "bicycle",
                                        "car", "motorbike", "aeroplane", "bus", "train", "truck",
                                        "boat", "traffic light", "fire hydrant", "stop sign",
                                        "parking meter", "bench", "bird", "cat", "dog", "horse",
                                        "sheep", "cow", "elephant", "bear", "zebra", "giraffe",
                                        "backpack", "umbrella", "handbag", "tie", "suitcase",
                                        "frisbee", "skis", "snowboard", "sports ball", "kite",
                                        "baseball bat", "baseball glove", "skateboard", "surfboard",
                                        "tennis racket", "bottle", "wine glass", "cup", "fork",
                                        "knife", "spoon", "bowl", "banana", "apple", "sandwich",
                                        "orange", "broccoli", "carrot", "hot dog", "pizza", "donut",
                                        "cake", "chair", "sofa", "pottedplant", "bed", "diningtable",
                                        "toilet", "tvmonitor", "laptop", "mouse", "remote", "keyboard",
                                        "cell phone", "microwave", "oven", "toaster", "sink",
                                        "refrigerator", "book", "clock", "vase", "scissors",
                                        "teddy bear", "hair drier", "toothbrush"
                                       };

    cv::Mat image = bgr.clone();

    printf("\n******************YOLOv3-Tiny Inference Result*****************\n");
    for (size_t i = 0; i < objects.size(); i++)
    {
        const Object& obj = objects[i];

        fprintf(stderr, "%d = %.5f at %.2f %.2f %.2f x %.2f\n", obj.label, obj.prob,
                obj.rect.x, obj.rect.y, obj.rect.width, obj.rect.height);

        cv::rectangle(image, obj.rect, cv::Scalar(255, 0, 0));

        char text[256];
        sprintf(text, "%s %.1f%%", class_names[obj.label], obj.prob * 100);

        int baseLine = 0;
        cv::Size label_size = cv::getTextSize(text, cv::FONT_HERSHEY_SIMPLEX, 0.5, 1, &baseLine);

        int x = obj.rect.x;
        int y = obj.rect.y - label_size.height - baseLine;
        if (y < 0)
            y = 0;
        if (x + label_size.width > image.cols)
            x = image.cols - label_size.width;

        cv::rectangle(image, cv::Rect(cv::Point(x, y), cv::Size(label_size.width, label_size.height + baseLine)),
                      cv::Scalar(255, 255, 255), -1);

        cv::putText(image, text, cv::Point(x, y + label_size.height),
                    cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(0, 0, 0));
    }


    #ifdef FORWARD_ON_CPU
        cv::imshow("image_yolov3_tiny-CPU", image);
    #endif
    #ifdef FORWARD_ON_CIM
        cv::imshow("image_yolov3_tiny-NPU", image);
    #endif

    return 0;
}

//int main(int argc,char **argv)
int yolov3_tiny_inference()
{
    printf("This is a yolov3_tiny inference!\n");
    

    cv::Mat m = cv::imread(IMAGE_PATH, 1);                 //开始进行数据的读取， 1是color w,h,c
    if (m.empty())
    {
        printf("[error]: cv::imread is failed\n");
        return -1;
    }
    printf("[ log ]: loaded image\n\n");

    std::vector<Object> objects;
    detect_yolov3(m, objects);                             //推理   m为输入特征图

    draw_objects(m, objects);                              //画框


    
    #ifdef FORWARD_ON_CPU
        printf("[ log ]: YOLOv3_Tiny-int8 ACC test on CPU SIMULATION is finished!!!\n");
    #endif
    #ifdef FORWARD_ON_CIM
        printf("[ log ]: YOLOv3_Tiny-int8 ACC test on CIM SIMULATION is finished!!!\n");
    #endif
    return 0;
}
}