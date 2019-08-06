//  ViewController.m
//  代码规范
//
//  Created by 启业云 on 2019/8/5.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"
// Controlelr
#import "QYCLoginVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    QYCLoginVC *loginVC = [[QYCLoginVC alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}

@end
