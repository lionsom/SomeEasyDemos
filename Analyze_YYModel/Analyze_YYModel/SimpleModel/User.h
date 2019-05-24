//
//  User.h
//  Analyze_YYModel
//
//  Created by linxiang on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (nonatomic, copy) NSNumber *uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSDate *created;
@property (nonatomic, copy) NSString *created_String;
@property (nonatomic, copy) NSNumber *timestamp;
@property (nonatomic, copy) NSNumber *isstu;

@property (nonatomic, copy) NSString *friend_name;

@end

NS_ASSUME_NONNULL_END
