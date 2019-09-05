//
//  AppDelegate+QYCLoadThirdLib.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import "AppDelegate+QYCLoadThirdLib.h"

// Bugly
#import <Bugly/Bugly.h>
static NSString * const KBuglyAppId = @"47ebc88951";

@interface AppDelegate() <BuglyDelegate>

@end

@implementation AppDelegate (QYCLoadThirdLib)

#pragma mark - Bugly

- (void)configureForBugly {
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.channel = @"App Store";
    config.blockMonitorEnable = YES; // 卡顿监控开关，默认关闭
    config.blockMonitorTimeout = 5;
    config.unexpectedTerminatingDetectionEnable = YES; // 非正常退出事件记录开关，默认关闭
    config.delegate = self;
    config.reportLogLevel = BuglyLogLevelVerbose; // 设置自定义日志上报的级别，默认不上报自定义日志

#ifdef DEBUG
    config.debugMode = YES; // debug 模式下，开启调试模式
#else
    config.debugMode = NO;  // release 模式下，关闭调试模式
#endif

    [Bugly startWithAppId:KBuglyAppId config:config];
    
    // 设置用户标识
    [Bugly setUserIdentifier:@"12345"];  // 记录登录名
}

#pragma mark - AvoidCrash 自定义通知异常回调，并通过Bugly上传

- (void)dealWithCrashMessage:(NSException *)exception {
    //异常拦截并且通过bugly上报
    [Bugly reportException:exception];
}



@end
