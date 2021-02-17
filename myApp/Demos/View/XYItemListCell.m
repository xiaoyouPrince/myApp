//
//  XYItemListCell.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/14.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYItemListCell.h"
#import <Masonry.h>

@implementation XYItemListCell{
    UILabel *titleLabel;
    UILabel *detailLabel;
    UIView *accView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        titleLabel = UILabel.new;
        detailLabel = UILabel.new;
        
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.textColor = UIColor.blackColor;
        
        detailLabel.font = [UIFont boldSystemFontOfSize:18];
        detailLabel.textColor = UIColor.brownColor;
        detailLabel.numberOfLines = 0;
        
        // subviews
        [self addSubview:titleLabel];
        [self addSubview:detailLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
        
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(15);
            make.left.right.equalTo(titleLabel);
        }];
        
        // accView
        accView = [UIView new];
        [self addSubview:accView];
        [accView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detailLabel.mas_bottom).offset(15);
            make.left.right.equalTo(detailLabel);
        }];
    }
    return self;
}

/*
// 不能在这里修改 self.frame 会递归
- (void)layoutSubviews{
    [super layoutSubviews];
 
 }
 */

- (void)setModel:(XYInfomationItem *)model
{
    [super setModel:model];
    
    titleLabel.text = model.title;
    detailLabel.text = model.value ?: model.placeholderValue;
    if (model.backgroundColor) {//特殊处理一下，首个tipView,设置了bgColor
        detailLabel.textColor = model.valueColor;
    }
    
    if (model.accessoryView) {
        [accView addSubview:model.accessoryView];
        [model.accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.edges.equalTo(accView);
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(accView.mas_bottom).offset(15);
        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(detailLabel.mas_bottom).offset(15);
        }];
    }
}

@end
