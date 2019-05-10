//
//  ViewController.m
//  ShowSandBoxFile_SendFileByMail_Demo
//
//  Created by linxiang on 2019/5/10.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "ViewController.h"

#import "Study_ShowSandBoxVC.h"
#import "OSCELOGManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)ShowSandBoxBtn:(id)sender {
    Study_ShowSandBoxVC * view = [Study_ShowSandBoxVC new];
    [self presentViewController:view animated:YES completion:^{
    }];
}

- (IBAction)WriteFileBtn:(id)sender {
    OSCELog(@"sdsdafadfsaf");
    OSCELog(@"你好啊啊啊啊");
}


@end
