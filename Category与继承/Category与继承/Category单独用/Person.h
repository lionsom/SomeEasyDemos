//
//  Person.h
//  Category与继承
//
//  Created by 启业云 on 2019/7/23.
//  Copyright © 2019 启业云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;


-(void)play;

@end

NS_ASSUME_NONNULL_END
