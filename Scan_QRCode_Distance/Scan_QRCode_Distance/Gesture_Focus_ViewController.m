//
//  Gesture_Focus_ViewController.m
//  Scan_QRCode_Distance
//
//  Created by linxiang on 2019/5/13.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "Gesture_Focus_ViewController.h"
// 相册权限
#import <Photos/PHPhotoLibrary.h>

//调用系统摄像头文件
#import <AVFoundation/AVFoundation.h>


#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height


@interface Gesture_Focus_ViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIGestureRecognizerDelegate>

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


///记录开始的缩放比例
@property (nonatomic, assign) CGFloat beginGestureScale;
///最后的缩放比例
@property (nonatomic, assign) CGFloat effectiveScale;

@property (nonatomic, assign) CGFloat maxScale;

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIView * coverView;

@end

@implementation Gesture_Focus_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _beginGestureScale = 1.0f;
    _effectiveScale = 1.0f;
    _maxScale = 3.0f;
    
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

    // 有效区域
    CGRect cropRect = CGRectMake(SCREEN_WIDTH/2-110,SCREEN_HEIGHT/2-110,220,220);
    _output.rectOfInterest =  CGRectMake(cropRect.origin.y/SCREEN_HEIGHT,
                                        cropRect.origin.x/SCREEN_WIDTH,
                                        cropRect.size.height/SCREEN_HEIGHT,
                                        cropRect.size.width/SCREEN_WIDTH);
 
    // Setup the still image file output
    _stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey,nil];
    [_stillImageOutput setOutputSettings:outputSettings];
    
    // Session设置
    _session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    // 添加会话输入
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    // 添加会话输出
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    // 添加still image file
    if ([_session canAddOutput:_stillImageOutput]) {
        [_session addOutput:_stillImageOutput];
    }
    // 设置扫码的编码格式
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                    AVMetadataObjectTypeEAN13Code,
                                    AVMetadataObjectTypeEAN8Code,
                                    AVMetadataObjectTypeCode128Code];
    
    // 视频预览图层
    _bgView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_bgView];
    
    _coverView = [[UIView alloc] initWithFrame:cropRect];
    _coverView.backgroundColor = [UIColor greenColor];
    _coverView.alpha = 0.1f;
    [self.view addSubview:_coverView];
    
    // 实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 设置参数
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.bounds;
    // 将图层插入当前视图
    [_bgView.layer insertSublayer:_previewLayer atIndex:0];
    
    // 启动会话
    [_session startRunning];
    
    
    // 捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
    
    // 双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTapGesture];
}

#pragma mark -- 扫描 结果回调

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        // 1. 如果扫描完成，停止会话
        [self.session stopRunning];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"二维码结果 == %@", obj.stringValue);
       
        // 1. 实例化
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"结果" message:obj.stringValue preferredStyle:UIAlertControllerStyleAlert];
        // 2. 添加方法
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        // 3. 显示
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        //扫描失败-无数据
        NSLog(@"扫描失败，二维码内容为空");
    }
}



# pragma mark - 手势

- (void)pinchDetected:(UIPinchGestureRecognizer*)recogniser {
    _effectiveScale = _beginGestureScale * recogniser.scale;
    if (_effectiveScale < 1.0){
        _effectiveScale = 1.0;
    }
    if (_effectiveScale > _maxScale) {
        _effectiveScale = _maxScale;
    }
    [self setScale:_effectiveScale];
}

-(void)handleDoubleTap:(UIPinchGestureRecognizer*)recogniser {
    if (_effectiveScale > 1.0) {
        _effectiveScale = 1.0;
    } else {
        _effectiveScale = _maxScale;
    }
    [self setScale:_effectiveScale];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        _beginGestureScale = _effectiveScale;
    }
    return YES;
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
    [CATransaction setAnimationDuration:0.3];
//    _previewLayer.affineTransform = CGAffineTransformMakeScale(scale, scale);   // 主要是改变相机图层的大小
    _bgView.transform = CGAffineTransformMakeScale(scale, scale);
    [CATransaction commit];

    // 动画 Ⅱ
//    [UIView animateWithDuration:0.3 animations:^{
//        self->_bgView.transform = CGAffineTransformMakeScale(scale, scale);
//    } completion:^(BOOL finished) {
//
//    }];
    
    
    /* 在缩放后的frame上缩放（可以一直缩放）
    CGFloat zoom = scale / videoConnection.videoScaleAndCropFactor;
    _previewLayer.transform = CGAffineTransformScale(_previewLayer.transform, zoom, zoom);
     */
}


#pragma mark - 权限判断

// 相册权限验证
-(BOOL)Authorization_PhotoAlbum {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        /*
         PHAuthorizationStatusNotDetermined = 0, // 默认还没做出选择
         PHAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据
         PHAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
         PHAuthorizationStatusAuthorized         // 用户已经授权应用访问照片数据
         */
        NSLog(@"无权限");
        // 1. 实例化
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请在设置中开启摄像头权限" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        // 2. 添加方法
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            UIApplication *application = [UIApplication sharedApplication];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                if (@available(iOS 10.0, *)) {
                    [application openURL:url options:@{} completionHandler:^(BOOL success) {
                        NSLog(@"iOS10上 - 跳转成功！！！");
                    }];
                } else {
                    NSLog(@"iOS9下 - 跳转成功！！！");
                    [application openURL:url];
                }
            }
        }]];
        // 3. 显示
        [self presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}

// 相机权限验证
-(BOOL)Authorization_Camera {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        /**
         验证相机权限
         AVAuthorizationStatusNotDetermined = 0, // 第一次使用会弹出打开弹窗
         AVAuthorizationStatusRestricted,        // 此应用程序没有被授权访问的照片数据。可能是家长控制权限
         AVAuthorizationStatusDenied,            // 用户已经明确否认了这一照片数据的应用程序访问
         AVAuthorizationStatusAuthorized         // 有权限
         */
        NSLog(@"无权限");
        // 1. 实例化
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请在设置中开启摄像头权限" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        // 2. 添加方法
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            UIApplication *application = [UIApplication sharedApplication];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                if (@available(iOS 10.0, *)) {
                    [application openURL:url options:@{} completionHandler:^(BOOL success) {
                        NSLog(@"iOS10上 - 跳转成功！！！");
                    }];
                } else {
                    NSLog(@"iOS9下 - 跳转成功！！！");
                    [application openURL:url];
                }
            }
        }]];
        // 3. 显示
        [self presentViewController:alert animated:YES completion:nil];
        
        return NO;
    }
    return YES;
}


@end
