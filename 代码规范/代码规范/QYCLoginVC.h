//
//  QYCLoginVC.h
//  代码规范
//
//  Created by 启业云 on 2019/8/5.
//  Copyright © 2019 启业云. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, QYCAdRequestState) {
    QYCAdRequestStateInactive,  ///< 枚举一
    QYCAdRequestStateLoading    ///< 枚举二
};

typedef NS_OPTIONS(NSUInteger, QYCAdCategory) {
    QYCAdCategoryAutos      = 1 << 0,  ///< 枚举一
    QYCAdCategoryJobs       = 1 << 1,  ///< 枚举二
    QYCAdCategoryRealState  = 1 << 2,  ///< 枚举三
    QYCAdCategoryTechnology = 1 << 3   ///< 枚举四
};

/**
 该VC为登录ViewController
 
 @discussion 我是这个多少啦垃圾筐拉菲金坷垃金坷垃发声亮剑
 */
@interface QYCLoginVC : UIViewController

@property (nonatomic, copy, readonly) NSString *name;   ///< 姓名
@property (nonatomic, assign) NSInteger age;  ///< 年纪
@property (nonatomic, strong) UIButton *setBtn; ///< 设置按钮
@property (nonatomic, strong) UITextField *nameTextField;   ///< 姓名输入框
/** nickName */
@property (nonatomic, copy, readonly) NSString *nickName;
/** height */
@property (nonatomic, assign) NSInteger height;
/** passswordTextField */
@property (nonatomic, strong) UITextField *passswordTextField;

/**
 方法一

 @param text 文本
 @param image 图片
 */
- (void)setExampleText:(NSString *)text image:(UIImage *)image;

/**
 方法二：超过80个字符的方法应该表示为每个参数新建行

 @param text 文本
 @param image 图片
 @param color 颜色
 @param altText alt文本
 */
- (void)setExampleText:(NSString *)text
                 image:(UIImage *)image
                 color:(UIColor *)color
       alternativeText:(NSString *)altText;

@end

NS_ASSUME_NONNULL_END
