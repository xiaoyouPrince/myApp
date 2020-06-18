////  UIColor+XYAdd.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/3/2.
//
//  Copyright © 2018年 FESCO. All rights reserved.
//

/**
    一个颜色工具类
 可以快速返回项目内需要的几种颜色
 此颜色可以动态配置
 */

#import <UIKit/UIKit.h>

@interface UIColor (XYAdd)

/** 项目标准的 titleColor */
@property (class, nonatomic, readonly)         UIColor * xy_titleColor;
/** 项目标准的 contentColor */
@property (class, nonatomic, readonly)         UIColor * xy_contentColor;
/** 项目标准的站位颜色 */
@property (class, nonatomic, readonly)         UIColor * xy_placeholderColor;


// 从十六进制字符串获取颜色，格式为 RGB[A]
// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color;


@end
