//
//  QYCLoginVC.m
//  代码规范
//
//  Created by 启业云 on 2019/8/5.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "QYCLoginVC.h"
// Controller
#import "ViewController.h"
// View
// Model

/** 声明一个静态的全局只读常量 */
static const NSTimeInterval QYCLoginViewControllerNavigationFadeAnimationDuration = 0.3;
/** 声明一个静态的全局只读常量 */
static NSString * const NYTAboutViewControllerCompanyName = @"The New York Times Company";
/** 声明一个静态的全局只读常量 */
static const CGFloat NYTImageThumbnailHeight = 50.0;

@interface QYCLoginVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy, readwrite) NSString *name;   ///< 姓名
@property (nonatomic, strong) NSString *sex;   ///< 性别

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QYCLoginVC

@synthesize sex = _newsex;

#pragma mark - ================ LifeCycle =================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 点语法 添加背景颜色
    self.view.backgroundColor = UIColor.orangeColor;
    
    NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
    NSDictionary *productManagers = @{@"iPhone": @"Kate",
                                      @"iPad": @"Kamal",
                                      @"Mobile Web": @"Bill",
                                      @"Mobile Web": @"Bill",
                                      @"Mobile Web": @"Bill"};
    NSNumber *shouldUseLiterals = @YES;
    NSNumber *buildingZIPCode = @10018;
    
    if ([shouldUseLiterals boolValue]) {
        NSLog(@"哈哈");
    }
    else {
        NSLog(@"六六六");
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

-(void)dealloc {
    
}

#pragma mark - ================ Public Methods =================

- (void)setExampleText:(NSString *)text image:(UIImage *)image {
    if (!text) {
        return;
    }
    
    QYCAdRequestState state = QYCAdRequestStateLoading;
    switch (state) {
        case QYCAdRequestStateInactive:
            // inactive
            NSLog(@"show inactive");
            break;
        case QYCAdRequestStateLoading: {
            // loading
            NSLog(@"show loading 1");
            NSLog(@"show loading 2");
        }
            break;
    }
}

- (void)setExampleText:(NSString *)text
                 image:(UIImage *)image
                 color:(UIColor *)color
       alternativeText:(NSString *)altText {
    
}


#pragma mark - ================ Private Methods =================

/**
 block
 */
- (void)p_showBlock {
    __weak __typeof(self) weakSelf = self;
    [self p_runMethod:^(NSString *str) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf p_privateMethod_1];
            NSLog(@"%@", str);
        }
    }];
}
/**
 block 作为方法参数

 @param parameterBlock block参数
 */
- (void)p_runMethod:(void (^)(NSString *))parameterBlock {
    parameterBlock(@"p_runMethod传递过来的参数");
}

/**
 私有方法二
 */
- (void)p_privateMethod_1 {
    
}

/**
 私有方法三
 */
- (void)p_privateMethod_2 {
    
}

#pragma mark - ================ Delegate =================

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - ================ Actions =================

/**
 登录按钮点击事件
 
 @param sender 点击
 */
- (void)loginBtn:(id)sender {
    
}

#pragma mark - ================ Getter and Setter =================

- (void)setSex:(NSString *)sex {
    _newsex = [sex copy];
}

- (NSString *)sex {
    return _newsex;
}

@end
