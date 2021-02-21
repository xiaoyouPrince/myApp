//
//  XYPushViewController.m
//  myApp
//
//  Created by 渠晓友 on 2020/5/26.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "XYPushViewController.h"
#import "XYUserNotificationTool.h"


@interface XYPushViewController ()<UNUserNotificationCenterDelegate>

@property (weak, nonatomic) IBOutlet UILabel *authLabel;
@property (weak, nonatomic) IBOutlet UILabel *label2;


@end

@implementation XYPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];;
    center.delegate = self;
}

#pragma mark - 前端处理回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    // 此处用户在前台的时候，可以根据推送的信息设置展示样式
    
    if (completionHandler) {
        completionHandler(UNNotificationPresentationOptionAlert);
    }
}
// 用户处理前端消息会做
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    // 根据用户处理操作，可以进行本地逻辑处理，如微信的回复消息
    NSLog(@"%@",response.actionIdentifier);
    
    // 收到了用户返回
    completionHandler();
    
}



- (IBAction)checkAuth:(id)sender {
    
    [XYUserNotificationTool  getAuthorizationStatusWithAuth:^{
        self.authLabel.text = @"用户已经授权推送";
    } denied:^{
        self.authLabel.text = @"用户拒绝授权推送";
    } notDetermind:^{
        self.authLabel.text = @"未请求推送服务，需请求";
    }];
}


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
        self.label2.text = @"添加本地推送成功---";
        
    }];
}


- (IBAction)请求推送权限:(id)sender {
    
    // 请求授权情况
    [XYUserNotificationTool getAuthorizationStatusWithAuth:^{
        // 添加推送
        [self addNotication];
        
        self.authLabel.text = @"当前允许推送授权";
        
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
        
        self.authLabel.text = @"当前未允许推送授权，提示去设置页面";
        
    } notDetermind:^{
        // 请求授权
        self.authLabel.text = @"未授权 - 请求授权";
        [XYUserNotificationTool requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) { // 授权成功
                [self addNotication];
                
                self.label2.text = @"请求授权成功了 --- ";
            }
        }];
    }];
}



@end
