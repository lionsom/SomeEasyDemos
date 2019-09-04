//
//  NSMutableDictionary+QYCSafe.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSMutableDictionary+QYCSafe.h"
#import "NSObject+QYCMethodSwizzling.h"

#import "QYCSafeProtector.h"

@implementation NSMutableDictionary (QYCSafe)

+ (void)openSafeProtector {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        [__NSDictionaryM swapInstanceMethod:@selector(setObject:forKey:) currentMethod:@selector(safe_setObjectM:forKey:)];
        
        [__NSDictionaryM swapInstanceMethod:@selector(setObject:forKeyedSubscript:) currentMethod:@selector(safe_setObjectM:forKeyedSubscript:)];
        
        [__NSDictionaryM swapInstanceMethod:@selector(removeObjectForKey:) currentMethod:@selector(safe_removeObjectForKeyM:)];
    });
}


//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - setObject:forKey:

- (void)safe_setObjectM:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self safe_setObjectM:anObject forKey:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSDictionaryM safe_setObjectM:forKey: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
        
    }
}

//=================================================================
//                  setObject:forKeyedSubscript:
//=================================================================
#pragma mark - setObject:forKeyedSubscript:

- (void)safe_setObjectM:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self safe_setObjectM:obj forKeyedSubscript:key];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSDictionaryM safe_setObjectM:forKeyedSubscript: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
        
    }
}

//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)safe_removeObjectForKeyM:(id)aKey {
    @try {
        [self safe_removeObjectForKeyM:aKey];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSDictionaryM safe_removeObjectForKeyM: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
        
    }
}

@end
