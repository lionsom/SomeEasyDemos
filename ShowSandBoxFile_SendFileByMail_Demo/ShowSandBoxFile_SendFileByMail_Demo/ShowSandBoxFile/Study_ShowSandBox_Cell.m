//
//  Study_ShowSandBox_Cell.m
//  TodayNews
//
//  Created by linxiang on 2019/4/29.
//  Copyright © 2019 LX. All rights reserved.
//

#import "Study_ShowSandBox_Cell.h"

#import "Study_ShowSandBox_Model.h"

#import "Masonry.h"

static NSString * reuseIdentifier = @"Study_ShowSandBox_Cell_ID";


@interface Study_ShowSandBox_Cell()

@property (nonatomic, strong) UILabel * nameLabel;

@end

@implementation Study_ShowSandBox_Cell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    Study_ShowSandBox_Cell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[Study_ShowSandBox_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //创建UI
        [self CreateUI];
    }
    return self;
}


-(void)CreateUI {
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.text = @"A";
    _nameLabel.adjustsFontSizeToFitWidth = YES;
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.and.right.and.bottom.equalTo(self);
    }];
    
    UILabel * lineLabel = [[UILabel alloc]init];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self);
        make.height.equalTo(@0.5);
    }];
}


-(void)setmodel:(Study_ShowSandBox_Model *)model {
    _nameLabel.text = model.name;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
