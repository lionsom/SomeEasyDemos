//
//  NSMutableDictionaryVC.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/9/2.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSMutableDictionaryVC.h"

@interface NSMutableDictionaryVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NSMutableDictionaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"NSMutableDictionaryVC";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - TableView DataSource
// Section Number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Rows Number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 9;
    } else if (section == 1) {
        return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    // 根据标识去缓存池找cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 不写这句直接崩掉，找不到循环引用的cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //（这种是没有点击后的阴影效果)
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 右侧小图标 - 箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"NSMutableDictionary 类簇";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"+ dictionaryWithObjects: forKeys: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"+ dictionaryWithObjects: forKeys: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.textLabel.text = @"- initWithObjects: forKeys: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.textLabel.text = @"- initWithObjects: forKeys: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.textLabel.text = @"未拦截 + dictionaryWithObjectsAndKeys: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        cell.textLabel.text = @"未拦截 - initWithObjectsAndKeys: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        cell.textLabel.text = @"+ dictionaryWithObject: forKey:: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        cell.textLabel.text = @"@{} 创建NSMutableDictionary 崩溃";
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"- setObject: forKey: 崩溃";
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        cell.textLabel.text = @"- setObject: forKeyedSubscript: 崩溃";
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        cell.textLabel.text = @"- setValue: forKey: 崩溃";
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        cell.textLabel.text = @"- removeObjectForKey: 崩溃";
    }
    return cell;
}


#pragma mark - TableView Delegate

// cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

// Section顶部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

// Section底部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 500, 30)];
    headView.backgroundColor = [UIColor greenColor];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 500, 30)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor orangeColor];
    [headView addSubview:titleLabel];
    
    if (section == 0) {
        titleLabel.text = @"  NSMutableDictionary继承NSDictionary的方法";
    }
    else if (section == 1) {
        titleLabel.text = @"  NSMutableDictionary扩展的方法";
    }
    return headView;
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *keyArray[2];
    NSString *valueArray[3];
    keyArray[0] = @"1";
    keyArray[1] = @"2";
    valueArray[0] = @"a";
    valueArray[1] = @"b";
    valueArray[2] = @"c";
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 类继承关系
        // __NSPlaceholderDictionary    占位字典
        // __NSDictionaryI              继承于 NSDictionary
        // __NSSingleEntryDictionaryI   继承于 NSDictionary
        // __NSDictionary0              继承于 NSDictionary
        // __NSFrozenDictionaryM        继承于 NSDictionary
        // __NSDictionaryM              继承于 NSMutableDictionary
        // __NSCFDictionary             继承于 NSMutableDictionary
        // NSMutableDictionary          继承于 NSDictionary
        // NSDictionary                 继承于 NSObject
        
        NSClassFromString(@"__NSPlaceholderDictionary");       // [NSDictionary alloc]; alloc后所得到的类
        NSClassFromString(@"__NSDictionary0");                 // 当init为一个空数组后，变成了__NSDictionary0
        NSClassFromString(@"__NSSingleEnterDictionaryArrayI"); // 如果有且仅有一个元素，那么为__NSSingleEnterDictionaryArrayI
        NSClassFromString(@"__NSDictionaryI");                 // 如果数组大于一个元素，那么为__NSDictionaryI
        
        // NSDictionary 类簇
        NSMutableDictionary *mdict1 = [NSMutableDictionary dictionaryWithCapacity:0];     // __NSDictionaryM
        NSMutableDictionary *mdict2 = [[NSMutableDictionary alloc] init];                 // __NSDictionaryM
        NSMutableDictionary *mdict3 = [[NSMutableDictionary alloc] initWithCapacity:0];   // __NSDictionaryM
        NSMutableDictionary *mdict4 = [NSMutableDictionary dictionaryWithDictionary:nil]; // __NSDictionaryM
        
        NSMutableDictionary *dict = [NSMutableDictionary alloc];      // __NSPlaceholderDictionary
        id dict1 = [dict init];                                             // __NSDictionaryM
        id dict2 = [dict initWithObjectsAndKeys:@"a",@"1", nil];            // __NSDictionaryM
        id dict3 = [dict initWithObjectsAndKeys:@"a",@"1", @"b",@"1", nil]; // __NSDictionaryM
        NSLog(@"11");
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (2)
        NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithObjects:nil forKeys:@[@"1",@"2"]];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
        NSMutableDictionary *dict31 = [NSMutableDictionary dictionaryWithObjects:@[@"1"] forKeys:nil];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
        NSMutableDictionary *dict32 = [NSMutableDictionary dictionaryWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[2]
        NSMutableDictionary *dict4 = [NSMutableDictionary dictionaryWithObjects:valueArray forKeys:keyArray count:3];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (1)
        NSMutableDictionary *dict5 = [[NSMutableDictionary alloc] initWithObjects:nil forKeys:@[@"1"]];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
        NSMutableDictionary *dict51 = [[NSMutableDictionary alloc] initWithObjects:@[@"1"] forKeys:nil];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
        NSMutableDictionary *dict52 = [[NSMutableDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[3]
        NSMutableDictionary *dict6 = [[NSMutableDictionary alloc] initWithObjects:valueArray forKeys:keyArray count:3];
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        NSMutableDictionary *dict7 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
        // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSMutableDictionary *dict71 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1,nil, @2,@"b", nil];
        // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSMutableDictionary *dict72 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@1,@"a", @2, nil];
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        NSMutableDictionary *dict8 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
        // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSMutableDictionary *dict81 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@1,nil,@2,@"3", nil];
        // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSMutableDictionary *dict82 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2, nil];
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]
        NSMutableDictionary *dict9 = [NSMutableDictionary dictionaryWithObject:nil forKey:@"1"];
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]'
        NSMutableDictionary *dict91 = [NSMutableDictionary dictionaryWithObject:@"1" forKey:nil];
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        NSString *str = nil;
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[2]
        NSMutableDictionary *defaultDict = @{@"1":@"a",
                                             @"2":@"b",
                                             @"3":str
                                             };
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1]
        NSMutableDictionary *defaultDict1 = @{@"1":@"a",
                                              str:@"b",
                                              @"3":@"c"
                                              };
    }
    
    
    else if (indexPath.section == 1 && indexPath.row == 0) {
        NSMutableDictionary *mdict5 = [[NSMutableDictionary alloc] init];
        // 崩溃 -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: 1)
        [mdict5 setObject:nil forKey:@"1"];
        // 崩溃 -[__NSDictionaryM setObject:forKey:]: key cannot be nil
        [mdict5 setObject:@"1" forKey:nil];
    } else if (indexPath.section == 1 && indexPath.row == 1) {
        NSMutableDictionary *mdict5 = [[NSMutableDictionary alloc] init];
        
        [mdict5 setObject:nil forKeyedSubscript:@"1"];
        // 崩溃  -[__NSDictionaryM setObject:forKeyedSubscript:]: key cannot be nil
        [mdict5 setObject:@"1" forKeyedSubscript:nil];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        NSMutableDictionary *mdict5 = [[NSMutableDictionary alloc] init];
        
        [mdict5 setValue:nil forKey:@"1"];
        // 崩溃 -[__NSDictionaryM setObject:forKey:]: key cannot be nil
        [mdict5 setValue:@"1" forKey:nil];
    } else if (indexPath.section == 1 && indexPath.row == 3) {
        NSMutableDictionary *mdict6 = [[NSMutableDictionary alloc] init];
        
        // 崩溃 -[__NSDictionaryM removeObjectForKey:]: key cannot be nil
        [mdict6 removeObjectForKey:nil];
        
    }
}


#pragma mark - Lazy init
-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 150) style:UITableViewStylePlain];
        
        //设置代理
        _tableView.delegate = self;
        _tableView.dataSource =self;
        //设置不显示分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // heightForHeader 和 heightForFooter 两个delegate不执行
        _tableView.estimatedRowHeight = 0;
        if (@available(iOS 11.0, *)) {
            //当有heightForHeader delegate时设置
            _tableView.estimatedSectionHeaderHeight = 0;
            //当有heightForFooter delegate时设置
            _tableView.estimatedSectionFooterHeight = 0;
        }
        
        //其实不用判断两层，@available(iOS 11.0)会有一个else的
        if(@available(iOS 11.0, *)){
            if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        // 解决tableview上按钮点击效果的延迟现象
        _tableView.delaysContentTouches = NO;
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


#pragma mark - Private 忽略

-(void)mutabledictionary_Method_Crash {
    //===========
    // 0. NSMutableDictionary 继承 NSDictionary 方法
    //===========
    
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (2)
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithObjects:nil forKeys:@[@"1",@"2"]];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
    NSMutableDictionary *dict31 = [NSMutableDictionary dictionaryWithObjects:@[@"1"] forKeys:nil];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
    NSMutableDictionary *dict32 = [NSMutableDictionary dictionaryWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];

    NSString *keyArray[2];
    NSString *valueArray[3];
    keyArray[0] = @"1";
    keyArray[1] = @"2";
    valueArray[0] = @"a";
    valueArray[1] = @"b";
    valueArray[2] = @"c";
    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[2]
    NSMutableDictionary *dict4 = [NSMutableDictionary dictionaryWithObjects:valueArray forKeys:keyArray count:3];

    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (1)
    NSMutableDictionary *dict5 = [[NSMutableDictionary alloc] initWithObjects:nil forKeys:@[@"1"]];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
    NSMutableDictionary *dict51 = [[NSMutableDictionary alloc] initWithObjects:@[@"1"] forKeys:nil];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
    NSMutableDictionary *dict52 = [[NSMutableDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];

    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[3]
    NSMutableDictionary *dict6 = [[NSMutableDictionary alloc] initWithObjects:valueArray forKeys:keyArray count:3];

/*  + dictionaryWithObjectsAndKeys:   -initWithObjectsAndKeys:  NSDictionary未处理
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
    // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict71 = [NSDictionary dictionaryWithObjectsAndKeys:@1,nil, @2,@"b", nil];
    // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict72 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"a", @2, nil];

    NSDictionary *dict8 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
    // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict81 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,nil,@2,@"3", nil];
    // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict82 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2, nil];
 */
    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]
    NSMutableDictionary *dict9 = [NSMutableDictionary dictionaryWithObject:nil forKey:@"1"];
    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]'
    NSMutableDictionary *dict91 = [NSMutableDictionary dictionaryWithObject:@"1" forKey:nil];
    
    
    //===========
    // 1. Creating and Initializing a Mutable Dictionary
    //===========
    NSMutableDictionary *mdict1 = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSMutableDictionary *mdict2 = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *mdict3 = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSMutableDictionary *mdict4 = [NSMutableDictionary dictionaryWithDictionary:nil];
    
    //===========
    // 2. Adding Entries to a Mutable Dictionary
    //===========
    
    NSMutableDictionary *mdict5 = [[NSMutableDictionary alloc] init];

    // 崩溃 -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: 1)
//    [mdict5 setObject:nil forKey:@"1"];
    // 崩溃 -[__NSDictionaryM setObject:forKey:]: key cannot be nil
//    [mdict5 setObject:@"1" forKey:nil];

    [mdict5 setObject:nil forKeyedSubscript:@"1"];
    // 崩溃  -[__NSDictionaryM setObject:forKeyedSubscript:]: key cannot be nil
//    [mdict5 setObject:@"1" forKeyedSubscript:nil];
    
    [mdict5 setValue:nil forKey:@"1"];
    // 崩溃 -[__NSDictionaryM setObject:forKey:]: key cannot be nil
//    [mdict5 setValue:@"1" forKey:nil];
    
    [mdict5 addEntriesFromDictionary:nil];
    
    [mdict5 setDictionary:nil];
    
    //===========
    // 3. Removing Entries From a Mutable Dictionary
    //===========

    NSMutableDictionary *mdict6 = [[NSMutableDictionary alloc] init];

    // 崩溃 -[__NSDictionaryM removeObjectForKey:]: key cannot be nil
//    [mdict6 removeObjectForKey:nil];
    
    [mdict6 removeObjectsForKeys:nil];
}

@end
