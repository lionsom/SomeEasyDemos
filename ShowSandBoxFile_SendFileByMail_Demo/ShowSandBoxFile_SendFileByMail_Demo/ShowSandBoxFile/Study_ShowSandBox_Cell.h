//
//  Study_ShowSandBox_Cell.h
//  TodayNews
//
//  Created by linxiang on 2019/4/29.
//  Copyright © 2019 LX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Study_ShowSandBox_Model;

NS_ASSUME_NONNULL_BEGIN

@interface Study_ShowSandBox_Cell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

-(void)setmodel:(Study_ShowSandBox_Model *)model;

@end

NS_ASSUME_NONNULL_END
