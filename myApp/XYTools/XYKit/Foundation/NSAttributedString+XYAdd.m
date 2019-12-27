
//
//  NSAttributedString+XYAdd.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/4/12.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "NSAttributedString+XYAdd.h"

@implementation NSAttributedString (XYAdd)

+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color font:(CGFloat)font range:(NSRange)range
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    if (color != nil) {
        [attrs setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font != 0) {
        [attrs setObject:[UIFont systemFontOfSize:font] forKey:NSFontAttributeName];
    }
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attrStr setAttributes:attrs range:range];
    
    return attrStr;
}

@end


