//
//  ViewController.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/19.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self arrCrash];
    
    [self.view addSubview:self.tableView];
}


-(void)arrCrash {
    /*
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
    id *objects;
    NSRange range = NSMakeRange(2, 4);
    objects = malloc(sizeof(id) * range.length);
    [mArray getObjects:objects range:range];
    for (i = 0; i < range.length; i++) {
        NSLog(@"objects: %@", objects[i]);
    }
    free(objects);
    
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
 */
}



-(void)dic {
    id dic = @{@"A":@"111",
               @"B":@"222"
               };
    NSString *C = dic[@"C"];
    NSLog(@"C");
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:nil forKey:@"11"];
    
    id arr1 = @[@"1",@"2",@"3"];
    [arr1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"%@ %@",key, obj);
    }];

    id dic1 = @{@"A":@"111",
                @"B":@"222"
                };
    [dic1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}


#pragma mark - TableView DataSource
// Section Number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Rows Number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }else if (section == 1) {
        return 2;
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
        cell.textLabel.text = @"+ arrayWithObject:  崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        cell.textLabel.text = @"+ arrayWithObjects: count:  崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 3) {
        cell.textLabel.text = @"- initWithObjects: count:  崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 4) {
        cell.textLabel.text = @"@[]; 创建数组崩溃";
    } else if (indexPath.section == 0 && indexPath.row == 5) {
        cell.textLabel.text = @"@[]; 创建数组崩溃";
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
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    headView.backgroundColor = [UIColor greenColor];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100/2, 30)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor orangeColor];
    [headView addSubview:titleLabel];
    
    if (section == 0) {
        titleLabel.text = @"  NSArray崩溃的方法有哪些";
    }else if (section == 1) {
        titleLabel.text = @"  NSDictionary崩溃的方法有哪些";
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
    } else if (indexPath.section == 0 && indexPath.row == 5) {
    } else {
    }
}



#pragma mark - Lazy init
-(UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 100) style:UITableViewStylePlain];

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
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        // 解决tableview上按钮点击效果的延迟现象
        _tableView.delaysContentTouches = NO;
        
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}





@end
