//
//  QYCAvoidCrash_ContainerTest_VC.m
//  Qiyeyun
//
//  Created by 启业云 on 2019/9/4.
//  Copyright © 2019 安元. All rights reserved.
//

#import "QYCAvoidCrash_ContainerTest_VC.h"

@interface QYCAvoidCrash_ContainerTest_VC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QYCAvoidCrash_ContainerTest_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"容器类测试";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - TableView DataSource
// Section Number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

// Rows Number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 12;
    } else if (section == 0) {
        return 12;
    } else if (section == 0) {
        return 12;
    } else if (section == 0) {
        return 12;
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
        cell.textLabel.text = @"@[]; 创建数组崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"+ arrayWithObject: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"+ arrayWithObjects: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.textLabel.text = @"- initWithObjects: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.textLabel.text = @"array[5] 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.textLabel.text = @"- objectAtIndex: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        cell.textLabel.text = @"- objectAtIndexedSubscript: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        cell.textLabel.text = @"- objectsAtIndexes: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        cell.textLabel.text = @"- getObjects: range: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 9) {
        cell.textLabel.text = @" NSArray 类簇一览 (看代码)";
    }
    
    
    
    
    
    
    else {
        cell.textLabel.text = @"空";
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
        titleLabel.text = @"  NSArray崩溃的方法有哪些";
    } else if (section == 0) {
        titleLabel.text = @"  NSMutableArray崩溃的方法有哪些";
    } else if (section == 0) {
        titleLabel.text = @"  NSDictionary崩溃的方法有哪些";
    } else if (section == 0) {
        titleLabel.text = @"  NSMutableDictionary崩溃的方法有哪些";
    }
    return headView;
}


// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]
        NSString *string = nil;
        NSArray *arr1 = @[@"1",@"2",string];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        NSArray *arr3 = [NSArray arrayWithObject:nil];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        NSString *strings[3];
        strings[0] = @"First";
        strings[1] = nil;
        strings[2] = @"Third";
        NSArray *arr5 = [NSArray arrayWithObjects:strings count:3];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        NSString *strings1[3];
        strings1[0] = @"First";
        strings1[1] = nil;
        strings1[2] = @"Third";
        NSArray *arr10 = [[NSArray alloc] initWithObjects:strings1 count:3];
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        NSArray *arr11 = @[@"1", @"2"];
        id a = arr11[5];
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NSArray objectAtIndex:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"__NSPlaceholderArray(未容错)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 崩溃 -[NSArray objectAtIndex:]: method sent to an uninitialized immutable array object
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            [array objectAtIndex:2];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"__NSArray0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr1 = [array init];                        // __NSArray0
            [arr1 objectAtIndex:2];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"__NSSingleObjectArrayI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr2 = [array initWithObjects:@0, nil];     // __NSSingleObjectArrayI
            [arr2 objectAtIndex:2];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"__NSArrayI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr3 = [array initWithObjects:@0, @1, nil]; // __NSArrayI
            [arr3 objectAtIndex:5];
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        [alert addAction:action4];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NSArray objectAtIndexedSubscript:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"__NSPlaceholderArray(未容错)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 崩溃 -[NSArray objectAtIndex:]: method sent to an uninitialized immutable array object
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            [array objectAtIndexedSubscript:2];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"__NSArray0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr1 = [array init];                        // __NSArray0
            [arr1 objectAtIndexedSubscript:2];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"__NSSingleObjectArrayI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr2 = [array initWithObjects:@0, nil];     // __NSSingleObjectArrayI
            [arr2 objectAtIndexedSubscript:2];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"__NSArrayI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr3 = [array initWithObjects:@0, @1, nil]; // __NSArrayI
            [arr3 objectAtIndexedSubscript:5];
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        [alert addAction:action4];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        // clang -rewrite-objc main.m   objc_getClass("NSArray")  sel_registerName("objectsAtIndexes:")
        // 崩溃 -[NSArray objectsAtIndexes:]: index 9 in index set beyond bounds [0 .. 1]
        NSArray *arr11 = @[@"1", @"2"];
        NSIndexSet *se = [NSIndexSet indexSetWithIndex:9];
        //或   NSIndexSet *se = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 9)];
        NSArray *test = [arr11 objectsAtIndexes:se];
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NSArray getObjects:range:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"NSArray" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 崩溃 -[NSArray objectAtIndex:]: method sent to an uninitialized immutable array object
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSRange range = NSMakeRange(0, 11);
            __unsafe_unretained id cArray[range.length];
            [array getObjects:cArray range:range];
        }];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"__NSArray0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr1 = [array init];                        // __NSArray0
            NSRange range = NSMakeRange(0, 11);
            __unsafe_unretained id cArray[range.length];
            [arr1 getObjects:cArray range:range];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"__NSSingleObjectArrayI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr2 = [array initWithObjects:@0, nil];     // __NSSingleObjectArrayI
            NSRange range = NSMakeRange(0, 11);
            __unsafe_unretained id cArray[range.length];
            [arr2 getObjects:cArray range:range];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"__NSArrayI" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
            NSArray *arr3 = [array initWithObjects:@0, @1, nil]; // __NSArrayI
            NSRange range = NSMakeRange(0, 11);
            __unsafe_unretained id cArray[range.length];
            [arr3 getObjects:cArray range:range];
        }];
        UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action0];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        [alert addAction:action4];
        [self presentViewController:alert animated:YES completion:nil];
    } else if (indexPath.section == 0 && indexPath.row == 9) {
        // 类继承关系
        // __NSPlaceholderArray       占位数组
        // __NSArrayI                 继承于 NSArray
        // __NSSingleObjectArrayI     继承于 NSArray
        // __NSArray0                 继承于 NSArray
        // __NSFrozenArrayM           继承于 NSArray
        // __NSArrayM                 继承于 NSMutableArray
        // __NSCFArray                继承于 NSMutableArray
        // NSMutableArray             继承于 NSArray
        // NSArray                    继承于 NSObject
        NSClassFromString(@"__NSPlaceholderArray");   // [NSArray alloc]; alloc后所得到的类
        NSClassFromString(@"__NSArray0");             // 当init为一个空数组后，变成了__NSArray0
        NSClassFromString(@"__NSSingleObjectArrayI"); // 如果有且仅有一个元素，那么为__NSSingleObjectArrayI
        NSClassFromString(@"__NSArrayI");             // 如果数组大于一个元素，那么为__NSArrayI
        
        // NSArray 类簇
        NSArray *array = [NSArray alloc];                    // __NSPlaceholderArray
        NSArray *arr1 = [array init];                        // __NSArray0
        NSArray *arr2 = [array initWithObjects:@0, nil];     // __NSSingleObjectArrayI
        NSArray *arr3 = [array initWithObjects:@0, @1, nil]; // __NSArrayI
    } else {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
