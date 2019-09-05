//
//  QYCSafeProtector.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCSafeProtector.h"
// Container 容器类
#import "NSArray+QYCSafe.h"
#import "NSMutableArray+QYCSafe.h"
#import "NSDictionary+QYCSafe.h"
#import "NSMutableDictionary+QYCSafe.h"
// KVC
#import "NSObject+QYCKVCSafe.h"
// Device Info
#import "NSString+QYCAvoidCrashDeviceInfo.h"
#import "NSString+QYCAvoidCrashDate.h"


static QYCSafeProtectorCatchExceptionBlock safeProtectorBlock;

@implementation QYCSafeProtector

+ (void)openAllProtectorWithBlock:(QYCSafeProtectorCatchExceptionBlock)block {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        safeProtectorBlock = block;
        
        // 此方法主要预防setValue:forKey:，KVC中还有重写系统方法
        [NSObject openKVCSafeProtector];
        
        [NSArray openSafeProtector];
        [NSMutableArray openSafeProtector];

        [NSDictionary openSafeProtector];
        [NSMutableDictionary openSafeProtector];
    });
}


+ (void)handlerCrash:(NSException *)exception {
    // 堆栈数据
    NSArray *callStackSymbolsArr = exception.callStackSymbols; // [NSThread callStackSymbols];  这两种方法以同样的方法获取堆栈消息，但时间不同。
    // 获取在哪个类的哪个方法中实例化的数组
    NSString *mainMessage = [self safe_getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr];
    if (mainMessage == nil) {
        mainMessage = @"崩溃方法定位失败,请您查看函数调用栈来查找crash原因";
    }
    
    // 新建exception，添加一些自定义的信息，如：crash location
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"location"] = mainMessage;
    NSException *newException = [NSException exceptionWithName:exception.name reason:exception.reason userInfo:userInfo];
    
    // 将数据传出
    if (safeProtectorBlock) {
        safeProtectorBlock(newException);
    }
    
#ifdef DEBUG
    NSString *showCrashStr = [NSString stringWithFormat:@" \
                              \n================================ Crash Start ================================== \
                              \n\t\t------------ APP Info ------------ \
                              \n\t\t[APP Version]: %@ \
                              \n\t\t[APP Memory]: %@ %@ %@ \
                              \n\t\t------------ Device Info ------------ \
                              \n\t\t[Device Type]: %@ \
                              \n\t\t[Device SystemName]: %@ \
                              \n\t\t[Device SystemVersion]: %@ \
                              \n\t\t------------ Crash Info ------------ \
                              \n\t\t[Crash Type]: %@ \
                              \n\t\t[Crash Reason]: %@ \
                              \n\t\t[Crash Location]: %@ \
                              \n[堆栈信息]: \n %@ \
                              \n================================ Crash End ====================================", \
                              [NSString getAPPInfo_BundleShortVersion], \
                              [NSString getTotalMemorySize], \
                              [NSString getCurrentMemorySize], \
                              [NSString getCurrentMemoryPercentage], \
                              [NSString getDeviceName], \
                              [NSString getSystemName], \
                              [NSString getSystemVersion], \
                              exception.name, \
                              exception.reason, \
                              mainMessage, \
                              exception.callStackSymbols];
    NSLog(@"%@", showCrashStr);
#endif
}


#pragma mark -   获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来
/** 参考自 https://github.com/chenfanfang/AvoidCrash
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *
 *  @param callStackSymbols 堆栈主要崩溃信息
 *
 *  @return 堆栈主要崩溃精简化的信息
 */
+ (NSString *)safe_getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols {
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    for (int index = 2; index < callStackSymbols.count; index++) {
        NSString *callStackSymbol = callStackSymbols[index];
        
        [regularExp enumerateMatchesInString:callStackSymbol options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbol.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString* tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];
                
                //get className
                NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                className = [className componentsSeparatedByString:@"["].lastObject;
                
                NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                
                //filter category and system class
                if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                    mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                    
                }
                *stop = YES;
            }
        }];
        
        if (mainCallStackSymbolMsg.length) {
            break;
        }
    }
    
    return mainCallStackSymbolMsg;
}

@end
