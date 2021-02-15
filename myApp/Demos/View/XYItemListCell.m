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
    BOOL hasChangeHeightWithContent;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        titleLabel = UILabel.new;
        detailLabel = UILabel.new;
        hasChangeHeightWithContent = false;
        
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
    }
    return self;
}

/*
- (void)layoutSubviews{ // 不能在这里修改 self.frame 会递归
    [super layoutSubviews];
    
//    [titleLabel sizeToFit];
//    [detailLabel sizeToFit];
//
//    CGFloat margin = 23.0;
//    titleLabel.frame = CGRectMake(margin, margin, self.bounds.size.width - 2*margin, titleLabel.bounds.size.height);
//    detailLabel.frame = CGRectMake(margin, 2*margin + titleLabel.bounds.size.height, self.bounds.size.width - 2*margin, detailLabel.bounds.size.height);
//
//    if (!hasChangeHeightWithContent && detailLabel.frame.size.height > 15) {
//        hasChangeHeightWithContent = !hasChangeHeightWithContent;
//        CGRect frame = self.frame;
//        frame.size.height = CGRectGetMaxY(detailLabel.frame) + margin;
//        self.frame = frame;
//    }
}
 */

- (void)setModel:(XYInfomationItem *)model
{
    [super setModel:model];
    
    titleLabel.text = model.title;
    detailLabel.text = model.value ?: model.placeholderValue;
    if (model.backgroundColor) {//特殊处理一下，收个tipView,设置了bgColor
        detailLabel.textColor = model.valueColor;
    }
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(detailLabel.mas_bottom).offset(15);
    }];
}

@end
