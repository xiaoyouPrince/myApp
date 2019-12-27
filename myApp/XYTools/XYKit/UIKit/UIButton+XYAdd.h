//
//  UIButton+XYAdd.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/5/10.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XYAdd)

/**
 快速设置button title titleColor font

 @param title title
 @param font font
 @param titleColor titleColor
 */
- (void)xy_setTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
