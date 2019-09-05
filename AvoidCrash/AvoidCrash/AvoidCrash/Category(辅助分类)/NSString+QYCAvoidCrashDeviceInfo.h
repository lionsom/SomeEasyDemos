//
//  NSString+QYCAvoidCrashDeviceInfo.h
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (QYCAvoidCrashDeviceInfo)

// **************** APP ******************

+(NSString *)getAPPInfo_BundleName;

+(NSString *)getAPPInfo_BundleDisplayName ;

+(NSString *)getAPPInfo_BundleIdentifier;

+(NSString *)getAPPInfo_BundleShortVersion;

+(NSString *)getAPPInfo_BundleVersion;


// **************** Device ******************
/// 屏幕尺寸
+(NSString *)getDeviceScreenSize;
/// 获取设备版本号
+ (NSString *)getDeviceName;
/// 当前系统名称
+ (NSString *)getSystemName;
/// 获取iPhone名称
+ (NSString *)getiPhoneName;
/// 当前系统版本号
+ (NSString *)getSystemVersion;
/// 获取当前语言
+ (NSString *)getDeviceLanguage;
/// 获取总内存大小 方法一
+ (NSString *)getTotalMemorySize;
/// 获取总内存大小 方法二
+ (NSString *)getTotalMemorySize_2;
/// 获取当前使用内存大小
+ (NSString *)getCurrentMemorySize;
/// 获取当前使用内存比例
+ (NSString *)getCurrentMemoryPercentage;

@end

NS_ASSUME_NONNULL_END
