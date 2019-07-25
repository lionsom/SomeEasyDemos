//
//  Person.m
//  Category深入
//
//  Created by 启业云 on 2019/7/24.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

+(void)eat {
    NSLog(@"本类 类方法：eat");
}

-(void)run {
    NSLog(@"本类 对象方法：run");
}

@end


@implementation Person (DD)

#pragma mark - setter/getter
-(void)setHeight:(NSString *)height {
    objc_setAssociatedObject(self, @selector(height), height, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)height {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setWeight:(NSNumber *)weight {
    objc_setAssociatedObject(self, @selector(weight), weight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSNumber *)weight {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - Method
+(void)eat_Category {
    NSLog(@"分类 类方法：eat_Category");
}

-(void)run_Category {
    NSLog(@"分类 对象方法：run_Category");
}

#pragma mark - Protocol method
-(void)requiredMethod {
    NSLog(@"分类 Protocol requiredMethod");
}

-(void)optionalMethod {
    NSLog(@"分类 Protocol optionalMethod");
}


@end
