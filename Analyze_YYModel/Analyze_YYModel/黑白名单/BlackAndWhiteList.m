//
//  BlackAndWhiteList.m
//  Analyze_YYModel
//
//  Created by 林祥 on 2019/5/26.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "BlackAndWhiteList.h"

@implementation BlackAndWhiteList

// 如果实现了该方法，则处理过程中不会处理该列表外的属性。
+ (NSArray *)modelPropertyWhitelist {
    return @[@"uid",@"name"];
}

// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
//+ (NSArray *)modelPropertyBlacklist {
//    return @[@"uid"];
//}

@end
