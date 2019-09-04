//
//  NSObject+QYCKVCSafe.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSObject+QYCKVCSafe.h"
#import "NSObject+QYCMethodSwizzling.h"

#import "QYCSafeProtector.h"

@implementation NSObject (QYCKVCSafe)

+ (void)openKVCSafeProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject swapInstanceMethod:@selector(setValue:forKey:) currentMethod:@selector(safe_setValue:forKey:)];
    });
}

#pragma mark - KVC

- (void)safe_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self safe_setValue:value forKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"NSObject safe_setValue: forKey: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
    }
}


//=================================================================
//                        重写系统方法
//=================================================================
- (void)setNilValueForKey:(NSString *)key {
    NSString *crashMessages = [NSString stringWithFormat:@"crashMessages : [<%@ %p> setNilValueForKey]: could not set nil as the value for the key %@.",NSStringFromClass([self class]),self,key];
    NSLog(@"%@", crashMessages);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSString *crashMessages = [NSString stringWithFormat:@"crashMessages : [<%@ %p> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key: %@,value:%@'",NSStringFromClass([self class]),self,key,value];
    NSLog(@"%@", crashMessages);
}

- (nullable id)valueForUndefinedKey:(NSString *)key {
    NSString *crashMessages = [NSString stringWithFormat:@"crashMessages :[<%@ %p> valueForUndefinedKey:]: this class is not key value coding-compliant for the key: %@",NSStringFromClass([self class]),self,key];
    NSLog(@"%@", crashMessages);

    return self;
}


@end
