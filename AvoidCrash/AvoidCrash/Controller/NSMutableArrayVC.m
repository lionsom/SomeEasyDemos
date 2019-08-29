//
//  NSMutableArrayVC.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/28.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "NSMutableArrayVC.h"

@interface NSMutableArrayVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NSMutableArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"NSMutableArray";
    
//    [self mutableArray_Method_Crash];
    
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
    }
    else if (section == 1) {
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
        cell.textLabel.text = @"@[]; 创建MutableArray崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.textLabel.text = @"+ arrayWithObject: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"+ arrayWithObjects: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.textLabel.text = @"- initWithObjects: count: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.textLabel.text = @"mutableArray[5] 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.textLabel.text = @"- objectAtIndex: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 6) {
        cell.textLabel.text = @"- objectAtIndexedSubscript: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 7) {
        cell.textLabel.text = @"- objectsAtIndexes: 崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        cell.textLabel.text = @"- getObjects: range: 崩溃";
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"  类簇一览 (看代码)";
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
        titleLabel.text = @"  NSMutableArray继承NSArray的方法";
    }
    else if (section == 1) {
        titleLabel.text = @"  NSMutableArray扩展的方法";
    }
    return headView;
}

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *mArr0 = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSString *string29 = nil;
        NSMutableArray *arr29 = @[@"1",@"2",string29];
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        NSMutableArray *mArr30 = [NSMutableArray arrayWithObject:nil];
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        NSString *strings[3];
        strings[0] = @"First";
        strings[1] = nil;
        strings[2] = @"Third";
        NSMutableArray *mArr31 = [NSMutableArray arrayWithObjects:strings count:3];
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        NSString *strings1[3];
        strings1[0] = @"First";
        strings1[1] = nil;
        strings1[2] = @"Third";
        NSMutableArray *mArr32 = [[NSMutableArray alloc] initWithObjects:strings1 count:3];
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        mArr0[3];
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        [mArr0 objectAtIndex:3];

    } else if (indexPath.section == 0 && indexPath.row == 6) {
        [mArr0 objectAtIndexedSubscript:3];

    } else if (indexPath.section == 0 && indexPath.row == 7) {
        NSIndexSet *se = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 9)];
        NSArray *test = [mArr0 objectsAtIndexes:se];
    } else if (indexPath.section == 0 && indexPath.row == 8) {
        NSRange range0 = NSMakeRange(0, 11);
        __unsafe_unretained id cArray[range0.length];
        [mArr0 getObjects:cArray range:range0];
    }
    
    else if (indexPath.section == 1 && indexPath.row == 0) {
        
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

-(void)mutableArray_Method_Crash {
    //===========
    // 0.NSMutableArray 继承 NSArray 方法
    //===========
    
    // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[2]
    NSString *string29 = nil;
    NSMutableArray *arr29 = @[@"1",@"2",string29];
    
    // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]
    NSMutableArray *mArr30 = [NSMutableArray arrayWithObject:nil];
    
    // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[1]
    NSString *strings[3];
    strings[0] = @"First";
    strings[1] = nil;
    strings[2] = @"Third";
    NSMutableArray *mArr31 = [NSMutableArray arrayWithObjects:strings count:3];
    
    // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[1]
    NSString *strings1[3];
    strings1[0] = @"First";
    strings1[1] = nil;
    strings1[2] = @"Third";
    NSMutableArray *mArr32 = [[NSMutableArray alloc] initWithObjects:strings1 count:3];
    
    
    NSMutableArray *mArr0 = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
    // 崩溃 -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 1]
    mArr0[3];
    
    // 崩溃 -[__NSArrayM objectAtIndex:]: index 3 beyond bounds [0 .. 1]
    [mArr0 objectAtIndex:3];
    
    // 崩溃 -[__NSArrayM objectAtIndexedSubscript:]: index 3 beyond bounds [0 .. 1]
    [mArr0 objectAtIndexedSubscript:3];
    
    // 崩溃 -[NSArray objectsAtIndexes:]: index 10 in index set beyond bounds [0 .. 1]
    NSIndexSet *se = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 9)];
    NSArray *test = [mArr0 objectsAtIndexes:se];
    
    // 崩溃 -[__NSArrayM getObjects:range:]: range {0, 11} extends beyond bounds [0 .. 1]
    NSRange range0 = NSMakeRange(0, 11);
    __unsafe_unretained id cArray[range0.length];
    [mArr0 getObjects:cArray range:range0];
    
    
    //===========
    // 1.Creating and Initializing a Mutable Array
    //===========
    NSMutableArray *mArr1 = [NSMutableArray arrayWithCapacity:0];  // NSUInteger   -1 崩溃
    
    NSMutableArray *mArr2 = [NSMutableArray arrayWithContentsOfFile:nil];
    
    NSMutableArray *mArr3 = [NSMutableArray arrayWithContentsOfURL:[NSURL URLWithString:nil]];
    
    NSMutableArray *mArr4 = [[NSMutableArray alloc] init];
    
    NSMutableArray *mArr5 = [[NSMutableArray alloc] initWithCapacity:0];

    NSMutableArray *mArr6 = [[NSMutableArray alloc] initWithContentsOfFile:nil];

    NSMutableArray *mArr7 = [[NSMutableArray alloc] initWithContentsOfURL:nil];

    //===========
    // 2.Adding Objects
    //===========
    NSMutableArray *mArr8 = [[NSMutableArray alloc] init];
    // 崩溃 -[__NSArrayM insertObject:atIndex:]: object cannot be nil
    [mArr8 addObject:nil];
    
    NSArray *arr1 = nil;
    [mArr8 addObjectsFromArray:arr1];

    // 崩溃 -[__NSArrayM insertObject:atIndex:]: object cannot be nil
    [mArr8 insertObject:nil atIndex:7];
    // 崩溃 -[__NSArrayM insertObject:atIndex:]: index 7 beyond bounds for empty array
    [mArr8 insertObject:@"1" atIndex:7];
    
    // 崩溃 -[NSMutableArray insertObjects:atIndexes:]: index 3 in index set beyond bounds [0 .. 2]'
    // 1. 序号要小于等于mArr8最大值
    NSArray *array = [NSArray arrayWithObjects:@"q",@"d",@"e", nil];  // 2.插入的数组可以为nil
    NSRange range = NSMakeRange(1, [array count]);
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
    [mArr8 insertObjects:array atIndexes:indexSet];
    
    //===========
    // 3.Removing Objects
    //===========
    NSMutableArray *mArr10 = [[NSMutableArray alloc] init];

    [mArr10 removeAllObjects];

    [mArr10 removeLastObject];

    [mArr10 removeObject:@"1"];
    [mArr10 removeObject:nil];

    // 崩溃 -[__NSArrayM removeObjectsInRange:]: range {1, 2} extends beyond bounds for empty array
    [mArr10 removeObjectsInRange:NSMakeRange(1, 2)];

    // 崩溃 -[__NSArrayM removeObjectsInRange:]: range {2, 1} extends beyond bounds for empty array
    [mArr10 removeObjectAtIndex:2];
    
    // 崩溃 -[NSMutableArray removeObjectsAtIndexes:]: index 4 in index set beyond bounds for empty array
    NSRange range1 = NSMakeRange(1, 4);
    NSIndexSet *indexSet1 = [NSIndexSet indexSetWithIndexesInRange:range1];
    [mArr10 removeObjectsAtIndexes:indexSet1];
    
    
    [mArr10 removeObjectIdenticalTo:@"1"];

    // 崩溃  -[NSMutableArray removeObjectIdenticalTo:inRange:]: range {2, 4} extends beyond bounds for empty array
    [mArr10 removeObjectIdenticalTo:@"1" inRange:NSMakeRange(2, 4)];

    [mArr10 removeObjectsInArray:@[@"1",@"2"]];
    [mArr10 removeObjectsInArray:nil];

    // 崩溃 -[__NSArrayM removeObjectsInRange:]: range {1, 3} extends beyond bounds for empty array
    [mArr10 removeObjectsInRange:NSMakeRange(1, 3)];

    //===========
    // 4.Replacing Objects
    //===========
    NSMutableArray *mArr11 = [[NSMutableArray alloc] init];

    // 崩溃 -[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil
    [mArr11 replaceObjectAtIndex:2 withObject:nil];
    // 崩溃 -[__NSArrayM replaceObjectAtIndex:withObject:]: index 2 beyond bounds for empty array
    [mArr11 replaceObjectAtIndex:2 withObject:@"2"];

    // 崩溃 -[__NSArrayM setObject:atIndexedSubscript:]: object cannot be nil
    [mArr11 setObject:nil atIndexedSubscript:2];
     // 崩溃 -[__NSArrayM setObject:atIndexedSubscript:]: index 2 beyond bounds for empty array
    [mArr11 setObject:@"1" atIndexedSubscript:2];

    NSRange range2 = NSMakeRange(1, 4);
    NSIndexSet *indexSet2 = [NSIndexSet indexSetWithIndexesInRange:range2];
    // 崩溃 -[NSMutableArray replaceObjectsAtIndexes:withObjects:]: index 4 in index set beyond bounds for empty array
    [mArr11 replaceObjectsAtIndexes:indexSet2 withObjects:nil];
    // 崩溃 -[NSMutableArray replaceObjectsAtIndexes:withObjects:]: index set cannot be nil
    [mArr11 replaceObjectsAtIndexes:nil withObjects:@[@"1"]];
    
    // 崩溃 -[NSMutableArray replaceObjectsInRange:withObjectsFromArray:]: range {1, 3} extends beyond bounds for empty array
    [mArr11 replaceObjectsInRange:NSMakeRange(1, 3) withObjectsFromArray:nil];
    NSMutableArray *mArr12 = [NSMutableArray arrayWithArray:@[@"a",@"b",@"c"]];
    [mArr12 replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:nil];
    NSMutableArray *mArr13 = [NSMutableArray arrayWithArray:@[@"a",@"b",@"c"]];
    [mArr13 replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:@[@"1",@"2",@"3",@"3",@"3"]];

    // 要判断两个range是否越界
    // 崩溃 -[NSMutableArray replaceObjectsInRange:withObjectsFromArray:range:]: range {0, 3} extends beyond bounds for empty array
    NSMutableArray *mArr14 = [NSMutableArray arrayWithArray:@[@"a",@"b",@"c"]];
    [mArr14 replaceObjectsInRange:NSMakeRange(0, 3) withObjectsFromArray:@[@"1"] range:NSMakeRange(0, 1)];
    
    NSMutableArray *mArr15 = [[NSMutableArray alloc] init];
    [mArr15 setArray:nil];
    [mArr15 setArray:@[@"1"]];
}


@end
