//
//  ViewController.m
//  Category深入
//
//  Created by 启业云 on 2019/7/24.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
}


@end
