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
    //====================
    //   instance method
    //====================
    
    Class __NSArray = NSClassFromString(@"NSArray");
    
//    [__NSArray swapClassMethod:@selector(arrayWithObjects:count:) currentMethod:@selector(AvoidCrashArrayWithObjects:count:)];
    
    
}


//=================================================================
//                        instance array
//=================================================================
#pragma mark - instance array


+ (instancetype)AvoidCrashArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
//        NSString *defaultToDo = @"AvoidCrash default is to remove nil object and instance a array.";
//        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self AvoidCrashArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}



@end
