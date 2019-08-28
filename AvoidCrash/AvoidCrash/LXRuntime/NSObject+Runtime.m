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
    
    //class_addMethod() 判断originalSEL是否在子类中实现，如果只是继承了父类的方法，没有重写，那么直接调用method_exchangeImplementations，则会交换父类中的方法和当前的实现方法。此时如果用父类调用originalSEL，因为方法已经与子类中调换，所以父类中找不到相应的实现，会抛出异常unrecognized selector.
    //当class_addMethod() 返回YES时，说明子类未实现此方法(根据SEL判断)，此时class_addMethod会添加（名字为originalSEL，实现为replaceMethod）的方法。此时在将replacementSEL的实现替换为originMethod的实现即可。
    //当class_addMethod() 返回NO时，说明子类中有该实现方法，此时直接调用method_exchangeImplementations交换两个方法的实现即可。
    //注：如果在子类中实现此方法了，即使只是单纯的调用super，一样算重写了父类的方法，所以class_addMethod() 会返回NO。
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
