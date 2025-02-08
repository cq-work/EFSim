#ifndef __CNN_DEMO_H_
#define __CNN_DEMO_H_


namespace demo{
    int yolov3_inference();
    int yolov3_tiny_inference();
    int yolov4_tiny_inference();
    int yolov5s_inference();
    int yolov6n_inference();
    int yolov7_tiny_inference();
    int yolov7_inference();
    int mobilenetssd_inference();
    int mobilenetv2ssd_inference();    //not support
    int mobilenetv3ssd_inference();    //not support
    int mobilenet_yolo_inference();
    int mobilenetv2_yolo_inference();
    int shufflenetv2_inference();
    int simplepose_inference();
    int squeezenet_inference();
    int resnet18_inference();
    int resnet50_inference();
    int resnet101_inference();
    int googlenet_inference();
    int retinaface_inference();       //quantization work not well
    // int yolov3_inference();
}



#endif