//
//  Person+B.m
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Person+B.h"
#import <objc/runtime.h>

#import "Person+A.h"

@implementation Person (B)

-(void)setSchool:(NSString *)school {
    objc_setAssociatedObject(self, @selector(school), school, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)school {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - method

-(void)play_B {
    NSLog(@"in Person+B Play = %@", self.sex);
}

@end
