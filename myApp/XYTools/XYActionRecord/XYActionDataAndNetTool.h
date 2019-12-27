//
//  XYActionDataAndNetTool.h
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/7.
//  Copyright © 2019 渠晓友. All rights reserved.
//

//  封装数据 和 发送网络请求的工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSNotificationName UserActionShouldSendNotication;

@interface XYActionDataAndNetTool : NSObject

/**
 根据数据描述添加数据记录

 @param desc 数据描述字符串
 */
+ (void)saveRecordWithDesc:(NSString *)desc;

/**
 获取最终记录数据

 @return 对应的列表数组
 */
+ (NSArray *)getAllRecords;

@end

NS_ASSUME_NONNULL_END
