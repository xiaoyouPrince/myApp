//
//  XYUserNotificationTool.h
//  myApp
//
//  Created by 渠晓友 on 2020/5/27.
//  Copyright © 2020 渠晓友. All rights reserved.
//
//  基于 iOS 10 的推送服务小工具

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  @class XYUserNotificationTool
 *  @brief 此工具封装了几个常用的推送权限处理逻辑，主要为 @b 查询授权情况 @b 请求推送授权 @b 添加本地推送
 *  @note 本工具中所有对调都在主线程，可以放心修改UI。
 *  @code
    // 请求授权情况
    [XYUserNotificationTool getAuthorizationStatusWithAuth:^{
        // 添加推送
        [self addNotication];
 
    } denied:^{
        // 给用户提示
        [XYAlertView showAlertOnVC:self title:@"未开启推送" message:@"请去设置->FESCO->推送打开推送服务" okTitle:@"设置" okAction:^{
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"进入到设置页面");
                }
            }];
        } cancelTitle:@"取消" cancelAction:nil];
        
    } notDetermind:^{
        // 请求授权
        [XYUserNotificationTool requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) { // 授权成功
                [self addNotication];
            }
        }];
    }];

    // 添加一个本地推送示例
    - (void)addNotication{
        
        [XYUserNotificationTool addLocalNotification:^UNNotificationRequest * _Nonnull{
            
            // 创建一个本地推送
            UNMutableNotificationContent *content = [UNMutableNotificationContent new];
            content.title = @"这是ios10 之后的推送";
            content.subtitle = @"hello 欢迎你打开新的推送功能啊。。。。";
        
            // 在应用前台推送，需要设置通知中心代理
            UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.0f repeats:NO];
        
            UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"myLocalRequst" content:content trigger:trigger];
            
            return request;

        } completionHandler:^(NSError * _Nullable error) {
            
            // 完成的回调
            self.authLabel.text = @"添加本地推送成功---";
            
        }];
    }
 *  @endcode
 */
@interface XYUserNotificationTool : NSObject

/// 查看当前App通知的权限 - 如果需要请求授权请使用其他方法
/// @param authed 已经授权状态的回调 - 回调在主线程
/// @param dneied 已经拒绝状态的回调 - 回调在主线程
/// @param notDetermind 未选择状态的回调 - 回调在主线程
+ (void)getAuthorizationStatusWithAuth:(dispatch_block_t)authed
                                denied:(dispatch_block_t)dneied
                          notDetermind:(dispatch_block_t)notDetermind;


/// 请求推送权限 - 只有在未决定的状态才会弹出请求授权弹框
/// @param options 要推送类型选项
/// @param completionHandler 用户授权完成回调，granted 参数表示成功失败 - 回调在主线程
+ (void)requestAuthorizationWithOptions:(UNAuthorizationOptions)options
                      completionHandler:(void(^)(BOOL granted, NSError * _Nullable error))completionHandler;


/// 添加本地推送
/// @param addLocalNotificationBlock 添加本地推送回调
+ (void)addLocalNotification:(UNNotificationRequest *(^)(void))addLocalNotificationBlock
           completionHandler:(void(^)(NSError * _Nullable error))completionHandler;


@end

NS_ASSUME_NONNULL_END
