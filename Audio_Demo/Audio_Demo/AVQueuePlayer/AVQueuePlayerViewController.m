//
//  AVQueuePlayerViewController.m
//  Audio_Demo
//
//  Created by linxiang on 2019/5/6.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "AVQueuePlayerViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface AVQueuePlayerViewController ()

@property(nonatomic,strong) NSArray<AVPlayerItem *> *musics;
@property(nonatomic,strong) AVQueuePlayer *player;

@end

@implementation AVQueuePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *musicStringArray = @[@"http://mp3.haoduoge.com/s/2017-08-24/1503559101.mp3",@"http://mp3.haoduoge.com/s/2017-08-23/1503501332.mp3",@"http://mp3.haoduoge.com/s/2017-08-24/1503554791.mp3"];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSString *musicUrl in musicStringArray) {
        AVPlayerItem *itme = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:musicUrl]];
        [tempArray addObject:itme];
    }
    self.musics = [tempArray copy];
    self.player = [[AVQueuePlayer alloc] initWithItems:self.musics];
    [self.player play];
}

@end
