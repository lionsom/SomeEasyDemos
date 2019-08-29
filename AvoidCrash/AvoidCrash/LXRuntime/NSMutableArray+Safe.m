//
//  NSMutableArray+Safe.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/29.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSMutableArray+Safe.h"

#import <objc/runtime.h>
#import "NSObject+Runtime.h"

@implementation NSMutableArray (Safe)

+(void)load {
    Class __NSArrayM = NSClassFromString(@"__NSArrayM");                              // __NSArrayM
    Class __NSArrayMutable = NSClassFromString(@"NSArrayMutable");                    // __NSArrayM

//=================================================================
//                 NSMutableArray继承NSArray的方法
//=================================================================
    // objectAtIndex:
    [__NSArrayM swapInstanceMethod:@selector(objectAtIndex:) currentMethod:@selector(safe_objectAtIndexM:)];
    
    // objectAtIndexedSubscript:
    [__NSArrayM swapInstanceMethod:@selector(objectAtIndexedSubscript:) currentMethod:@selector(safe_objectAtIndexedSubscriptM:)];

    // getObjects:range:
    [__NSArrayM swapInstanceMethod:@selector(getObjects:range:) currentMethod:@selector(safe_getObjectsM:range:)];
    
//=================================================================
//                 NSMutableArray扩展的方法
//=================================================================
    
    //==================
    //  Adding Objects
    //==================
    
    // insertObject:atIndex:
    [__NSArrayM swapInstanceMethod:@selector(insertObject:atIndex:) currentMethod:@selector(safe_insertObjectM:atIndex:)];
    // insertObjects:atIndexes:
    [__NSArrayM swapInstanceMethod:@selector(insertObjects:atIndexes:) currentMethod:@selector(safe_insertObjectsM:atIndexes:)];
    
    //==================
    //  Removing Objects
    //==================
    
    // removeObject:inRange:
    [__NSArrayM swapInstanceMethod:@selector(removeObject:inRange:) currentMethod:@selector(safe_removeObjectM:inRange:)];

    // removeObjectAtIndex:
    [__NSArrayM swapInstanceMethod:@selector(removeObjectAtIndex:) currentMethod:@selector(safe_removeObjectAtIndexM:)];
    
    // removeObjectsInRange:
    [__NSArrayM swapInstanceMethod:@selector(removeObjectsInRange:) currentMethod:@selector(safe_removeObjectsInRangeM:)];
    
    // removeObjectsAtIndexes:
    [__NSArrayM swapInstanceMethod:@selector(removeObjectsAtIndexes:) currentMethod:@selector(safe_removeObjectsAtIndexesM:)];

    // removeObjectIdenticalTo:inRange:
    [__NSArrayM swapInstanceMethod:@selector(removeObjectIdenticalTo:inRange:) currentMethod:@selector(safe_removeObjectIdenticalToM:inRange:)];

    //==================
    //  Replacing Objects
    //==================

    // replaceObjectAtIndex:withObject:
    [__NSArrayM swapInstanceMethod:@selector(replaceObjectAtIndex:withObject:) currentMethod:@selector(safe_replaceObjectAtIndexM:withObject:)];

    // setObject:atIndexedSubscript:
    [__NSArrayM swapInstanceMethod:@selector(setObject:atIndexedSubscript:) currentMethod:@selector(safe_setObjectM:atIndexedSubscript:)];
    
    // replaceObjectsAtIndexes:withObjects:
    [__NSArrayM swapInstanceMethod:@selector(replaceObjectsAtIndexes:withObjects:) currentMethod:@selector(safe_replaceObjectsAtIndexesM:withObjects:)];

    // replaceObjectsInRange:withObjectsFromArray:
    [__NSArrayM swapInstanceMethod:@selector(replaceObjectsInRange:withObjectsFromArray:) currentMethod:@selector(safe_replaceObjectsInRangeM:withObjectsFromArray:)];
    
    // replaceObjectsInRange:withObjectsFromArray:range:
    [__NSArrayM swapInstanceMethod:@selector(replaceObjectsInRange:withObjectsFromArray:range:) currentMethod:@selector(safe_replaceObjectsInRangeM:withObjectsFromArray:range:)];
}

//=================================================================
//                 NSMutableArray继承NSArray的方法
//=================================================================

#pragma mark - ============ NSMutableArray继承NSArray的方法 ===========

#pragma mark ------ objectAtIndex: ------

// __NSArrayM objectAtIndex:
- (id)safe_objectAtIndexM:(NSUInteger)index {
    id object=nil;
    @try {
        object = [self safe_objectAtIndexM:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_objectAtIndexM: 崩溃拦截");
    }
    @finally {
        return object;
    }
}

#pragma mark ------ objectAtIndexedSubscript: ------

// __NSArrayM objectAtIndexedSubscript:
-(id)safe_objectAtIndexedSubscriptM:(NSUInteger)index
{
    id object=nil;
    @try {
        object = [self safe_objectAtIndexedSubscriptM:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_objectAtIndexedSubscriptM: 崩溃拦截");
    }
    @finally {
        return object;
    }
}

#pragma mark ------ getObjects:range: ------

// __NSArrayM  getObjects: count:
- (void)safe_getObjectsM:(id _Nonnull __unsafe_unretained [_Nonnull])objects range:(NSRange)range {
    @try {
        [self safe_getObjectsM:objects range:range];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_getObjectsM: range: 崩溃拦截");
    }
    @finally {
    }
}



//=================================================================
//                 NSMutableArray扩展的方法
//=================================================================

#pragma mark - ============ NSMutableArray扩展的方法 ===========

#pragma mark ------ Adding Objects ------

- (void)safe_insertObjectM:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self safe_insertObjectM:anObject atIndex:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_insertObjectM: atIndex: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_insertObjectsM:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    @try {
        [self safe_insertObjectsM:objects atIndexes:indexes];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_insertObjectsM: atIndexes: 崩溃拦截");
    }
    @finally {
        
    }
}


#pragma mark ------ Remove Objects ------

- (void)safe_removeObjectM:(id)anObject inRange:(NSRange)range {
    @try {
        [self safe_removeObjectM:anObject inRange:range];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_removeObjectM: inRange: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_removeObjectAtIndexM:(NSUInteger)index {
    @try {
        [self safe_removeObjectAtIndexM:index];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_removeObjectAtIndexM: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_removeObjectsInRangeM:(NSRange)range {
    @try {
        [self safe_removeObjectsInRangeM:range];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_removeObjectsInRangeM: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_removeObjectsAtIndexesM:(NSIndexSet *)indexes {
    @try {
        [self safe_removeObjectsAtIndexesM:indexes];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_removeObjectsAtIndexesM: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_removeObjectIdenticalToM:(id)anObject inRange:(NSRange)range {
    @try {
        [self safe_removeObjectIdenticalToM:anObject inRange:range];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_removeObjectIdenticalToM: inRange: 崩溃拦截");
    }
    @finally {
        
    }
}

#pragma mark ------ Relace Objects ------

- (void)safe_replaceObjectAtIndexM:(NSUInteger)index withObject:(id)anObject {
    @try {
        [self safe_replaceObjectAtIndexM:index withObject:anObject];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_replaceObjectAtIndexM: withObject: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_setObjectM:(id)obj atIndexedSubscript:(NSUInteger)idx {
    @try {
        [self safe_setObjectM:obj atIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_setObjectM: atIndexedSubscript: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_replaceObjectsAtIndexesM:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    @try {
        [self safe_replaceObjectsAtIndexesM:indexes withObjects:objects];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_replaceObjectsAtIndexesM: withObjects: 崩溃拦截");
    }
    @finally {
        
    }
}

- (void)safe_replaceObjectsInRangeM:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    @try {
        [self safe_replaceObjectsInRangeM:range withObjectsFromArray:otherArray];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_replaceObjectsInRangeM: withObjectsFromArray: 崩溃拦截");
    }
    @finally {
        
    }
}


- (void)safe_replaceObjectsInRangeM:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
    @try {
        [self safe_replaceObjectsInRangeM:range withObjectsFromArray:otherArray range:otherRange];
    }
    @catch (NSException *exception) {
        NSLog(@"__NSArrayM safe_replaceObjectsInRangeM: withObjectsFromArray: range: 崩溃拦截");
    }
    @finally {
        
    }
}


@end
