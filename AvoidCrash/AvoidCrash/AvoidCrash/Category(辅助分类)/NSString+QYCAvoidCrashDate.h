//
//  NSString+QYCAvoidCrashDate.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QYCAvoidCrashDate)

/**
 获取当前时间点的具体时间
 
 @return @"2011-01-26 17:40:50"
 */
+ (NSString *)getCurrentTime;

@end

NS_ASSUME_NONNULL_END
