//
//  NSObject+QYCKVCSafe.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 特别注意：分类中，有重写系统方法
 */
@interface NSObject (QYCKVCSafe)

/**
 开启KVC保护
 */
+ (void)openKVCSafeProtector;

@end

NS_ASSUME_NONNULL_END
