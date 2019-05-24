//
//  User.m
//  Analyze_YYModel
//
//  Created by linxiang on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "User.h"

@implementation User


/* 返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
 *
 *  1. 该方法是 `字典里的属性Key` 和 `要转化为模型里的属性名` 不一样 而重写的
 *  前：模型的属性   后：字典里的属性
 */
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id",
             @"friend_name":@"friend.name"    // 声明friend_name字段在friend下的name
             };
    
    // 映射可以设定多个映射字段
    // return @{@"uid":@[@"id",@"uid",@"ID"]};
}

/* 当 JSON转为 Model完成后，该方法会被调用。
 *
 * 1. 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model会被忽略。
 * 2. 你也可以在这里做一些自动转换不能完成的工作。
 */
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *timestamp = dic[@"timestamp"];
    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
    // created
    _created = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
    // created_String
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _created_String = [dateFormatter stringFromDate:_created];
    
    return YES;
}


@end
