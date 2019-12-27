//
//  XYRequestParam.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYRequestParam.h"

@implementation XYRequestParam

/**
 *  初始化
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        // do some initialize
    }
    return self;
}


- (int)orderType
{
    
    if (_orderType) {
        return _orderType;
    }
    
    // 目前测试环境，默认是即时叫车(好像也只有这个模式，后期可能有约车)
    return 1;
}

- (int)serviceType
{
    if (_orderType) {
        return _orderType;
    }
    
    return _serviceType;
}

- (long long)bookingDate
{
    // 根据订单类型返回不同的约车时间
    if(self.orderType != BookCarOrderTypeRightNow){ // 非即时订车，返回用户选择的约车时间
        return _bookingDate;
        
    }else if(self.serviceType != BookCarOrderTypeRightNow){ // 非即时订车，返回用户选择的约车时间
        return _bookingDate;
        
    }else
    {
        NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
        return interval;
    }
}

- (int)cityId{
    
    if (_cityId) {
        return _cityId;
    }
    
    // 目前测试环境，直接返回44 北京
    return 44;
}

- (NSString *)groups{
    
    if (_groups) {
        return _groups;
    }
    
    // 默认：舒适型 1辆
    return @"34:1";
}

- (NSString *)groupIds
{
    if (_groupIds) {
        return _groupIds;
    }
    
    // 默认 34 舒适型组
    return @"34";
}

- (NSString *)payFlag{
    if (_payFlag) {
        return _payFlag;
    }
    
    // 默认渠道付款
    return @"0";
}

- (NSString *)imei
{
    return @"123456789012345";
}


#pragma mark - 需要 URLEncode 编码之后的
//- (NSString *)riderName{
//    return [_riderName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}
//
//- (NSString *)bookingStartAddr
//{
//    return [_bookingStartAddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}
//
//- (NSString *)bookingEndAddr
//{
//    return [_bookingEndAddr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//}

@end
