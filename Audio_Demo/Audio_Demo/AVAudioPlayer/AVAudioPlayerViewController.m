//
//  AVAudioPlayerViewController.m
//  Audio_Demo
//
//  Created by linxiang on 2019/5/5.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "AVAudioPlayerViewController.h"

#import <AVFoundation/AVFoundation.h>

/*
 AVAudioPlayer只能播放本地音乐文件
 */
@interface AVAudioPlayerViewController () {
    //声明一个播放器
    AVAudioPlayer * _player;//音乐播放器
}

- (IBAction)startPlayer:(id)sender;
- (IBAction)pausePlayer:(id)sender;
- (IBAction)stopPlayer:(id)sender;

@end




@implementation AVAudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self init_player];
}


-(void)init_player {
    // 创建播放器对象
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"music" withExtension:@"mp3"];
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
    
    // 配置
    _player.volume = 1.0f; // 单独设置音乐的音量（默认1.0，可设置范围为0.0至1.0，两个极端为静音、系统音量）
    _player.pan = -1.0f;   // 修改左右声道的平衡（默认0.0，可设置范围为-1.0至1.0，两个极端分别为只有左声道、只有右声道）
    _player.rate = 0.5;    // 设置播放速度（默认1.0，可设置范围为0.5至2.0，两个极端分别为一半速度、两倍速度）
    _player.numberOfLoops = -1; // 设置循环播放（默认1，若设置值大于0，则为相应的循环次数，设置为-1可以实现无限循环）
    
    if (_player) {
        [_player prepareToPlay];
    }
    
}

#pragma mark - Action


- (IBAction)startPlayer:(id)sender {
    [_player play];
}

- (IBAction)pausePlayer:(id)sender {
    [_player pause];
}

// 这里的stop方法的效果也只是暂停播放，不同之处是stop会撤销prepareToPlay方法所做的准备。
- (IBAction)stopPlayer:(id)sender {
    [_player stop];
}

- (IBAction)volume_Changed:(id)sender {
    UIStepper * vo = (UIStepper *)sender;
    _player.volume = vo.value;
}

@end
