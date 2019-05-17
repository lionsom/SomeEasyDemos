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



- (IBAction)WriteImageBtn:(id)sender {
    // 保存到沙盒
    UIImage * imgsave = [UIImage imageNamed:@"图片01.png"];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"OSCE"];
    NSString * Pathimg =[path stringByAppendingString:@"/图片01.png"];
    [UIImagePNGRepresentation(imgsave) writeToFile:Pathimg atomically:YES];
}


- (IBAction)WriteMp3Btn:(id)sender {
    // 保存到沙盒
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"平凡之路" ofType:@"mp3"];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"OSCE"];
    NSString * Pathimg =[path stringByAppendingString:@"/平凡之路.mp3"];

    [data writeToFile:Pathimg atomically:NO];
}


- (IBAction)WriteVideoBtn:(id)sender {
    // 保存到沙盒
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"演示" ofType:@"mov"];
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"OSCE"];
    NSString * Pathimg =[path stringByAppendingString:@"/演示.mov"];

    [data writeToFile:Pathimg atomically:NO];
}



@end
