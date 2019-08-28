//
//  NSArrayVC.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/28.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSArrayVC.h"

@interface NSArrayVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NSArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"NSArray";

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
        return 10;
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
    } else {
        cell.textLabel.text = @"AA";
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
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"NSArray" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"NSArray" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"__NSArray0 (同NSArray)" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");  // [NSArray alloc]; alloc后所得到的类
        Class __NSArray0 = NSClassFromString(@"__NSArray0");     // 当init为一个空数组后，变成了__NSArray0
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");  // 如果有且仅有一个元素，那么为__NSSingleObjectArrayI
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");       // 如果数组大于一个元素，那么为__NSArrayI
        // __NSFrozenArrayM            NSMutableArray用copy修饰之后，在使用addObjectsFromArray方法时崩溃
        
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



#pragma mark - Private

-(void)array_Method_Crash {
     //===========
     // Creating an Array
     //===========
     // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]
     NSString *string = nil;
     NSArray *arr1 = @[@"1",@"2",string];
     
     NSArray *temp = nil;
     NSArray *arr2 = [NSArray arrayWithArray:temp];
     
     // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]
     NSArray *arr3 = [NSArray arrayWithObject:nil];
     
     NSArray *arr4 = [NSArray arrayWithObjects:nil];
     
     // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[1]
     NSString *strings[3];
     strings[0] = @"First";
     strings[1] = nil; // @"Second";
     strings[2] = @"Third";
     NSArray *arr5 = [NSArray arrayWithObjects:strings count:3];
     
     //===========
     // Initializing an Array
     //===========
     NSArray *arr6 = [[NSArray alloc] init];
     
     NSArray *arr7 = [[NSArray alloc] initWithArray:nil];
     
     NSArray *arr8 = [[NSArray alloc] initWithArray:nil copyItems:YES];
     
     NSArray *arr9 = [[NSArray alloc] initWithObjects:nil];
     
     // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[1]
     NSString *strings1[3];
     strings1[0] = @"First";
     strings1[1] = nil; // @"Second";
     strings1[2] = @"Third";
     NSArray *arr10 = [[NSArray alloc] initWithObjects:strings1 count:3];
     
     //===========
     // Querying an Array
     //===========
     NSArray *arr11 = @[@"1", @"2"];
     
     [arr11 containsObject:nil];
     
     arr11.count;
     
     // - getObjects: range:   不常用
     NSArray *mArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
     NSRange range = NSMakeRange(0, 11);
     __unsafe_unretained id cArray[range.length];
     [mArray getObjects:cArray range:range];
     for (int i = 0; i < range.length; i++) {
         NSLog(@"objects: %@", cArray[i]);
     }
    
     NSArray *arr12 = nil;
     id a = arr12.firstObject;
     id b = arr12.lastObject;
     
     // 崩溃 -[__NSArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 1]
     [arr11 objectAtIndex:3];
     
     // 崩溃 -[__NSArrayI objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 1]
     [arr11 objectAtIndexedSubscript:3];
     
     // 崩溃 -[NSArray objectsAtIndexes:]: index 9 in index set beyond bounds [0 .. 3]
     NSIndexSet *se = [NSIndexSet indexSetWithIndex:9];
     //或   NSIndexSet *se = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 9)];
     NSArray *test = [arr11 objectsAtIndexes:se];
     
     // - objectEnumerator
     // - reverseObjectEnumerator
     // 返回一个枚举器对象，该对象允许您以 正序/逆序 访问数组中的每个对象。
     NSEnumerator *enumerator = [arr11 objectEnumerator];
     id anObject;
     while (anObject = [enumerator nextObject]) {
     // code to act on each element as it is returned
     NSLog(@"%@", anObject);
     }
     
     NSEnumerator *reverseEnumerator = [arr11 reverseObjectEnumerator];
     id anreverseObject;
     while (anreverseObject = [reverseEnumerator nextObject]) {
     // code to act on each element as it is returned
     NSLog(@"%@", anreverseObject);
     }
     
     //===========
     // Finding Objects in an Array
     //===========
     NSArray *arr13 = @[@"1",@"2"];
     NSArray *arr14 = nil;
     
     [arr13 indexOfObject:nil];
     
     [arr13 indexOfObject:nil inRange:NSMakeRange(1, 1)];
}


@end
