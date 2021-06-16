//
//  UILabel+XYAdd.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/5/10.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "UILabel+XYAdd.h"

@implementation UILabel (XYAdd)

- (void)xy_setText:(NSString *)text font:(id)font textColor:(id)textColor{
    self.text = text;
    self.font = font;
    self.textColor = textColor;
}
+ (UILabel *)xy_getLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor
{
    UILabel *label = UILabel.new;
    [label xy_setText:text font:font textColor:textColor];
    return label;
}

@end
