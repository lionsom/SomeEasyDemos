//
//  NSDictionary+Safe.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/29.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSDictionary+Safe.h"

#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation NSDictionary (Safe)

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
    
    Class __NSDictionary = NSClassFromString(@"NSDictionary");
    Class __NSPlaceholderDictionary = NSClassFromString(@"__NSPlaceholderDictionary");
    
    /**
     很多类方法，都会调用 initWithObjects:forKeys: 与 initWithObjects:forKeys:count: ，所以可以一并拦截，不需要一一拦截
     NSMutableDictionary继承自NSDictionary，继承的方法也会走这些拦截。
     */
    [__NSPlaceholderDictionary swapInstanceMethod:@selector(initWithObjects:forKeys:) currentMethod:@selector(safe_initWithObjectsP:forKeys:)];
    
    [__NSPlaceholderDictionary swapInstanceMethod:@selector(initWithObjects:forKeys:count:) currentMethod:@selector(safe_initWithObjectsP:forKeys:count:)];
}

-(instancetype)safe_initWithObjectsP:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    id instance = nil;
    @try {
        instance = [self safe_initWithObjectsP:objects forKeys:keys];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSPlaceholderDictionary safe_initWithObjectsP:forKeys: 崩溃拦截");
        //处理错误的数据，重新初始化一个字典
        NSUInteger count = MIN(objects.count, keys.count);
        NSMutableArray *newObjects=[NSMutableArray array];
        NSMutableArray *newKeys=[NSMutableArray array];
        for (int i = 0; i < count; i++) {
            if (objects[i] && keys[i]) {
                [newObjects addObject:objects[i]];
                [newKeys addObject:keys[i]];
            }
        }
        instance = [self safe_initWithObjectsP:newObjects forKeys:newKeys];
    }
    @finally {
        return instance;
    }
}

- (instancetype)safe_initWithObjectsP:(const id _Nonnull [_Nullable])objects forKeys:(const id <NSCopying> _Nonnull [_Nullable])keys count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_initWithObjectsP:objects forKeys:keys count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSPlaceholderDictionary safe_initWithObjectsP:forKeys:count: 崩溃拦截");
        //处理错误的数据，重新初始化一个字典
        NSUInteger index = 0;
        id   newObjects[cnt];
        id   newkeys[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] && keys[i]) {
                newObjects[index] = objects[i];
                newkeys[index] = keys[i];
                index++;
            }
        }
        instance = [self safe_initWithObjectsP:newObjects forKeys:newkeys count:index];
    }
    @finally {
        return instance;
    }
}






@end
