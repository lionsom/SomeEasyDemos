//
//  QYCSafeProtector.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>


//typedef void(^LSSafeProtectorBlock)(NSException *exception,LSSafeProtectorCrashType crashType);

//typedef void(^QYCSafeProtectorCatchExceptionBlock)(NSException *exception);

NS_ASSUME_NONNULL_BEGIN

@interface QYCSafeProtector : NSObject

+ (void)openAllProtector;

+ (void)handlerCrash:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
