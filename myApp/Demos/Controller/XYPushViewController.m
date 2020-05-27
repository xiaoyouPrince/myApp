//
//  XYPushViewController.m
//  myApp
//
//  Created by 渠晓友 on 2020/5/26.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "XYPushViewController.h"
#import <UserNotifications/UserNotifications.h>


@interface XYPushViewController ()

@property (weak, nonatomic) IBOutlet UILabel *authLabel;


@end

@implementation XYPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)checkAuth:(id)sender {
    
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
        if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
            
            // 提示用户去开启推送
//            self.authLabel.text = @"未开启推送服务";
            
            [XYAlertView showAlertOnVC:self title:@"未开启推送" message:@"请去设置->FESCO->推送打开推送服务" okTitle:@"设置" okAction:^{
                
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                    
                    if (success) {
                        NSLog(@"进入到设置页面");
                    }
                }];
                
            } cancelTitle:@"取消" cancelAction:nil];
            
        }else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined)
        {
            // 未决定，直接申请授权
            
            [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
                
                if (granted) { // 用户授权成功
                    [self addNotication];
                }
                
            }];
            
        }else
        {
            // 已经授权
            [self addNotication];
        }
        
    }];
    
}


- (void)addNotication{
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"这是ios10 之后的推送";
    content.subtitle = @"hello 欢迎你打开新的推送功能啊。。。。";
    
    // 在应用前台不会推送
    UNNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3.0f repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"myrequst" content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
       
        if (error) {
            [XYAlertView showAlertOnVC:self title:@"error" message:error.description okTitle:@"ok" Ok:nil];
        }
        
    }];
}


- (IBAction)请求推送权限:(id)sender {
    
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:
             (UNAuthorizationOptionAlert +
              UNAuthorizationOptionSound)
       completionHandler:^(BOOL granted, NSError * _Nullable error) {
          // Enable or disable features based on authorization.
    }];
}



@end
