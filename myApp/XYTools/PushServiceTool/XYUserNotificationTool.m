//
//  XYUserNotificationTool.m
//  myApp
//
//  Created by 渠晓友 on 2020/5/27.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "XYUserNotificationTool.h"

@implementation XYUserNotificationTool

void doinMainThread(void(^block)(void)){
    dispatch_async(dispatch_get_main_queue(), ^{
        if(block){
            block();
        }
    });
}

+ (void)getAuthorizationStatusWithAuth:(dispatch_block_t)authed
                                denied:(dispatch_block_t)dneied
                          notDetermind:(dispatch_block_t)notDetermind
{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        doinMainThread(^{
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                if (dneied) {
                    dneied();
                }
            }else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined)
            {
                if (notDetermind) {
                    notDetermind();
                } 
            }else
            {
                if (authed) {
                    authed();
                }
            }
        });
    }];
}


+ (void)requestAuthorizationWithOptions:(UNAuthorizationOptions)options completionHandler:(void (^)(BOOL, NSError * _Nullable))completionHandler
{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        doinMainThread(^{
            if (completionHandler) {
                completionHandler(granted,error);
            }
        });
    }];
}

+ (void)addLocalNotification:(UNNotificationRequest * _Nonnull (^)(void))addLocalNotificationBlock completionHandler:(void (^)(NSError * _Nullable))completionHandler{

    if (addLocalNotificationBlock) {
        UNNotificationRequest *request = addLocalNotificationBlock();
        
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];

        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            
            doinMainThread(^{
                if (completionHandler) {
                    completionHandler(error);
                }
            });
        }];
    }
}

@end
