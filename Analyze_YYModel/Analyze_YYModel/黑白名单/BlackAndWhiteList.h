//
//  BlackAndWhiteList.h
//  Analyze_YYModel
//
//  Created by 林祥 on 2019/5/26.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlackAndWhiteList : NSObject

@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;

@end

NS_ASSUME_NONNULL_END
