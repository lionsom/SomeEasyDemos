//
//  NSArray+QYCSafe.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSArray+QYCSafe.h"
#import "NSObject+QYCMethodSwizzling.h"

#import "QYCSafeProtector.h"

@implementation NSArray (QYCSafe)

+ (void)openSafeProtector {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 类继承关系
        // __NSPlaceholderArray       占位数组
        // __NSArrayI                 继承于 NSArray
        // __NSSingleObjectArrayI     继承于 NSArray
        // __NSArray0                 继承于 NSArray
        // __NSFrozenArrayM           继承于 NSArray
        // __NSArrayM                 继承于 NSMutableArray
        // __NSCFArray                继承于 NSMutableArray
        // NSMutableArray             继承于 NSArray
        // NSArray                    继承于 NSObject
        
        Class __NSArray = NSClassFromString(@"NSArray");                              // NSArray
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");      // [NSArray alloc]; alloc后所得到的类
        Class __NSArray0 = NSClassFromString(@"__NSArray0");                          // 当init为一个空数组后，变成了__NSArray0
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");  // 如果有且仅有一个元素，那么为__NSSingleObjectArrayI
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");                          // 如果数组大于一个元素，那么为__NSArrayI
        
        
        //=================================================================
        //                        Creating an Array
        //=================================================================
        /** 类方法
         这两个乃是类方法，底层同样会调用 initWithObjects: count: 实例方法，所以
         若 __NSPlaceholderArray initWithObjects: count: 不重写，则这两个类方法会走自己的重写方法拦截；
         若 __NSPlaceholderArray initWithObjects: count: 重写，则会走此方法拦截；
         */
        [__NSArray swapClassMethod:@selector(arrayWithObject:) currentMethod:@selector(safe_arrayWithObject:)];
        [__NSArray swapClassMethod:@selector(arrayWithObjects:count:) currentMethod:@selector(safe_arrayWithObjects:count:)];
        // 实例方法
        [__NSPlaceholderArray swapInstanceMethod:@selector(initWithObjects: count:) currentMethod:@selector(safe_initWithObjectsP: count:)];
        
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
    });
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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
        return instance;
    }
}

#pragma mark ------ initWithObjects: count: ------
- (instancetype)safe_initWithObjectsP:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt {
    id instance = nil;
    @try {
        instance = [self safe_initWithObjectsP:objects count:cnt];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSPlaceholderArray safe_initWithObjectsP:count: 崩溃拦截");
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];

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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
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
        [QYCSafeProtector handlerCrash:exception];
    }
    @finally {
    }
}


@end
