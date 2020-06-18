////  UIColor+XYAdd.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/3/2.
//
//  Copyright © 2018年 FESCO. All rights reserved.
//


#import "UIColor+XYAdd.h"

@implementation UIColor (XYAdd)


#pragma mark - 查看本地配置

+ (NSString *)hexStingWithName:(NSString *)selName{
    
    if ([selName containsString:@"xy_"]) {
        selName = [selName substringFromIndex:3];
    }
    
    NSBundle *currentBundle = [NSBundle mainBundle];
    NSString *path = [currentBundle pathForResource:@"ColorConfig" ofType:@"plist"];
    NSDictionary *configDict = [NSDictionary dictionaryWithContentsOfFile:path];
    return [configDict valueForKey:selName];
}



+ (UIColor *)colorWithSEL:(SEL)sel
{
    NSString *selStr = NSStringFromSelector(sel);
    NSString *hexStr = [self hexStingWithName:selStr];
    if (hexStr) {
        return [self colorWithHexString:hexStr];
    }
    
    if ([selStr containsString:@"title"]) {
        return UIColor.redColor;
    }
    else if ([selStr containsString:@"content"]) {
        return UIColor.greenColor;
    }
    else if ([selStr containsString:@"placeholder"]) {
        return UIColor.grayColor;
    }
    
    return UIColor.clearColor;
}


#pragma mark - public

// 从十六进制字符串获取颜色，格式为 RGB[A] ,A 默认1.0f
// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rString = [cString substringWithRange:range];
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // a
    NSString *aString;
    if (cString.length == 8) {
        range.location = 6;
        aString = [cString substringWithRange:range];
    }

    // Scan values
    unsigned int r, g, b, a=0xff;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:((float) a / 255.0f)];
}

+ (UIColor *)xy_titleColor
{
    return [self colorWithSEL:_cmd];
}

+ (UIColor *)xy_contentColor
{
    return [self colorWithSEL:_cmd];
}

+ (UIColor *)xy_placeholderColor
{
    return [self colorWithSEL:_cmd];
}
@end
