//
//  VoicePlayManager.m
//  OSCE_GRADE_PAD
//
//  Created by linxiang on 2019/2/25.
//  Copyright © 2019年 minxing. All rights reserved.
//

#import "VoicePlayManager.h"

#import <AVFoundation/AVFoundation.h>

@interface VoicePlayManager()<AVSpeechSynthesizerDelegate> {
    // 语音合成器 控制播放、暂停、关闭
    AVSpeechSynthesizer * _synthesizer;
}

@end

@implementation VoicePlayManager

+(instancetype)shareVoicePlayManager {
    static VoicePlayManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 初始化单例
        _manager = [[VoicePlayManager alloc] init];
    });
    return _manager;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        // 合成器 初始化
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
        // delegeate
        _synthesizer.delegate = self;
    }
    return self;
}


-(void)startSpeek:(NSString *)content {
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

-(BOOL)pauseSpeek {
    if (_synthesizer && _synthesizer.isSpeaking) {
        /*
         AVSpeechBoundaryImmediate : 立刻暂停
         AVSpeechBoundaryWord      : 说完一个词后暂停
         */
        return [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    return NO;
}

-(BOOL)continueSpeek {
    if (_synthesizer && _synthesizer.isPaused) {
        return [_synthesizer continueSpeaking];
    }
    return NO;
}

/**
 停止朗读，并且会清理掉当前正在执行朗读操作的队列
 */
-(BOOL)stopSpeek {
    if (_synthesizer) {
        return [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    return NO;
}


#pragma mark - AVSpeechSynthesizer Delegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance {
    // 已经开始说话
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance {
    // 已经完成说话
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
    // 已经暂停说话
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance {
    // 已经继续说话
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance {
    // 已经取消说话
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance {
    // 将要说某段话
}


@end
