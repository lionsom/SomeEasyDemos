//
//  numberModel.h
//  Analyze_YYModel
//
//  Created by linxiang on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface numberModel : NSObject

/** 手动修改 NSNumberModel中的数据进行测试
 JSON_01
 {
 "age":null,
 "timestamp" : 155868168112311111112323123121321123312213,
 }
 
 JSON_02
 {
 "age":"22",
 "timestamp" : 155868168112311111112323123121321123312213,
 }
 */

@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) int timestamp;

@end

NS_ASSUME_NONNULL_END
