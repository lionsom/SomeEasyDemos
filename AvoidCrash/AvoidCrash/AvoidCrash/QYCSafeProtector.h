//
//  QYCSafeProtector.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^QYCSafeProtectorCatchExceptionBlock)(NSException *exception);

NS_ASSUME_NONNULL_BEGIN

@interface QYCSafeProtector : NSObject

/**
 开启防Crash，并且通过block获取到异常

 @param block block
 */
+ (void)openAllProtectorWithBlock:(QYCSafeProtectorCatchExceptionBlock)block;

/**
 处理捕捉到的异常
 
 @param exception 异常
 */
+ (void)handlerCrash:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
