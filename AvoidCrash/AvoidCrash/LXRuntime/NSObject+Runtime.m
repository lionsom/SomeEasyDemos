//
//  NSObject+Runtime.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/26.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSObject+Runtime.h"

#import <objc/runtime.h>

@implementation NSObject (Runtime)

+ (void)swapInstanceMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod {
    // class_getInstanceMethod()，如果子类没有实现相应的方法，则会返回父类的方法。
    Method originalM = class_getInstanceMethod(self, originalMethod);
    Method swizzledM = class_getInstanceMethod(self, swizzledMethod);
    
    BOOL didAddMethod = class_addMethod(self,
                                        originalMethod,
                                        method_getImplementation(swizzledM),
                                        method_getTypeEncoding(swizzledM));
    if (didAddMethod) {
        class_replaceMethod(self,
                            swizzledMethod,
                            method_getImplementation(originalM),
                            method_getTypeEncoding(originalM));
    }
    else {
        method_exchangeImplementations(originalM, swizzledM);
    }
}

+ (void)swapClassMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod {
    //类方法实际上是储存在类对象的类(即元类)中，即类方法相当于元类的实例方法,所以只需要把元类传入，其他逻辑和交互实例方法一样。
    Method originalM = class_getClassMethod(self, originalMethod);
    Method swizzledM = class_getClassMethod(self, swizzledMethod);
    method_exchangeImplementations(originalM, swizzledM);
}

@end
