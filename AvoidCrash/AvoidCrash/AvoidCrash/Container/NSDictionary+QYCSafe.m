//
//  NSDictionary+QYCSafe.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSDictionary+QYCSafe.h"
#import "NSObject+QYCMethodSwizzling.h"

#import "QYCSafeProtector.h"

@implementation NSDictionary (QYCSafe)

+ (void)openSafeProtector {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 类继承关系
        // __NSPlaceholderDictionary    占位字典
        // __NSDictionaryI              继承于 NSDictionary
        // __NSSingleEntryDictionaryI   继承于 NSDictionary
        // __NSDictionary0              继承于 NSDictionary
        // __NSFrozenDictionaryM        继承于 NSDictionary
        // __NSDictionaryM              继承于 NSMutableDictionary
        // __NSCFDictionary             继承于 NSMutableDictionary
        // NSMutableDictionary          继承于 NSDictionary
        // NSDictionary                 继承于 NSObject
        
        Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
        
        /**
         很多类方法，都会调用 initWithObjects:forKeys: 与 initWithObjects:forKeys:count: ，所以可以一并拦截，不需要一一拦截
         NSMutableDictionary继承自NSDictionary，继承的方法也会走这些拦截。
         */
        [__NSPlaceholderDictionary swapInstanceMethod:@selector(initWithObjects:forKeys:) currentMethod:@selector(safe_initWithObjectsP:forKeys:)];
        
        [__NSPlaceholderDictionary swapInstanceMethod:@selector(initWithObjects:forKeys:count:) currentMethod:@selector(safe_initWithObjectsP:forKeys:count:)];
    });
}


//=================================================================
//                  initWithObjects:forKeys:
//=================================================================
#pragma mark - initWithObjects:forKeys:

-(instancetype)safe_initWithObjectsP:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    id instance = nil;
    @try {
        instance = [self safe_initWithObjectsP:objects forKeys:keys];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSPlaceholderDictionary safe_initWithObjectsP:forKeys: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
        return instance;
    }
}

//=================================================================
//                  initWithObjects:forKeys:count:
//=================================================================
#pragma mark - initWithObjects:forKeys:count:

- (instancetype)safe_initWithObjectsP:(const id _Nonnull [_Nullable])objects forKeys:(const id <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_initWithObjectsP:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSPlaceholderDictionary safe_initWithObjectsP:forKeys:count: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
        return instance;
    }
}

@end
