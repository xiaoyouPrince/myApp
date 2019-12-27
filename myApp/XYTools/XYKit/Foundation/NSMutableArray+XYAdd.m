//
//  NSMutableArray+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/12/5.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "NSMutableArray+XYAdd.h"

@implementation NSMutableArray (XYAdd)

/**
 可变数组内部元素倒序
 */
- (void)xy_reverseObjectInArray
{
    NSEnumerator *enums = [self reverseObjectEnumerator];
    NSArray *array = [enums allObjects];
    [self removeAllObjects];
    
    for (id obj in array) {
        [self addObject:obj];
    }
}

@end
