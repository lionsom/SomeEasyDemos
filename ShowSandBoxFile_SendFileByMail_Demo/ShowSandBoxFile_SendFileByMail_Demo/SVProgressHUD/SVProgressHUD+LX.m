//
//  SVProgressHUD+LX.m
//  OSCE_GRADE_PAD
//
//  Created by linxiang on 2018/12/19.
//  Copyright © 2018年 minxing. All rights reserved.
//

#import "SVProgressHUD+LX.h"

#define DefaultInterval 1.5f

@implementation SVProgressHUD (LX)


/**
 居中显示 基本设置
 */
+ (void)setConfigInView:(UIView *)view {
    [SVProgressHUD setHapticsEnabled:YES];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark]; //框框背景样式
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear]; // 整个页面背景样式.觉得是否可以透视点击
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];  // 转个圈的样式
    
    // 如果view存在，则放在view层；若不存在，则默认
    if (view) {
        [SVProgressHUD setContainerView:view];   //放置在哪个图层，默认在Window层
    }
    
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)]; // 设置框框最小 大小
    
    // SVProgressHUD 颜色设置
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];// 弹出框颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];// 弹出框内容颜色
    
//    if (center) {
        [SVProgressHUD resetOffsetFromCenter];
//    } else {
//        [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, [UIScreen mainScreen].bounds.size.height/2 - 100)];
//    }
    
    // 对大小边框的设置
    /*
     + (void)setMinimumSize:(CGSize)minimumSize;                         // default is CGSizeZero, can be used to avoid resizing
     + (void)setRingThickness:(CGFloat)width;                            // default is 2 pt
     + (void)setRingRadius:(CGFloat)radius;                              // default is 18 pt
     + (void)setRingNoTextRadius:(CGFloat)radius;                        // default is 24 pt
     + (void)setCornerRadius:(CGFloat)cornerRadius;                      // default is 14 pt
     + (void)setBorderColor:(nonnull UIColor*)color;                     // default is nil
     + (void)setBorderWidth:(CGFloat)width;                              // default is 0
     */
    
    //[SVProgressHUD setMaxSupportedWindowLevel:UIWindowLevelNormal];
}


/**
 底部显示 基本设置
 */
+ (void)setConfigBelowInView:(UIView *)view {
    [SVProgressHUD setHapticsEnabled:YES];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark]; //框框背景样式
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone]; // 整个页面背景样式.觉得是否可以透视点击
    
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];  // 转个圈的样式
    
    // 如果view存在，则放在view层；若不存在，则默认
    if (view) {
        [SVProgressHUD setContainerView:view];   //放置在哪个图层，默认在Window层
    }
    
    [SVProgressHUD setMinimumSize:CGSizeMake(40, 40)]; // 设置框框最小 大小
    
    // SVProgressHUD 颜色设置
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];// 弹出框颜色
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];// 弹出框内容颜色
    
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, [UIScreen mainScreen].bounds.size.height/2 - 100)];
}




// =====================================================
//            日常用法：1s消失  中心显示
// =====================================================

/* 成功 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_main_async_safe(^{
        [self setConfigInView:view];
        [SVProgressHUD showSuccessWithStatus:success];
        [SVProgressHUD dismissWithDelay:DefaultInterval completion:completion];
    });
}


///* 失败 消失回调 */
+ (void)showError:(NSString *)error toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_main_async_safe(^{
        [self setConfigInView:view];
        [SVProgressHUD showErrorWithStatus:error];
        [SVProgressHUD dismissWithDelay:DefaultInterval completion:completion];
    });
}

///* 警告 消失回调 */
+ (void)showInfo:(NSString *)info toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_main_async_safe(^{
        [self setConfigInView:view];
        [SVProgressHUD showInfoWithStatus:info];
        [SVProgressHUD dismissWithDelay:DefaultInterval completion:completion];
    });
}

///* 仅仅显示信息，无图片 消失回调 */
+ (void)showJustInfo:(NSString *)info toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_main_async_safe(^{
        [self setConfigInView:view];
        [SVProgressHUD showImage:nil status:info];   // 图片置空
        [SVProgressHUD dismissWithDelay:DefaultInterval completion:completion];
    });
}

///* 等待页面 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view{
    dispatch_main_async_safe(^{
        [self setConfigInView:view];
        [SVProgressHUD showWithStatus:message];
    });
}
///* 主要配合 showMessage 使用 */
+ (void)hideHUDWithCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_main_async_safe(^{
        [SVProgressHUD dismissWithCompletion:completion];
    });
}


// =====================================================
//            下方显示用法：1s消失  下方显示
// =====================================================

/* 下方显示 信息 */
+ (void)showBelowInfo:(NSString *)info toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion {
    dispatch_main_async_safe(^{
        [self setConfigBelowInView:view];
        [SVProgressHUD showImage:nil status:info];   // 图片置空
        [SVProgressHUD dismissWithDelay:DefaultInterval completion:completion];
    });
}


@end
