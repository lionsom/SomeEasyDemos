//
//  ViewController.m
//  Copy&mutableCopy
//
//  Created by 启业云 on 2019/8/16.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self contain];

}




// 容器
- (void)contain {
    
    NSMutableArray *A = [NSMutableArray arrayWithArray:@[@"1",@"2"]];

    NSMutableArray *B = A.mutableCopy;
    
//    nss B[1] = @"3";
    NSString *c = B[1];
    c = @"333";
    
    NSLog(@"");
}



@end
