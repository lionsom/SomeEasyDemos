//
//  QYCAvoidCrashMemoryHelper.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QYCAvoidCrashMemoryHelper : NSObject

+ (instancetype)sharedInstace;


/**
 总内存
 */
- (NSString *)appTotalMemory;

/**
 已使用内存
 */
- (NSString *)appUsedMemory;

/**
 已使用内存比例

 @return 12%
 */
- (NSString *)appUsedMemoryPercentage;

@end

NS_ASSUME_NONNULL_END
