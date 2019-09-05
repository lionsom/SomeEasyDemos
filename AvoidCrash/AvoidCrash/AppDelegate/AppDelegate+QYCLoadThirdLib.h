//
//  AppDelegate+QYCLoadThirdLib.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (QYCLoadThirdLib)

- (void)configureForBugly;

- (void)dealWithCrashMessage:(NSException *)exception;

@end

NS_ASSUME_NONNULL_END
