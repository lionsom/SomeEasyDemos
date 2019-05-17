//
//  SVProgressHUD+LX.h
//  OSCE_GRADE_PAD
//
//  Created by linxiang on 2018/12/19.
//  Copyright © 2018年 minxing. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

//-------------- 确保在主线程下执行操作 ---------------
// 参考自 SDWebImageView
#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (LX)

// =====================================================
//            日常用法：1s消失  中心显示
// =====================================================

///* 成功 消失回调 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion;

///* 失败 消失回调 */
+ (void)showError:(NSString *)error toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion;

///* 警告 消失回调 */
+ (void)showInfo:(NSString *)info toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion;

///* 仅仅显示信息，无图片 消失回调 */
+ (void)showJustInfo:(NSString *)info toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion;

///* 等待页面 */
+ (void)showMessage:(NSString *)message toView:(UIView *)view;
///* 主要配合 showMessage 使用 */
+ (void)hideHUDWithCompletion:(nullable SVProgressHUDDismissCompletion)completion;



// =====================================================
//            下方显示用法：1s消失  下方显示
// =====================================================

/* 下方显示 信息 */
+ (void)showBelowInfo:(NSString *)info toView:(UIView *)view dismissCompletion:(nullable SVProgressHUDDismissCompletion)completion;




@end

NS_ASSUME_NONNULL_END
