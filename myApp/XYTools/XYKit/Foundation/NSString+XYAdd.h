//
//  NSString+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYAdd)

/**
 根据 String 字号和最大宽度计算 String 最终 CGRect

 @param width 最大宽度
 @param fontSize 字号
 @return String 最终 CGRect
 */
- (CGRect)xy_boundingRectWithMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize;


/**
 校验是不是手机号
 
 @return yes/no
 */
- (BOOL)checkPhoneNumber;

/**
 校验是不是18为身份证号
 
 @return yes/no
 */
- (BOOL)checkUserID;

/**
 根据18位身份证号码获取对应出生日期
 
 @return 出生日期 yyyy-MM-dd
 */
- (NSString *)getCSRQFromUserID;


#pragma mark - 设置属性
/**
 给自己的子串设置属性（只有子串才有效）  --  只能设置第一个出现的子串

 @param subStr 自己需要设置属性的子串
 @param color 颜色
 @param font 字号
 @return 生成的属性字符串
 */
- (NSAttributedString *)setAttributeForSubString:(NSString *)subStr withColor:(UIColor *)color font:(CGFloat)font;

/// 设置文字多行时候的行间距
/// @param lineSpasePt 行间距，单位为point
- (NSMutableAttributedString *)setLineSpase:(NSInteger)lineSpasePt;

@end
