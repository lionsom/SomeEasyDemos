//
//  VoicePlayManager.h
//  OSCE_GRADE_PAD
//
//  Created by linxiang on 2019/2/25.
//  Copyright © 2019年 minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoicePlayManager : NSObject

+(instancetype)shareVoicePlayManager;

/**
 开启朗读
 注意:连续添加多个该方法，阅读器会一一朗读。

 @param content 朗读内容
 */
-(void)startSpeek:(NSString *)content;

-(BOOL)pauseSpeek;

-(BOOL)continueSpeek;

-(BOOL)stopSpeek;

@end

NS_ASSUME_NONNULL_END
