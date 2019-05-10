//
//  OSCELOGManager.h
//  OSCE_GRADE_PAD
//
//  Created by linxiang on 2019/5/7.
//  Copyright © 2019 minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

// 这里执行的是debug模式下
#define OSCELog(fmt ,...) [[OSCELOGManager shareManager] writeLogToFile:[[NSString stringWithUTF8String:__FILE__] lastPathComponent] :NSStringFromSelector(_cmd) :[NSString stringWithFormat:@"%d",__LINE__] :(fmt), ##__VA_ARGS__];

NS_ASSUME_NONNULL_BEGIN

@interface OSCELOGManager : NSObject

+(instancetype)shareManager;

-(void)writeLogToFile:(NSString *)file :(NSString *)function :(NSString *)line :(NSString *)format, ...;

@end

NS_ASSUME_NONNULL_END
