//
//  NSMutableArray+QYCSafe.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>
// protocol
#import "QYCAvoidCrashProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (QYCSafe)<QYCAvoidCrashProtocol>

@end

NS_ASSUME_NONNULL_END
