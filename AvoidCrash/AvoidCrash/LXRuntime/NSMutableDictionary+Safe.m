//
//  NSMutableDictionary+Safe.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/9/2.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation NSMutableDictionary (Safe)

+(void)load {
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
    
    Class __NSDictionaryM = NSClassFromString(@"__NSDictionaryM");
    
    [__NSDictionaryM swapInstanceMethod:@selector(setObject:forKey:) currentMethod:@selector(safe_setObjectM:forKey:)];
    
    [__NSDictionaryM swapInstanceMethod:@selector(setObject:forKeyedSubscript:) currentMethod:@selector(safe_setObjectM:forKeyedSubscript:)];

    [__NSDictionaryM swapInstanceMethod:@selector(removeObjectForKey:) currentMethod:@selector(safe_removeObjectForKeyM:)];
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
    }
    @finally {
        
    }
}



@end
