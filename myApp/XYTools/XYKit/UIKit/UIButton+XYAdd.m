//
//  UIButton+XYAdd.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/5/10.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "UIButton+XYAdd.h"

@implementation UIButton (XYAdd)

- (void)xy_setTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor
{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

@end
