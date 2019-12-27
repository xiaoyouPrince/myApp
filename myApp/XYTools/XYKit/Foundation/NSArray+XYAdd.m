//
//  NSArray+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/12/5.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "NSArray+XYAdd.h"

@implementation NSArray (XYAdd)

/**
 返回自己的倒序数组

 @return 倒序可变数组
 */
- (NSMutableArray *)xy_reverseArray
{
    NSMutableArray *arrayM = [NSMutableArray array];
    NSEnumerator *enums = [self reverseObjectEnumerator];
    for (id obj in [enums allObjects]) {
        [arrayM addObject:obj];
    }
    return arrayM;
}


/**
 手动返回倒序数组（自写算法）

 @return 倒序数组
 */
- (NSMutableArray *)xy_reverseArray_Mantal
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id obj in self) {
        [arrayM addObject:obj];
    }
    
    // 单元素/空数组 直接返回
    if (arrayM.count < 2) {
        return arrayM;
    }
    
    NSUInteger midNum = 0;
    if (arrayM.count % 2 == 0) {
        // 偶数组
        midNum = arrayM.count / 2;
    }else
    {
        // 奇数组
        midNum = arrayM.count / 2 + 1;
    }
    
    for (int i = 0; i < midNum ; i++) {
        id obj = arrayM[i];
        id obj2 = arrayM[arrayM.count - i - 1];
        
        id temp = obj2;
        [arrayM replaceObjectAtIndex:arrayM.count - i - 1 withObject:obj];
        [arrayM replaceObjectAtIndex:i withObject:temp];
    }
    return arrayM;
}

@end
