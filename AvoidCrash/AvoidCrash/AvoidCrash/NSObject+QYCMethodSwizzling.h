//
//  NSObject+QYCMethodSwizzling.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>
// Runtime header
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (QYCMethodSwizzling)

/**
 实例方法交换

 @param originalMethod 系统原始方法
 @param swizzledMethod 交换的新方法
 */
+ (void)swapInstanceMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod;

/**
 类方法交换

 @param originalMethod 系统原始方法
 @param swizzledMethod 交换的新方法
 */
+ (void)swapClassMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod;

@end

NS_ASSUME_NONNULL_END
