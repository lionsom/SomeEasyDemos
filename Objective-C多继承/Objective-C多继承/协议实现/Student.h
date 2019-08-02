//
//  Student.h
//  Objective-C多继承
//
//  Created by 启业云 on 2019/8/2.
//  Copyright © 2019 启业云. All rights reserved.
//

#import <Foundation/Foundation.h>

// 第一步：引入协议
#import "RunProtocol.h"
#import "ChatProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject <RunProtocol, ChatProtocol>  // 第二步：遵循协议

@end

NS_ASSUME_NONNULL_END
