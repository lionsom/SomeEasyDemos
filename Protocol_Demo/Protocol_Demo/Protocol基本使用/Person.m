//
//  Person.m
//  Protocol_Demo
//
//  Created by 林祥 on 2019/7/5.
//  Copyright © 2019 林祥. All rights reserved.
//

#import "Person.h"

@implementation Person

// 第三步：实现方法
- (void)requiredMethod{
    NSLog(@"requiredMethod——必须实现的方法");
}

- (void)optionalMethod{
    NSLog(@"optionalMethod——选择实现的方法");
}

@end
