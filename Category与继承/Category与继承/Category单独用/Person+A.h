//
//  Person+A.h
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (A)

@property(nonatomic, copy) NSString *sex;

-(void)play_A;

@end

NS_ASSUME_NONNULL_END
