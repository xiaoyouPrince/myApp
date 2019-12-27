//
//  XYRequestParam.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//
//  请求参数

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BookCarOrderType) {
    BookCarOrderTypeRightNow = 1,  ///< 即时约车
    BookCarOrderTypeLater,         ///< 预约用车
};

@interface XYRequestParam : NSObject

//系统自动生成的两个参数，不用关心
//@property(nonatomic , copy) NSString *sign;
//@property(nonatomic , copy) NSString *channel;


#pragma mark -- 请求车费预估

// 服务类型，一般是 1
//1    随叫随到
//2    预约用车
//3    接机
//4    代人叫车
//5    送机
//6    日租
//7    半日租
//11    接站
//12    送站

@property(nonatomic , assign) int orderType;                 ///< 服务类型ID(下单接口新加)
@property(nonatomic , assign) int serviceType;               ///< 服务类型ID(预估车价使用,同orderType)
@property(nonatomic , assign) long long bookingDate;         ///< 预定日期时间， 10位时间戳
@property(nonatomic , assign) int cityId;                    ///< 城市ID
@property(nonatomic , copy) NSString *bookingStartPointLo;   ///< 预定开始坐标经度
@property(nonatomic , copy) NSString *bookingStartPointLa;   ///< 预定开始坐标纬度
@property(nonatomic , copy) NSString *bookingEndPointLo;     ///< 预定结束坐标经度
@property(nonatomic , copy) NSString *bookingEndPointLa;     ///< 预定结束坐标纬度
@property(nonatomic , copy) NSString *groups;                ///< 用车车型及数量,示例： "34 : 1, 35 : 2"，多种车型用","隔开



#pragma mark -- 下单
// 所需参数如下
//{
//    "bookingDate": "1521446157",
//    "riderPhone": "17355208153",
//    "bookingStartAddr": "银河SOHO",
//    "bookingEndAddr": "新康园",
//    "bookingStartPointLo": "116.433132",
//    "bookingStartPointLa": " 39.920639",
//    "bookingEndPointLo": "116.34733",
//    "bookingEndPointLa": "40.06693",
//    "imei": "1234",
//    "cityId": "44",
//    "groupIds": "34",
//    "estimatedAmount": "158",
//    "partnerOrderNo": "123456",
//    "riderName": "",
//    "verifyCode": "",
//    "payFlag": 0,
//    "couponCode": "",
//    "isNew": "",
//    "fingerVerifyId": ""
//}
@property(nonatomic , copy) NSString *riderPhone;       ///< 乘车人手机号
@property(nonatomic , copy) NSString *bookingStartAddr; ///< 约车开始地址
@property(nonatomic , copy) NSString *bookingEndAddr;   ///< 约车结束地址
@property(nonatomic , copy) NSString *imei;             ///< 设备唯一标示
@property(nonatomic , copy) NSString *groupIds;         ///< 用车组id
@property(nonatomic , copy) NSString *estimatedAmount;  ///< 预估车费
@property(nonatomic , copy) NSString *partnerOrderNo;   ///< 我们自己的服务单号 【以上皆为必选】
@property(nonatomic , copy) NSString *riderName;        ///< 乘车人姓名 【可选】
@property(nonatomic , copy) NSString *verifyCode;       ///< 手机验证码 【可选】
@property(nonatomic , copy) NSString *payFlag;          ///< 支付渠道,0渠道付，1乘车人付。默认1. 【可选】
@property(nonatomic , copy) NSString *couponCode;       ///< 优惠券号 【可选】
@property(nonatomic , copy) NSString *isNew;            ///< 是否新用户 【可选】
@property(nonatomic , copy) NSString *fingerVerifyId;   ///< 指纹设备id 【可选】
@property(nonatomic , copy) NSString *remark;           ///< 用车说明 【可选】


#pragma mark -- 轮询订单状态

//查询司机位置接口。当司机已经接单后，可以通过订单号查询司机当前位置。目前，位置信息将会5秒更新一次。
//注意：订单已经结算完成便不需要查询司机位置

// 所需参数如下
//{
//    "orderNo" : "2335325",
//    "partnerOrderNo" : "562374789023234"
//}

@property(nonatomic , copy) NSString *orderNo;          ///< 首汽约车生成的订单号 【以上皆为必选】









@end
