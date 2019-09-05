//
//  NSString+QYCAvoidCrashDeviceInfo.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSString+QYCAvoidCrashDeviceInfo.h"
// for Device Info
#import <UIKit/UIKit.h>
#import "sys/utsname.h"

#import "QYCAvoidCrashMemoryHelper.h"

@implementation NSString (QYCAvoidCrashDeviceInfo)

// **************** APP ******************

+(NSString *)getAPPInfo_BundleName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [infoDictionary objectForKey:@"CFBundleName"];
    return name;
}

+(NSString *)getAPPInfo_BundleDisplayName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return name;
}

+(NSString *)getAPPInfo_BundleIdentifier {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return name;
}

+(NSString *)getAPPInfo_BundleShortVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return name;
}

+(NSString *)getAPPInfo_BundleVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [infoDictionary objectForKey:@"CFBundleVersion"];
    return name;
}



// **************** Device ******************

// 屏幕尺寸
+(NSString *)getDeviceScreenSize {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    
    return [NSString stringWithFormat:@"%.0f * %.0f",w,h];
}

/// 获取设备版本号
+ (NSString *)getDeviceName {
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}


/// 获取iPhone名称
+ (NSString *)getiPhoneName {
    return [UIDevice currentDevice].name;
}

/// 当前系统名称
+ (NSString *)getSystemName {
    return [UIDevice currentDevice].systemName;
}

/// 当前系统版本号
+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

/// 获取当前语言
+ (NSString *)getDeviceLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}

/// 获取总内存大小
+ (NSString *)getTotalMemorySize {
    long long All = [NSProcessInfo processInfo].physicalMemory;
    float ALL_G = All / 1024 / 1024 /1024;  //默认转换为G
    if (ALL_G > 0) {
        return [NSString stringWithFormat:@"%.0f G",ALL_G];
    }else {
        float ALL_M = All / 1024 / 1024;  // 不足G，则转换为M
        return [NSString stringWithFormat:@"%.0f M",ALL_M];
    }
    return @"查询失败";
}

/// 获取总内存大小 方法二
+ (NSString *)getTotalMemorySize_2 {
    QYCAvoidCrashMemoryHelper * memoryHelper = [QYCAvoidCrashMemoryHelper sharedInstace];
    return [memoryHelper appTotalMemory];
}
/// 获取当前使用内存大小
+ (NSString *)getCurrentMemorySize {
    QYCAvoidCrashMemoryHelper * memoryHelper = [QYCAvoidCrashMemoryHelper sharedInstace];
    return [memoryHelper appUsedMemory];
}

/// 获取当前使用内存比例
+ (NSString *)getCurrentMemoryPercentage {
    QYCAvoidCrashMemoryHelper * memoryHelper = [QYCAvoidCrashMemoryHelper sharedInstace];
    return [memoryHelper appUsedMemoryPercentage];
}


@end
