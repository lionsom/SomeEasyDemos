//
//  NSArray+Safe.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/26.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSArray+Safe.h"

#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation NSArray (Safe)

+ (void)load
{
    Class __NSArray = NSClassFromString(@"NSArray");    // NSArray
    Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");  // [NSArray alloc]; alloc后所得到的类
    Class __NSArray0 = NSClassFromString(@"__NSArray0");     // 当init为一个空数组后，变成了__NSArray0
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");  // 如果有且仅有一个元素，那么为__NSSingleObjectArrayI
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");       // 如果数组大于一个元素，那么为__NSArrayI

    
//=================================================================
//                        Creating an Array
//=================================================================
    // 类方法
    [__NSArray swapClassMethod:@selector(arrayWithObject:) currentMethod:@selector(safe_arrayWithObject:)];
    [__NSArray swapClassMethod:@selector(arrayWithObjects:count:) currentMethod:@selector(safe_ArrayWithObjects:count:)];
    // 实例方法
    [__NSPlaceholderArray swapInstanceMethod:@selector(initWithObjects: count:) currentMethod:@selector(safe_initWithObjects: count:)];
    
//=================================================================
//                        Querying an Array
//=================================================================
    // objectAtIndex:
    [__NSArray0 swapInstanceMethod:nil currentMethod:nil];
    [__NSSingleObjectArrayI swapInstanceMethod:nil currentMethod:nil];
    [__NSArrayI swapInstanceMethod:nil currentMethod:nil];
    
    // objectAtIndexedSubscript
    
    
    // objectsAtIndexes
}


//=================================================================
//                        Creating an Array
//=================================================================
#pragma mark - Creating an Array

+ (instancetype)safe_arrayWithObject:(id)anObject {
    id instance = nil;
    @try {
        instance = [self safe_arrayWithObject:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"safe_arrayWithObject: 崩溃拦截");
        // 以下是对错误数据的处理，元素为空，则数组创建失败；
        if (anObject) {
            instance = [self safe_arrayWithObject:anObject];
        }
        else {
            instance = nil;
        }
    }
    @finally {
        return instance;
    }
}

+ (instancetype)safe_ArrayWithObjects:(const id _Nonnull [_Nonnull])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_ArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"safe_ArrayWithObjects:count: 崩溃拦截");
        // 以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safe_ArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
    
    return nil;
}

- (instancetype)safe_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"safe_initWithObjects:count: 崩溃拦截");
        // 以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id   newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safe_initWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}


@end
