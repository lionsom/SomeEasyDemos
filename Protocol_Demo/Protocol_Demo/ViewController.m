//
//  ViewController.m
//  Protocol_Demo
//
//  Created by 林祥 on 2019/7/5.
//  Copyright © 2019 林祥. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"

#import "Programer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
// 第四步：创建Person的对象去调用这些遵循的方法
    Person * person = [Person new];
    [person requiredMethod];
    [person optionalMethod];
    
    
// protocol实现多继承，调用
    Programer * program = [Programer new];
    [program draw];
    [program program];
    // [program sing];  // Programer不公开遵循SingProtocol，sing方法外部调用不了
}


@end
