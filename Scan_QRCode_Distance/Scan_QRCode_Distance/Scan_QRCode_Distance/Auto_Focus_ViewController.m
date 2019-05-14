//
//  Auto_Focus_ViewController.m
//  Scan_QRCode_Distance
//
//  Created by linxiang on 2019/5/13.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "Auto_Focus_ViewController.h"

//调用系统摄像头文件
#import <AVFoundation/AVFoundation.h>


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface Auto_Focus_ViewController ()<AVCaptureMetadataOutputObjectsDelegate>

/** 拍摄设备 手机的摄像机 */
@property (nonatomic, strong) AVCaptureDevice * device;
/** 输入数据源 */
@property (nonatomic, strong) AVCaptureDeviceInput * input;
/** 输出数据源 */
@property (nonatomic, strong) AVCaptureMetadataOutput * output;
/** 输入输出的中间桥梁 负责把捕获的音视频数据输出到输出设备中 */
@property (nonatomic, strong) AVCaptureSession * session;
/** 相机拍摄预览图层 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer * previewLayer;
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;  //拍照

@end

@implementation Auto_Focus_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAVCapture];
}


#pragma mark - 相机
/**
 createAVCapture相机相关
 */
-(void)createAVCapture {
    //判断是否已经存在
    if (self.session.isRunning) {
        return;
    }
    
    // 获取摄像设备
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 创建输入数据源
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    // 创建输出数据源
    _output = [[AVCaptureMetadataOutput alloc]init];
    // 设置代理 在主线程里刷新
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session设置
    _session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    // 添加会话输入
    [_session addInput:_input];
    // 添加会话输出
    [_session addOutput:_output];
    // 设置扫码的编码格式
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                    AVMetadataObjectTypeEAN13Code,
                                    AVMetadataObjectTypeEAN8Code,
                                    AVMetadataObjectTypeCode128Code];
    
    // 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 设置参数
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.bounds;
    // 将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 启动会话
    [_session startRunning];
}

#pragma mark -- 扫描 结果回调

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        // 1. 如果扫描完成，停止会话
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *obj = (AVMetadataMachineReadableCodeObject *)[self.previewLayer transformedMetadataObjectForMetadataObject:metadataObjects.lastObject];
        
        [self changeVideoScale:obj];
        
        NSLog(@"二维码结果 == %@", obj.stringValue);
    } else {
        //扫描失败-无数据
        NSLog(@"扫描失败，二维码内容为空");
    }
}


- (void)changeVideoScale:(AVMetadataMachineReadableCodeObject *)objc {
    
    NSArray *array = objc.corners;
    CGPoint point = CGPointZero;
    int index = 0;
    CFDictionaryRef dict = (__bridge CFDictionaryRef)(array[index++]);
    // 把点转换为不可变字典
    // 把字典转换为点，存在point里，成功返回true 其他false
    CGPointMakeWithDictionaryRepresentation(dict, &point);
    NSLog(@"X:%f -- Y:%f",point.x,point.y);
    CGPoint point2 = CGPointZero;
    CGPointMakeWithDictionaryRepresentation((__bridge CFDictionaryRef)array[2], &point2);
    NSLog(@"X:%f -- Y:%f",point2.x,point2.y);
    CGFloat scace = 150/(point2.x-point.x); //当二维码图片宽小于150，进行放大
    if (scace > 1) {
        for (CGFloat i= 1.0; i<=scace; i = i+0.001) {
            [self setScale:i];
        }
    }
    return;
}


- (void)setScale:(CGFloat)scale{
    // 锁住
    [_input.device lockForConfiguration:nil];
    //改变焦距   记住这里的输出链接类型要选中这个类型，否则屏幕会花的
    AVCaptureConnection *connect = [_output connectionWithMediaType:AVMediaTypeVideo];
    connect.videoScaleAndCropFactor = scale;
    [_input.device unlockForConfiguration];
    
    
    // 动画 Ⅰ
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    _previewLayer.affineTransform = CGAffineTransformMakeScale(scale, scale);   // 主要是改变相机图层的大小
    [CATransaction commit];
}




@end
