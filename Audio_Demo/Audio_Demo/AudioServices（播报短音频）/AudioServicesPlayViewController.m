//
//  AudioServicesPlayViewController.m
//  Audio_Demo
//
//  Created by linxiang on 2019/5/6.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "AudioServicesPlayViewController.h"

#import <AudioToolbox/AudioToolbox.h>


#define SOUNDID  1109   // 系统所有的铃声的介绍 http://iphonedevwiki.net/index.php/AudioServices

@interface AudioServicesPlayViewController ()

@end

@implementation AudioServicesPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self play_1];
}


-(void)play_1 {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"done" ofType:@"wav"];
    NSURL *fileUrl = [NSURL URLWithString:filePath];
    SystemSoundID soundID = 0;
    
    // 加载音效文件
    // OSStatus所有枚举值的含义，比如kCFStreamErrorDomainSSL, -9824，-25299
    // https://blog.csdn.net/qq_15509071/article/details/53642847
    OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    if (err) {
        NSLog(@"Error occurred assigning system sound!");
        return;
    }
    
    // 把需要销毁的音效文件的ID传递给它既可销毁
    // AudioServicesDisposeSystemSoundID(soundID);
    
    // 添加音频结束时的回调
    AudioServicesAddSystemSoundCompletion(SOUNDID,NULL,NULL,soundCompleteCallBack,NULL);
    
    
    // 播放音效文件
    AudioServicesPlaySystemSound(SOUNDID);                        // 有声音、无震动
    //    AudioServicesPlaySystemSoundWithCompletion(SOUNDID, ^{      // 有声音、无震动、有回调
    //        NSLog(@"block 播放完成");
    //    });
    //    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);       // 无声音、有震动
    
    //    AudioServicesPlayAlertSound(SOUNDID);                       // 有声音、有震动
    //    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{       // 有声音、有震动、有回调
    //        NSLog(@"block 播放完成");
    //    });
}

void soundCompleteCallBack(SystemSoundID soundID, void *clientData) {
    NSLog(@"播放完成");
}

@end
