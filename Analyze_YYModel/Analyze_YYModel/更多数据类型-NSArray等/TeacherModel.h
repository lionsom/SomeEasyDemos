//
//  TeacherModel.h
//  Analyze_YYModel
//
//  Created by 林祥 on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TeacherModel : NSObject

@property (strong, nonatomic) NSNumber *teacherid;
@property (copy,   nonatomic) NSString *name;
@property (assign, nonatomic) int age;
@property (strong, nonatomic) NSArray *languages;
@property (strong, nonatomic) NSDictionary *friendinfo;

@end

NS_ASSUME_NONNULL_END
