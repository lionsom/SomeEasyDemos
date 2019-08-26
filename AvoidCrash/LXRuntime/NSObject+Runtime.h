//
//  NSObject+Runtime.h
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/26.
//  Copyright © 2019 启业云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Runtime)

/** 实例方法交换 */
+ (void)swapInstanceMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod;

/** 类方法交换 */
+ (void)swapClassMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod;

@end

NS_ASSUME_NONNULL_END
