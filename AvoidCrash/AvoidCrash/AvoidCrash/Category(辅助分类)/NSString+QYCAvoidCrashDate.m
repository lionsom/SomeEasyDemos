//
//  NSString+QYCAvoidCrashDate.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/5.
//  Copyright © 2019 安元. All rights reserved.
//

#import "NSString+QYCAvoidCrashDate.h"

@implementation NSString (QYCAvoidCrashDate)

+ (NSString *)getCurrentTime {
    //1.获取时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    //2.格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    //3.直接转换
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

@end
