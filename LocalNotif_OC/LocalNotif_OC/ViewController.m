//
//  ViewController.m
//  LocalNotif_OC
//
//  Created by 启业云03 on 2021/7/8.
//

#import "ViewController.h"
// 通知类
#import <UserNotifications/UserNotifications.h>

#import "DownloadManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// iOS开发 iOS10推送必看(基础篇)：https://www.jianshu.com/p/f5337e8f336d
// iOS10本地通知参考：https://www.cnblogs.com/XYQ-208910/p/11777352.html
- (IBAction)sendNow:(id)sender {
    
    // 通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    content.badge = @66;
    
    content.body = @"iOS10 新通知";
    
    content.sound = [UNNotificationSound defaultSound];

    content.title = @"我是通知标题";

    content.subtitle = @"我是通知副标题！";
    
    content.userInfo = @{@"1":@1, @"234":@[@1,@2], @"ddd":@{@"a":@3}};
  
    // trigger = nil 立刻发送
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UNNotificationDefault_LLL" content:content trigger:nil];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败");
        } else {
            NSLog(@"成功");
        }
    }];
}

- (IBAction)sendAfter:(id)sender {
 
    // 通知内容
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    
    content.badge = @36;
    
    content.body = @"iOS10 新通知";
    
    content.sound = [UNNotificationSound defaultSound];

    content.title = @"我是通知标题";

    content.subtitle = @"我是通知副标题！";
    
    /*
     1.UNTimeIntervalNotificationTrigger: 时间
     2.UNCalendarNotificationTrigger: 日期
     3.UNLocationNotificationTrigger: 地理位置
     */
    // 1-计时器触发器：8s后执行
    UNTimeIntervalNotificationTrigger *timrTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:8 repeats:NO];

    //
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UNNotificationDefault_LLL" content:content trigger:timrTrigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败");
        } else {
            NSLog(@"成功");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[DownloadManager shareManager] start:@""];
}

@end
