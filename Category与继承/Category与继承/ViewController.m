//
//  ViewController.m
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "Person+A.h"
#import "Person+B.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
// Category调用
    Person *p = [Person new];
    p.name = @"lion";
    p.age = 12;
    p.sex = @"man";
    p.school = @"南京";
    
    NSLog(@"%@",p);
    
    [p play];
    [p play_A];
    [p play_B];
    
    
    
    
    
    
}


@end
