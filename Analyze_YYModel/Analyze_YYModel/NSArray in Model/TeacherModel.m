//
//  TeacherModel.m
//  Analyze_YYModel
//
//  Created by 林祥 on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "TeacherModel.h"

#import "StudentModel.h"

@implementation TeacherModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // 方式一：
    return @{@"students" : [StudentModel class]};
    
    // 方式二：
    return @{@"students" : StudentModel.class};
    
    // 方式三：
    return @{@"students" : @"StudentModel"};
}

@end
