//
//  ViewController.m
//  Objective-C多继承
//
//  Created by 启业云 on 2019/8/1.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

#import "Programmer.h"
#import "Programmer+Coding.h"

#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
/**
 多继承实现一：分类，给类添加属性和方法
 */
    Programmer *programmer = [[Programmer alloc] init];
    programmer.height = @"123";
    [programmer show];
    
/**
 多继承实现二：协议
    1.子类需要实现协议方法
    2.由于协议无法定义属性，所以该方法只能实现方法的多继承
 */
    Student *stu = [Student new];
    [stu running];
    [stu chatting];
    
}


@end
