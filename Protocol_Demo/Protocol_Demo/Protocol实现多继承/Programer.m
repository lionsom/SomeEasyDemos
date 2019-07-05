//
//  Programer.m
//  Protocol_Demo
//
//  Created by 林祥 on 2019/7/5.
//  Copyright © 2019 林祥. All rights reserved.
//

#import "Programer.h"

@interface Programer() <SingProtocol>   // 不公开遵循协议，sing方法外部调用不了

@end

@implementation Programer

- (void)sing {
    NSLog(@"Programer sing");
}

- (void)program {
    NSLog(@"Programer program");
}

- (void)draw {
    NSLog(@"Programer draw");
}

@end
