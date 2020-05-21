//
//  XYHealthKitTool.h
//  myApp
//
//  Created by 渠晓友 on 2020/5/21.
//  Copyright © 2020 渠晓友. All rights reserved.
//

//  此类仅仅获取用户将康数据的步数

/*
 @note 使用须知
 
 1. 使用到健康数据，需要在应用的能力中开启健康
    如果项目中没有用到用户的健康诊疗数据，请勿选择 Clinical Health Records 选项
 
 2. 涉及到隐私，需要在 Info.plist 中添加
    NSHealthShareUsageDescription ： 描述读取数据Key
    NSHealthUpdateUsageDescription ： 描述写入的Key
 
    需要您的同意，才能访问健康更新，给您带来更好的服务
 
 */



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^StepCountHandler)(NSInteger totalCount, NSError * _Nullable error);

@interface XYHealthKitTool : NSObject

/// 获取用户当天步数
/// @param handler 获取结果回调
+ (void)getTodayTotalStepCountHandler:(StepCountHandler)handler;
@end

NS_ASSUME_NONNULL_END
