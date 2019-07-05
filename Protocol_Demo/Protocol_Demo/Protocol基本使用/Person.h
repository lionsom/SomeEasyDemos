//
//  Person.h
//  Protocol_Demo
//
//  Created by 林祥 on 2019/7/5.
//  Copyright © 2019 林祥. All rights reserved.
//

#import <Foundation/Foundation.h>

// 第一步：导入protocol
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

// 第二步：遵守protocol
@interface Person : NSObject <MyProtocol>

@end

NS_ASSUME_NONNULL_END
