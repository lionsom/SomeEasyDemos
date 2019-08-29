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

+ (void)load {
    Class __NSArray = NSClassFromString(@"NSArray");                              // NSArray
    Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");      // [NSArray alloc]; alloc后所得到的类
    Class __NSArray0 = NSClassFromString(@"__NSArray0");                          // 当init为一个空数组后，变成了__NSArray0
    Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");  // 如果有且仅有一个元素，那么为__NSSingleObjectArrayI
    Class __NSArrayI = NSClassFromString(@"__NSArrayI");                          // 如果数组大于一个元素，那么为__NSArrayI

    
//=================================================================
//                        Creating an Array
//=================================================================
    /** 类方法
     若 __NSPlaceholderArray initWithObjects: count: 不重写，则这两个类方法会走自己的重写方法拦截；
     若 __NSPlaceholderArray initWithObjects: count: 重写，则会走此方法拦截；
     */
    [__NSArray swapClassMethod:@selector(arrayWithObject:) currentMethod:@selector(safe_arrayWithObject:)];
    [__NSArray swapClassMethod:@selector(arrayWithObjects:count:) currentMethod:@selector(safe_arrayWithObjects:count:)];
    // 实例方法
    [__NSPlaceholderArray swapInstanceMethod:@selector(initWithObjects: count:) currentMethod:@selector(safe_initWithObjects: count:)];
    
//=================================================================
//                        Querying an Array
//=================================================================
    // objectAtIndex:
    [__NSArray0 swapInstanceMethod:@selector(objectAtIndex:) currentMethod:@selector(safe_objectAtIndex0:)];
    [__NSSingleObjectArrayI swapInstanceMethod:@selector(objectAtIndex:) currentMethod:@selector(safe_objectAtIndexSI:)];
    [__NSArrayI swapInstanceMethod:@selector(objectAtIndex:) currentMethod:@selector(safe_objectAtIndexI:)];
    
    // objectAtIndexedSubscript:
    [__NSArrayI swapInstanceMethod:@selector(objectAtIndexedSubscript:) currentMethod:@selector(safe_objectAtIndexedSubscriptI:)];
    
    // objectsAtIndexes:
    [__NSArray swapInstanceMethod:@selector(objectsAtIndexes:) currentMethod:@selector(safe_objectsAtIndexes:)];
    
    // getObjects:range:  不常用
    [__NSArray swapInstanceMethod:@selector(getObjects:range:) currentMethod:@selector(safe_getObjects:range:)];
    [__NSSingleObjectArrayI swapInstanceMethod:@selector(getObjects:range:) currentMethod:@selector(safe_getObjectsSI:range:)];
    [__NSArrayI swapInstanceMethod:@selector(getObjects:range:) currentMethod:@selector(safe_getObjectsI:range:)];
}




//=================================================================
//                        Creating an Array
//=================================================================
#pragma mark - ============ Creating an Array ============

#pragma mark ------ arrayWithObject: ------
+ (instancetype)safe_arrayWithObject:(id)anObject {
    id instance = nil;
    @try {
        instance = [self safe_arrayWithObject:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"NSArray safe_arrayWithObject: 崩溃拦截");
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

#pragma mark ------ arrayWithObjects: count: ------
+ (instancetype)safe_arrayWithObjects:(const id _Nonnull [_Nonnull])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_arrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"NSArray safe_ArrayWithObjects:count: 崩溃拦截");
        // 以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self safe_arrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}

#pragma mark ------ initWithObjects: count: ------
- (instancetype)safe_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSPlaceholderArray safe_initWithObjects:count: 崩溃拦截");
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

//=================================================================
//                        Querying an Array
//=================================================================

#pragma mark - ============ Querying an Array ===========

#pragma mark ------ objectAtIndex: ------

// __NSArray0 objectAtIndex:
- (id)safe_objectAtIndex0:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndex0:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArray0 safe_objectAtIndex0: 崩溃拦截");
    }
    @finally {
        return object;
    }
}

// __NSSingleObjectArrayI objectAtIndex:
- (id)safe_objectAtIndexSI:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self safe_objectAtIndexSI:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSSingleObjectArrayI safe_objectAtIndexSI: 崩溃拦截");
    }
    @finally {
        return object;
    }
}

// __NSArrayI  objectAtIndex:
- (id)safe_objectAtIndexI:(NSUInteger)index {
    id object = nil;
    @try {
        object = [self safe_objectAtIndexI:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayI safe_objectAtIndexI: 崩溃拦截");
    }
    @finally {
        return object;
    }
}


#pragma mark ------ objectAtIndexedSubscript: ------

-(id)safe_objectAtIndexedSubscriptI:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndexedSubscriptI:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayI safe_objectAtIndexedSubscriptI: 崩溃拦截");
    }
    @finally {
        return object;
    }
}

#pragma mark ------ objectsAtIndexes: ------

- (NSArray *)safe_objectsAtIndexes:(NSIndexSet *)indexes {
    NSArray *array = nil;
    @try {
        array = [self safe_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSLog(@"NSArray safe_objectsAtIndexes: 崩溃拦截");
    } @finally {
        return array;
    }
}

#pragma mark ------ getObjects:range: ------

// __NSArray  getObjects: count:
- (void)safe_getObjects:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range {
    @try {
        [self safe_getObjects:objects range:range];
    }
    @catch (NSException *exception) {
        NSLog(@"NSArray safe_getObjects: range: 崩溃拦截");
    }
    @finally {
    }
}

// __NSSingleObjectArrayI  getObjects: count:
- (void)safe_getObjectsSI:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range {
    @try {
        [self safe_getObjectsSI:objects range:range];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSSingleObjectArrayI safe_getObjectsSI: range: 崩溃拦截");
    }
    @finally {
    }
}

// __NSArrayI  getObjects: count:
- (void)safe_getObjectsI:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range {
    @try {
        [self safe_getObjectsI:objects range:range];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayI safe_getObjectsI: range: 崩溃拦截");
    }
    @finally {
    }
}


@end
