//
//  NSObject+QYCMethodSwizzling.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSObject+QYCMethodSwizzling.h"

@implementation NSObject (QYCMethodSwizzling)

+ (void)swapInstanceMethod:(SEL)originalMethod currentMethod:(SEL)swizzledMethod {
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
    Method originalM = class_getClassMethod(self, originalMethod);
    Method swizzledM = class_getClassMethod(self, swizzledMethod);
    method_exchangeImplementations(originalM, swizzledM);
}

@end
