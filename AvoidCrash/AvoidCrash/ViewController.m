//
//  ViewController.m
//  AvoidCrash
//
//  Created by 启业云 on 2019/8/19.
//  Copyright © 2019 启业云. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // arr崩溃演示
    [self arrCrash];

//    [self queryArr];
}


-(void)arrCrash {
    //===========
    // 创建数组
    //===========
    // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]
    NSString *string = nil;
//    NSArray *arr1 = @[@"1",@"2",string];

    NSArray *temp = nil;
    NSArray *arr2 = [NSArray arrayWithArray:temp];

    // 崩溃 -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]
//    NSArray *arr3 = [NSArray arrayWithObject:nil];

    NSArray *arr4 = [NSArray arrayWithObjects:nil];

    NSString *strings[3];
    strings[0] = @"First";
    strings[1] = @"Second";
    strings[2] = @"Third";
    NSArray *arr5 = [NSArray arrayWithObjects:strings count:10];

    
    //===========
    // 初始化数组
    //===========
    NSArray *arr6 = [[NSArray alloc] init];

    NSArray *arr7 = [[NSArray alloc] initWithArray:nil];

    NSArray *arr8 = [[NSArray alloc] initWithArray:nil copyItems:YES];

    NSArray *arr9 = [[NSArray alloc] initWithObjects:nil];

    NSString *strings1[3];
    strings1[0] = @"First";
    strings1[1] = @"Second";
    strings1[2] = @"Third";
    NSArray *arr10 = [[NSArray alloc] initWithObjects:strings1 count:3];
    
}

-(void)queryArr {
    NSArray *arr = @[@"1", @"2"];
    
    [arr containsObject:nil];
    
//    arr getObjects:<#(__unsafe_unretained id  _Nonnull * _Nonnull)#> range:<#(NSRange)#>
    
    // 崩溃 -[__NSArrayI objectAtIndex:]: index 4 beyond bounds [0 .. 1]
//    [arr objectAtIndex:4];
}




//    id arr1 = @[@"1",@"2",@"3"];
//
//    [arr1 enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"%@ %@",key, obj);
//    }];


//    id dic1 = @{@"A":@"111",
//                @"B":@"222"
//                };
//    [dic1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@",obj);
//    }];


@end
