
//
//  NSAttributedString+XYAdd.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/4/12.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (XYAdd)

+ (instancetype)attributedString:(NSString *)string color:(UIColor *)color font:(CGFloat)font range:(NSRange)range;

@end

