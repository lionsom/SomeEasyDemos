//
//  Person+A.m
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Person+A.h"
#import <objc/runtime.h>


@implementation Person (A)

-(void)setSex:(NSString *)sex {
    objc_setAssociatedObject(self, @selector(sex), sex, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)sex {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - method

-(void)play_A {
    NSLog(@"in Person+A Play");
}

@end
