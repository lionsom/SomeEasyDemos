//
//  ViewController.m
//  Analyze_YYModel
//
//  Created by linxiang on 2019/5/24.
//  Copyright © 2019 Minxing. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>

#import "numberModel.h"
#import "User.h"

#import "Author.h"
#import "Book.h"

#import "TeacherModel.h"

#import "ContainerModel.h"
#import "DemoModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"调试页面";
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.and.bottom.equalTo(self.view);
    }];
}



#pragma mark - tableView DataSource
// Section number
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// row number
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

// init cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;   // 点击变色
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"nsnumber 代替 基本数据类型";
            return cell;
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"最简单的 JSON -> Model";
            return cell;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"Model in Model";
            return cell;
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"创建 [BBB] queue";
            return cell;
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"创建 [BBB] queue";
            return cell;
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = @"创建 [BBB] queue";
            return cell;
        }
    }
    return nil;
}


#pragma mark - tableView Delegate

// cell height
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

// section头部 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

// section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

// 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 点击后恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self NSNumberTest];
        }
        if (indexPath.row == 1) {
            [self simpleModelJsonModelConvert];
        }
        if (indexPath.row == 2) {
            [self DoubleModelJsonModelConvert];
        }
        if (indexPath.row == 3) {
            [self TeacherModelJsonModelConvert];
        }
        if (indexPath.row == 4) {
            [self containerJsonModelConvert];
        }
        if (indexPath.row == 5) {
            
        }
    }
}



#pragma mark - NSNumber代替NSInteger测试
-(void)NSNumberTest {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:@"NSNumberModel" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSLog(@"源数据 = %@", result);
    numberModel *model = [[numberModel alloc] init];
    [model setValuesForKeysWithDictionary:result];
    NSLog(@"model.timestamp = %d",model.timestamp);
}


#pragma mark - custom Method
//读取本地json,获取json数据
- (NSDictionary *)getJsonWithJsonName:(NSString *)jsonName {
    //从本地读取json数据（这一步你从网络里面请求）
    NSString *path = [[NSBundle mainBundle]pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (void) simpleModelJsonModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"SimpleModel"];
    // Convert json to model:
    User *user = [User yy_modelWithDictionary:json];
    NSLog(@"uid = %@ , name = %@ , age = %@ , createT = %@ ,createT_String = %@ ,timestamp = %@ , isstu = %@ , friend_name = %@",
          user.uid,
          user.name,
          user.age,
          user.created,
          user.created_String,
          user.timestamp,
          user.isstu,
          user.friend_name);
    
    // Convert model to json:
    NSDictionary *jsonConvert = [user yy_modelToJSONObject];
    NSLog(@"%@",jsonConvert);
}


- (void) DoubleModelJsonModelConvert {
    NSDictionary *json = [self getJsonWithJsonName:@"DoubleModel"];
    
    // Convert json to model:
    Book *book = [Book yy_modelWithDictionary:json];
    NSLog(@"book ===== %@",book);
    
    // Convert model to json:
    NSDictionary *jsonDict = [book yy_modelToJSONObject];
    NSLog(@"jsonDict ===== %@",jsonDict);
}



- (void) TeacherModelJsonModelConvert {

    NSDictionary *json = [self getJsonWithJsonName:@"TeacherModel"];
    
    // Convert json to model:
    TeacherModel *book = [TeacherModel yy_modelWithDictionary:json];
    NSLog(@"teacher ===== %@",book);
    
    // Convert model to json:
    NSDictionary *jsonDict = [book yy_modelToJSONObject];
    NSLog(@"jsonDict ===== %@",jsonDict);
}


- (void) containerJsonModelConvert {
    NSDictionary *json =[self getJsonWithJsonName:@"ContainerModel"];
    
    ContainerModel *containModel = [ContainerModel yy_modelWithDictionary:json];
    
    NSDictionary *dataDict = [containModel valueForKey:@"data"];
    
    NSArray *listArray = [dataDict valueForKey:@"list"];
    
    //遍历数组获取里面的字典，在调用YYModel方法
    [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *listDict = obj;
        List *listModel = [List yy_modelWithDictionary:listDict];
        //随便获取count 和 id两个类型
        NSString *count = [listModel valueForKey:@"count"];
        NSString *id = [listModel valueForKey:@"id"];
        NSLog(@"count == %@,id === %@",count,id);
    }];
}


#pragma mark - Lazy init

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        
        //代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        // 设置分割线     UITableViewCellSeparatorStyleSingleLineEtched 配置只在Gruop类型下使用
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // 分割线颜色
        _tableView.separatorColor = [UIColor lightGrayColor];
        
        //推测高度，必须有，可以随便写多少 否则：iOS11底部刷新错乱
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        
        // 设置空白，在回掉中设置高度为空
        // _tableView.tableHeaderView = [UIView new];
        // _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
