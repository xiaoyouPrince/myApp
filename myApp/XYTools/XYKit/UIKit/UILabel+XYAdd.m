//
//  UILabel+XYAdd.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/5/10.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import "UILabel+XYAdd.h"

@implementation UILabel (XYAdd)



- (void)xy_tapWithBlock:(void(^)())block
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__taped:)];
    [self addGestureRecognizer:tap];
}
- (void)__taped:(UITapGestureRecognizer *)tap{
    
}

- (void)xy_setText:(NSString *)text font:(id)font textColor:(id)textolor{
    
    // text
    if (text) {
        self.text = text;
    }
    
    
    // font
    if ([font isKindOfClass:NSString.class]) {
        self.font = [UIFont fontWithName:font size:17];
    }
    
    if ([font isKindOfClass:UIFont.class]) {
        self.font = font;
    }
    
    if ([font isKindOfClass:NSNumber.class]) {
        CGFloat fontSize = [font floatValue];
        self.font = [UIFont systemFontOfSize:fontSize];
    }
    
    
    // color
    if ([textolor isKindOfClass:UIColor.class]) {
        self.textColor = textolor;
    }
    


    if ([textolor isKindOfClass:NSString.class]) {
        
        // @“FFFFFF” -> 转成16进制
        // 暂过
        //self.textColor = textolor;
    }
    
    if ([textolor isKindOfClass:NSNumber.class]) {
        
        // hexValue 0xffffff
        
        NSInteger hexValue = [textolor integerValue];
        CGFloat r = ((hexValue & 0xFF0000) >> 16) / 255.0;
        CGFloat g = ((hexValue & 0xFF00) >> 8) / 255.0;
        CGFloat b = ((hexValue & 0xFF) >> 0) / 255.0;
        UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:1.0];
        
        self.textColor = color;
    }
    

    
}

@end
