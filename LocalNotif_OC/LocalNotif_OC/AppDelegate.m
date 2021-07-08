//
//  AppDelegate.m
//  LocalNotif_OC
//
//  Created by 启业云03 on 2021/7/8.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
     角标(UIUserNotificationTypeBadge)   iOS10以后：UNAuthorizationOption...
     提示音(UIUserNotificationTypeSound)
     提示信息(UIUserNotificationTypeAlert)
     无任何通知(UIUserNotificationTypeNone)
     */
    // 这里 types 可以自定义，如果 types 为 0，那么所有的用户通知均会静默的接收，系统不会给用户任何提示(当然，App 可以自己处理并给出提示)
    UNAuthorizationOptions types = (UNAuthorizationOptions) ( UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound );
    // 设置通知的代理
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    // 申请用户权限
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            // 通知注册成功
            [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                NSLog(@"%@", settings);
            }];
        } else {
            // 通知申请失败
            NSLog(@"通知申请失败！");
        }
    }];
    
    return YES;
}

// 仅当应用程序在前台时，才会调用该方法。 允许前台显示通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSLog(@"");
    completionHandler(UNNotificationPresentationOptionAlert);
}

/*
当接收到通知后，在用户点击通知激活应用程序时调用这个方法，无论是在前台还是后台
*/
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"------------当前应用无论是在前台还是后台，收到了通知消息，用户点击该消息----------------");
        
    UNNotification *notif = response.notification;
    UNNotificationRequest *request = notif.request;
    NSLog(@"id = %@", request.identifier);
    
    
    UIViewController *A = [self getRootViewController];
    UIAlertController *Alert = [UIAlertController alertControllerWithTitle:@"12321" message:request.identifier preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [Alert addAction:cancel];
    [A presentViewController:Alert animated:YES completion:nil];

    completionHandler();
}


- (UIViewController *)getRootViewController{
    UIWindow* window = [self getRootWindow];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}


- (UIWindow *)getRootWindow {
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            window.windowLevel == UIWindowLevelNormal &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
