//
//  NSArray+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/12/5.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (XYAdd)


/**
 返回倒序数组

 @return 倒序数组
 */
- (NSMutableArray *)xy_reverseArray;

/**
 手动返回倒序数组（自写算法）
 
 @return 倒序数组
 */
- (NSMutableArray *)xy_reverseArray_Mantal;

@end
