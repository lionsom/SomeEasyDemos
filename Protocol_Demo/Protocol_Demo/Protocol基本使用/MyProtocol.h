//
//  MyProtocol.h
//  Protocol_Demo
//
//  Created by 林祥 on 2019/7/5.
//  Copyright © 2019 林祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol的基本用途：
 （1）可以用来声明一大堆方法（不能声明成员变量）
 （2）只要某个类遵守了这个协议，就相当于拥有这个协议中的所有方法声明
 （3）只要父类遵守了某个协议，就相当于子类也遵守了
 （4）Protocol来代替实现多继承
 
 注意：在其中声明需要的方法，但要注意的是这里只做声明，不做实现。并且不能声明变量。
 */
@protocol MyProtocol <NSObject>

// (默认) 要求实现，如果没有实现，会发出警告，但不报错
@required
- (void)requiredMethod;


// 不要求实现，不实现也不会有警告
@optional
-(void)optionalMethod;

@end

NS_ASSUME_NONNULL_END
