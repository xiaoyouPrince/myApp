//
//  NSString+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "NSString+XYAdd.h"

@implementation NSString (XYAdd)

/**
 根据 String 字号和最大宽度计算 String 最终 CGRect
 
 @param width 最大宽度
 @param fontSize 字号
 @return String 最终 CGRect
 */
- (CGRect)xy_boundingRectWithMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *attrs = @{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}


/**
 校验是不是手机号
 
 @return yes/no
 */
- (BOOL)checkPhoneNumber{
    
    if(self.length != 11) return NO;
    
    // 1 开头 长度 11位
    NSString *pattern = @"^1[0-9]{1}[0-9]{1}[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}


/**
 校验是不是18为身份证号
 
 @return yes/no
 */
- (BOOL)checkUserID;
{
    NSString *userID = self;
    
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}

/**
 根据18位身份证号码获取对应出生日期
 
 @return 出生日期
 */
- (NSString *)getCSRQFromUserID{
    
    if (![self checkUserID]) {
        NSException *e = [NSException exceptionWithName:@"获取出生日期错误" reason:@"非身份证号码" userInfo:nil];
        [e raise];
        
        return @"";
    }else
    {
        // 截取 7-14位
        NSMutableString *csrq = [[self substringWithRange:NSMakeRange(6, 8)] mutableCopy];
        
        // 倒序插入两个 “-”
        
        [csrq insertString:@"-" atIndex:6];
        [csrq insertString:@"-" atIndex:4];
        
        return [csrq copy];
        
//        NSString *year = [csrq substringWithRange:NSMakeRange(0, 4)];
//        NSString *month = [csrq substringWithRange:NSMakeRange(4, 2)];
//        NSString *day = [csrq substringWithRange:NSMakeRange(6, 2)];

    }
}


#pragma mark - 设置属性
/**
 给自己的子串设置属性（只有子串才有效）
 
 @param subStr 自己需要设置属性的子串
 @param color 颜色
 @param font 字号
 */
- (NSAttributedString *)setAttributeForSubString:(NSString *)subStr withColor:(UIColor *)color font:(CGFloat)font{
    
    if ([self containsString:subStr]) {
        
        NSString * totalStr = self;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:totalStr];
        
        NSRange range = [totalStr rangeOfString:subStr];
        NSDictionary *attrs = @{NSForegroundColorAttributeName : color,
                                NSFontAttributeName : [UIFont boldSystemFontOfSize:font]
                                };
        [attrStr addAttributes:attrs range:range];
        
        return attrStr;
    }
    
    return nil;
}


/// 设置文字多行时候的行间距
/// @param lineSpasePt 行间距，单位为point
- (NSMutableAttributedString *)setLineSpase:(NSInteger)lineSpasePt
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
    paragrapStyle.lineSpacing = lineSpasePt;
    NSRange range = [self rangeOfString:self];
    [attrString addAttribute:NSParagraphStyleAttributeName value:paragrapStyle range:range];
    
    return attrString;
}

@end
