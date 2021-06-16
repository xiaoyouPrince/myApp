//
//  UILabel+XYAdd.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/5/10.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XYAdd)

/**
 快速设置 text & font & textColor
 @param text 需要设置的Text
 @param font font
 @param textColor color
 */
- (void)xy_setText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;
+ (UILabel *)xy_getLabelWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor;

@end

NS_ASSUME_NONNULL_END
