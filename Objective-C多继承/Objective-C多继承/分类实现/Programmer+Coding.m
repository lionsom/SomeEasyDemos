//
//  Programmer+Coding.m
//  Objective-C多继承
//
//  Created by 启业云 on 2019/8/2.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Programmer+Coding.h"

#import <objc/runtime.h>

@implementation Programmer (Coding)

-(void)setHeight:(NSString *)height {
    objc_setAssociatedObject(self, @selector(height), height, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)height {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)show {
    NSLog(@"分类新增方法");
}

@end
