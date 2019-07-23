//
//  Person.m
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Person.h"

#import "Person+A.h"   /// 分类显示sex
#import "Person+B.h"   /// 分类显示sex

@implementation Person

#pragma mark - method

-(void)play {
    
    NSLog(@"in Person Play");
}

#pragma mark - description

-(NSString *)description {
    return [NSString stringWithFormat:@"<%@ : %p> , name = %@, age = %ld, sex = %@, school = %@",[self class], self, self.name, (long)self.age, self.sex, self.school];
}

@end
