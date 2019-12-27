//
//  UILabel+XYAdd.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/5/10.
//  Copyright © 2019年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (XYAdd)

#pragma mark - actions

/// tap 时候触发的回调
- (void)xy_tapWithBlock:(void(^)())block;


/**
 快速设置 text & font & textColor

 @param text 需要设置的Text
 @param font 可以为字体名称@"PingFang-SC-Medium" \n或者UIFont对象，\n或者直接字号大小，需要使用NSNumber对象如 @(17)
 @param textolor 颜色可以为HEX色值，\n可以为UIColor对象
 */
- (void)xy_setText:(NSString *)text font:(id)font textColor:(id)textolor;

@end

NS_ASSUME_NONNULL_END
