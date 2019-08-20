//
//  ViewController.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/19.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self arr];
}


-(void)arr {
    
//    id arr1 = @[@"1",@"2",@"3"];
//    
//    [arr1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@ %@",key, obj);
//    }];
    
    
    id dic1 = @{@"A":@"111",
                @"B":@"222"
                };
    [dic1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
    
}

@end
