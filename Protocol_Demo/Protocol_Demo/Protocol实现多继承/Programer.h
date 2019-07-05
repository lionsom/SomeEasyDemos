//
//  Programer.h
//  Protocol_Demo
//
//  Created by 林祥 on 2019/7/5.
//  Copyright © 2019 林祥. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProgramProtocol.h"
#import "SingProtocol.h"
#import "DrawProtocol.h"

NS_ASSUME_NONNULL_BEGIN

// 遵循三个协议
@interface Programer : NSObject <ProgramProtocol,DrawProtocol>

@end

NS_ASSUME_NONNULL_END
