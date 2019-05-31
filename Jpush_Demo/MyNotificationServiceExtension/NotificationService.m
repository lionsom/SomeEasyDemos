//
//  NotificationService.m
//  MyNotificationServiceExtension
//
//  Created by linxiang on 2019/5/29.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "NotificationService.h"

#import <AVFoundation/AVFoundation.h>

@interface NotificationService ()<AVSpeechSynthesizerDelegate> {
    // 语音合成器 控制播放、暂停、关闭
    AVSpeechSynthesizer * _synthesizer;
}

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    self.contentHandler(self.bestAttemptContent);
    
    
    [self speek:@"支付宝到账10元"];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}



#pragma mark - D

-(void)speek:(NSString *)content {
    
    // 合成器 初始化
    _synthesizer = [[AVSpeechSynthesizer alloc] init];
    // delegeate
    _synthesizer.delegate = self;
    
    // 实例化发声对象 AVSpeechUtterance，指定要朗读的内容
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:content];
    // 需要读的语言类型
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
    /* 语速0.0f~1.0f
     AVSpeechUtteranceMinimumSpeechRate
     AVSpeechUtteranceMaximumSpeechRate
     AVSpeechUtteranceDefaultSpeechRate
     */
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
        // iOS 9.0 以上系统的处理
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate;
    } else {
        // iOS 9.0 以下系统的处理
        utterance.rate = 0.2;
    }
    // 音量 [0-1] Default = 1
    utterance.volume = 1.0f;
    // 声音的音调 [0.5 - 2] Default = 1
    utterance.pitchMultiplier = 1.0f;
    // 读完一段后的停顿时间  Default is 0.0
    utterance.postUtteranceDelay = 0.0f;
    // 读一段话之前的停顿时间  Default is 0.0
    utterance.preUtteranceDelay = 0.0f;
    
    // 开始播放
    [_synthesizer speakUtterance:utterance];
}



@end
