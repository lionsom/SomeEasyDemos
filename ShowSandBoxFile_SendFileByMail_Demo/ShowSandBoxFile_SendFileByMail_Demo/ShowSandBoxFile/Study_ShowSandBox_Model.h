//
//  Study_ShowSandBox_Model.h
//  TodayNews
//
//  Created by linxiang on 2019/4/30.
//  Copyright © 2019 LX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ASFileItemUp,
    ASFileItemDirectory,
    ASFileItemFile,
} ASFileItemType;

NS_ASSUME_NONNULL_BEGIN

@interface Study_ShowSandBox_Model : NSObject

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * path;
@property (nonatomic, copy) NSString * filesize;

@property (nonatomic, assign) ASFileItemType type;

@end

NS_ASSUME_NONNULL_END
