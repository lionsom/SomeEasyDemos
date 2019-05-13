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
@property (assign,nonatomic) AVCaptureDevice * device;
/** 输入数据源 */
@property (strong,nonatomic) AVCaptureDeviceInput * input;
/** 输出数据源 */
@property (strong,nonatomic) AVCaptureMetadataOutput * output;
/** 输入输出的中间桥梁 负责把捕获的音视频数据输出到输出设备中 */
@property (strong,nonatomic) AVCaptureSession * session;
/** 相机拍摄预览图层 */
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * previewLayer;
@property (nonatomic,strong) AVCaptureStillImageOutput *stillImageOutput;  //拍照


///记录开始的缩放比例
@property (nonatomic,assign) CGFloat beginGestureScale;
///最后的缩放比例
@property (nonatomic,assign) CGFloat effectiveScale;

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
    if (_effectiveScale > 3.0) {
        _effectiveScale = 3.0;
    }
    [self setScale:_effectiveScale];
}

-(void)handleDoubleTap:(UIPinchGestureRecognizer*)recogniser {
    if (_effectiveScale > 1.0) {
        _effectiveScale = 1.0;
    } else {
        _effectiveScale = 3.0;
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
    
    
    
    // 动画
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
//    _previewLayer.affineTransform = CGAffineTransformMakeScale(scale, scale);   // 主要是改变相机图层的大小
    _bgView.transform = CGAffineTransformMakeScale(scale, scale);
    [CATransaction commit];
    
    // 有效区域
    // 锁住
    CGRect cropRect = CGRectMake(SCREEN_WIDTH/2-110,SCREEN_HEIGHT/2-110,220,220);
    CGRect newRect = [_coverView convertRect:cropRect toView:_bgView];
    _output.rectOfInterest =  CGRectMake(newRect.origin.y/_bgView.frame.size.height,
                                         newRect.origin.x/_bgView.frame.size.width,
                                         newRect.size.height/_bgView.frame.size.height,
                                         newRect.size.width/_bgView.frame.size.width);

    
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


#pragma mark -  焦距

//- (void)CameraScaleAction:(UIButton *)sender{
//    kCameraScale+=0.5;   //去定义一个float类型，默认值为1.0
//    if(kCameraScale>2.5)
//        kCameraScale=1.0;
//    //改变焦距   记住这里的输出链接类型要选中这个类型，否则屏幕会花的
//    AVCaptureConnection *connect=[_metadataOutput connectionWithMediaType:AVMediaTypeVideo];
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:0.2];
//    [sender setTitle:[NSString stringWithFormat:@"%.1fX",(float)kCameraScale] forState:UIControlStateNormal];
//    //主要是改变相机图层的大小
//    [_previewLayer setAffineTransform:CGAffineTransformMakeScale(kCameraScale, kCameraScale)];
//    connect.videoScaleAndCropFactor= kCameraScale;
//    [CATransaction commit];
//    //超出的部分切掉,否则影响扫描效果
//    self.view.clipsToBounds=YES;
//    self.view.layer.masksToBounds=YES;
//}

////对焦
//-(void)foucus:(UITapGestureRecognizer *)sender
//{
//    if(_input.device.position==AVCaptureDevicePositionFront)
//        return;
//    if(sender.state==UIGestureRecognizerStateRecognized)
//    {
//        CGPoint location=[sender locationInView:self.view];
//        //对焦
//        __weak typeof(self) weakSelf=self;
//        [self focusOnPoint:location completionHandler:^{
//            weakSelf.focalReticule.center=location;
//            weakSelf.focalReticule.alpha=0.0;
//            weakSelf.focalReticule.hidden=NO;
//            [UIView animateWithDuration:0.3 animations:^{
//                weakSelf.focalReticule.alpha=1.0;
//            }completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.3 animations:^{
//                    weakSelf.focalReticule.alpha=0.0;
//                }];
//            }];
//        }];
//    }
//}
//
//////对某一点对焦
//-(void)focusOnPoint:(CGPoint)point completionHandler:(void(^)())completionHandler{
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];;
//    CGPoint pointOfInterest = CGPointZero;
//    CGSize frameSize = self.view.bounds.size;
//    pointOfInterest = CGPointMake(point.y / frameSize.height, 1.f - (point.x / frameSize.width));
//    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus])
//    {
//        NSError *error;
//        if ([device lockForConfiguration:&error])
//        {
//            if ([device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance])
//            {
//                [device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
//            }
//            if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
//            {
//                [device setFocusMode:AVCaptureFocusModeAutoFocus];
//                [device setFocusPointOfInterest:pointOfInterest];
//            }
//            if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure])
//            {
//                [device setExposurePointOfInterest:pointOfInterest];
//                [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
//            }
//            [device unlockForConfiguration];
//            if(completionHandler)
//                completionHandler();
//        }
//    }
//    else{
//        if(completionHandler)
//            completionHandler();
//    }
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
