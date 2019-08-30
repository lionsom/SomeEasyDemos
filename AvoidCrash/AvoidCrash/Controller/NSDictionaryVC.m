//
//  NSDictionaryVC.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/29.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSDictionaryVC.h"

@interface NSDictionaryVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NSDictionaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"NSDictionary";
    
//    [self dictionary_Method_Crash];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - TableView DataSource
// Section Number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Rows Number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 11;
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
        cell.textLabel.text = @"NSDictionary 类簇";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"+ dictionaryWithObjects:nil forKeys: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"+ dictionaryWithObjects: forKeys: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.textLabel.text = @"- initWithObjects: forKeys: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.textLabel.text = @"- initWithObjects: forKeys: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.textLabel.text = @"+ dictionaryWithObjectsAndKeys: 崩溃 (未拦截，慎用此方法)";
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        cell.textLabel.text = @"- initWithObjectsAndKeys: 崩溃 (未拦截，慎用此方法)";
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        cell.textLabel.text = @"+ dictionaryWithObject: forKey:: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        cell.textLabel.text = @"@{} 创建Dictionary 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 9) {
        cell.textLabel.text = @"- setValue: forKey: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 10) {
        cell.textLabel.text = @"正常-valueForKey:与-objectForKey:";
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
        titleLabel.text = @"  NSDictionary 方法";
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
        
        // NSArray 类簇
        NSDictionary *dict = [NSDictionary alloc];                                     // __NSPlaceholderDictionary
        NSDictionary *dict1 = [dict init];                                             // __NSDictionary0
        NSDictionary *dict2 = [dict initWithObjectsAndKeys:@"a",@"1", nil];            // __NSSingleEnterDictionaryArrayI
        NSDictionary *dict3 = [dict initWithObjectsAndKeys:@"a",@"1", @"b",@"1", nil]; // __NSDictionaryI
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (2)
        NSDictionary *dict3 = [NSDictionary dictionaryWithObjects:nil forKeys:@[@"1",@"2"]];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
        NSDictionary *dict31 = [NSDictionary dictionaryWithObjects:@[@"1"] forKeys:nil];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
        NSDictionary *dict32 = [NSDictionary dictionaryWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[2]
        NSDictionary *dict4 = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray count:3];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (1)
        NSDictionary *dict5 = [[NSDictionary alloc] initWithObjects:nil forKeys:@[@"1"]];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
        NSDictionary *dict51 = [[NSDictionary alloc] initWithObjects:@[@"1"] forKeys:nil];
        // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
        NSDictionary *dict52 = [[NSDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[3]
        NSDictionary *dict6 = [[NSDictionary alloc] initWithObjects:valueArray forKeys:keyArray count:3];
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
        // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSDictionary *dict71 = [NSDictionary dictionaryWithObjectsAndKeys:@1,nil, @2,@"b", nil];
        // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSDictionary *dict72 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"a", @2, nil];
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        NSDictionary *dict8 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
        // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSDictionary *dict81 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,nil,@2,@"3", nil];
        // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
        NSDictionary *dict82 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2, nil];
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]
        NSDictionary *dict9 = [NSDictionary dictionaryWithObject:nil forKey:@"1"];
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]'
        NSDictionary *dict91 = [NSDictionary dictionaryWithObject:@"1" forKey:nil];
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        NSString *str = nil;
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[2]
        NSDictionary *defaultDict = @{@"1":@"a",
                                      @"2":@"b",
                                      @"3":str
                                      };
        // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[1]
        NSDictionary *defaultDict1 = @{@"1":@"a",
                                       str:@"b",
                                       @"3":@"c"
                                       };
        
    } else if (indexPath.section == 0 && indexPath.row == 9) {
        // 字典不可变，
        NSDictionary *defaultDict = @{@"1":@"a",
                                      @"2":@"b",
                                      @"3":@"c"
                                      };
        // 崩溃 [<__NSDictionaryI 0x600000207380> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key 2.
        // 需要将其变为可变字典
        [defaultDict setValue:@"a" forKey:@"b"];
    } else if (indexPath.section == 0 && indexPath.row == 10) {
        // 字典不可变，
        NSDictionary *defaultDict = @{@"1":@"a",
                                      @"2":@"b",
                                      @"3":@"c"
                                      };
        id obj4 = [defaultDict valueForKey:@"2"];
        id obj5 = [defaultDict valueForKeyPath:@"2"];
        
        id obj = [defaultDict objectForKey:@"111"];
        id obj1 = [defaultDict objectForKey:nil];
        
        id obj2 = [defaultDict objectForKeyedSubscript:@"111"];
        id obj3 = [defaultDict objectForKeyedSubscript:nil];
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

#pragma mark - Private

-(void)dictionary_Method_Crash {
   
    //===========
    // 1.Creating an Empty Dictionary
    //===========
    NSDictionary *dict1 = [NSDictionary dictionary];
    
    NSDictionary *dict2 = [[NSDictionary alloc] init];
    
    //===========
    // 2.Creating a Dictionary from Objects and Keys
    //===========
    
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (2)
    NSDictionary *dict3 = [NSDictionary dictionaryWithObjects:nil forKeys:@[@"1",@"2"]];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
    NSDictionary *dict31 = [NSDictionary dictionaryWithObjects:@[@"1"] forKeys:nil];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
    NSDictionary *dict32 = [NSDictionary dictionaryWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];
    
    NSString *keyArray[2];
    NSString *valueArray[3];
    keyArray[0] = @"1";
    keyArray[1] = @"2";
    valueArray[0] = @"a";
    valueArray[1] = @"b";
    valueArray[2] = @"c";
    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[2]
    NSDictionary *dict4 = [NSDictionary dictionaryWithObjects:valueArray forKeys:keyArray count:3];
    
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (0) differs from count of keys (1)
    NSDictionary *dict5 = [[NSDictionary alloc] initWithObjects:nil forKeys:@[@"1"]];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)
    NSDictionary *dict51 = [[NSDictionary alloc] initWithObjects:@[@"1"] forKeys:nil];
    // 崩溃 -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (3)
    NSDictionary *dict52 = [[NSDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@"1",@"2",@"3"]];

    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[3]
    NSDictionary *dict6 = [[NSDictionary alloc] initWithObjects:valueArray forKeys:keyArray count:3];
    
    NSDictionary *dict7 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
//    // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict71 = [NSDictionary dictionaryWithObjectsAndKeys:@1,nil, @2,@"b", nil];
//    // 崩溃 +[NSDictionary dictionaryWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict72 = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"a", @2, nil];
    
    NSDictionary *dict8 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2,@"3", nil];
    // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict81 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,nil,@2,@"3", nil];
    // 崩溃 -[__NSPlaceholderDictionary initWithObjectsAndKeys:]: second object of each pair must be non-nil.  Or, did you forget to nil-terminate your parameter list?
    NSDictionary *dict82 = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"a",@2, nil];
    
    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]
    NSDictionary *dict9 = [NSDictionary dictionaryWithObject:nil forKey:@"1"];
    // 崩溃 -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]'
    NSDictionary *dict91 = [NSDictionary dictionaryWithObject:@"1" forKey:nil];
    
    //===========
    // 3.Creating a Dictionary from Another Dictionary
    //===========
    NSDictionary *defaultDict = @{@"1":@"a",
                                  @"2":@"b",
                                  @"3":@"c"
                                  };
    NSDictionary *defaultDict1 = nil;
    
    NSDictionary *dict10 = [NSDictionary dictionaryWithDictionary:defaultDict];
    NSDictionary *dict10_1 = [NSDictionary dictionaryWithDictionary:defaultDict1];

    NSDictionary *dict11 = [[NSDictionary alloc] initWithDictionary:defaultDict];
    NSDictionary *dict11_1 = [[NSDictionary alloc] initWithDictionary:defaultDict1];

    NSDictionary *dict12 = [[NSDictionary alloc] initWithDictionary:defaultDict copyItems:YES];
    NSDictionary *dict12_1 = [[NSDictionary alloc] initWithDictionary:defaultDict1 copyItems:YES];
    
    //===========
    // 4.Accessing Keys and Values
    //===========
    id value = defaultDict[@"5"];
    id value1 = defaultDict[nil];

    id value2 = defaultDict1[@"5"];
    id value3 = defaultDict1[nil];
    
    NSArray *allkeysArr = [defaultDict allKeys];
    NSArray *allkeysArr1 = [defaultDict1 allKeys];

    NSArray *allvaluesArr = [defaultDict allValues];
    NSArray *allvaluesArr1 = [defaultDict1 allValues];
    
    NSArray *keysArr = [defaultDict allKeysForObject:@"a"];
    NSArray *keysArr1 = [defaultDict allKeysForObject:nil];

    NSArray *valuesArr = [defaultDict valueForKey:@"1"];
    NSArray *valuesArr1 = [defaultDict valueForKey:nil];

    NSInteger count = [defaultDict count];
    id __unsafe_unretained objects[10];
    id __unsafe_unretained keys[1];
    [defaultDict getObjects:objects andKeys:keys count:5];
    
    id obj = [defaultDict objectForKey:@"111"];
    id obj1 = [defaultDict objectForKey:nil];

    id obj2 = [defaultDict objectForKeyedSubscript:@"111"];
    id obj3 = [defaultDict objectForKeyedSubscript:nil];
}

@end
