//
//  UIBarButtonItem+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#define UIBarButtonDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#import <UIKit/UIKit.h>

/*
 一共四个方法：
 1. 创建可点击的变效果的item
 2. 创建返回按钮 <箭头+文字>
 3. 创建一个只有文字的item
 */

@interface UIBarButtonItem (XYAdd)

/// 快速创建UIBarButtonItem
+ (UIBarButtonItem *)xy_itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

/// 快速创建选中状态UIBarButtonItem
+ (UIBarButtonItem *)xy_itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

/// 快速创建返回按钮(leftItem)  可设置返回箭头+文字
+ (UIBarButtonItem *)xy_backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;

/// 快速右侧功能按钮(rightItem)  通常为‘操作’、‘确定’等，无图
+ (UIBarButtonItem *)xy_itemWithTarget:(id)target action:(SEL)action title:(NSString *)title;

@end

@interface UIBarButtonItem (XYAddDeprecated_v_11_0)

#define IOS_11_0_DEPRECATED_STR "iOS 11请使用新方法,方法名前添加 xy_***"
#define DEPRECATED_TIPS UIBarButtonDeprecated(IOS_11_0_DEPRECATED_STR)

/// 快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

/// 快速创建选中状态UIBarButtonItem
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action DEPRECATED_TIPS;

/// 快速创建返回按钮(leftItem)  可设置返回箭头+文字
+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title DEPRECATED_TIPS;

/// 快速右侧功能按钮(rightItem)  通常为‘操作’、‘确定’等，无图
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title DEPRECATED_TIPS;

#undef DEPRECATED_TIPS
@end
