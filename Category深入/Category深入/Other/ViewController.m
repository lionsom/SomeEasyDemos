//
//  ViewController.m
//  Category深入
//
//  Created by 启业云 on 2019/7/24.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"

//#import "MyClass.h"
//#import "MyClass+Category_1.h"

#import "Stu.h"
#import "Stu+Stu_Category_1.h"
#import "Stu+Stu_Category_2.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
/**
 第一模块：使用分类添加 类方法、实例方法、属性、协议
 */
/*
    Person *p = [Person new];
    // 本类属性
    p.name = @"lin";
    p.age = 20;
    // 分类属性
    p.height = @"60";
    p.weight = [NSNumber numberWithInteger:120];
    
    // 本类方法
    [Person eat];
    [p run];
    
    // 分类新增方法
    [Person eat_Category];
    [p run_Category];
    
    // 分类 协议方法
    [p requiredMethod];
    [p optionalMethod];
 */
    
/**
 第二模块：查看分类中 load 和 initlization调用顺序
 */
//    MyClass *cls = [MyClass new];
//    [cls printName];  // 分类覆盖本类方法
//    [cls newMethod];  // 分类新增方法
    
    
    
/**
 第三模块：分类替换 本类方法
 */
    [Stu getName];
    Stu *s = [Stu new];
    [s getAge];
    
    [s getSchool];
}


@end
