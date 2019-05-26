//
//  TeacherModel.h
//  Analyze_YYModel
//
//  Created by 林祥 on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StudentModel;

NS_ASSUME_NONNULL_BEGIN

@interface TeacherModel : NSObject

@property (copy,   nonatomic) NSString *name;
@property (assign, nonatomic) int age;
@property (strong, nonatomic) NSArray *languages;
@property (strong, nonatomic) NSDictionary *friendinfo;

// 自定义容器类中的数据类型
@property (nonatomic, strong) NSArray <StudentModel *>* students;

@end

NS_ASSUME_NONNULL_END
