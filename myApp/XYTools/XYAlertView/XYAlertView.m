//
//  XYAlertView.m
//  MyMapDemo
//
//  Created by 渠晓友 on 2018/2/1.
//  Copyright © 2018年 XiaoYou. All rights reserved.
//

#import "XYAlertView.h"

@implementation XYAlertAction
+ (instancetype)modelWithTitle:(NSString *)title value:(NSString *)value
{
    XYAlertAction *action = [XYAlertAction new];
    action.title = title;
    action.value = value;
    return action;
}
@end

@implementation XYAlertView

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message Ok:(void (^)(void))OK
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"我知道了"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // 确定
                                                         if (OK) {
                                                             OK();
                                                         }
                                                         
                                                     }];
    [av addAction:actionOK];
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVc;
        [nav.topViewController presentViewController:av animated:YES completion:nil];
    }else{
       [currentVc presentViewController:av animated:YES completion:nil];
    }
    
}

+ (void)showAlertTitle:(NSString *)title message:(NSString *)message Ok:(void (^)(void))OK cancel:(void (^)(void))cancel
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"好的"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                        // 确定
                                                         if (OK) {
                                                            OK();
                                                         }
                                                         
                                                     }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // cancel
                                                             if (cancel) {
                                                                 cancel();
                                                             }
                                                        
                                                         }];
    [av addAction:actionOK];
    [av addAction:actionCancel];
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVc;
        [nav.topViewController presentViewController:av animated:YES completion:nil];
    }else{
        [currentVc presentViewController:av animated:YES completion:nil];
    }
    
}


+ (void)showAlertTitle:(NSString *)title message:(NSString *)message okTitle:(NSString *)okTitle okAction:(void (^)(void))okAction cancelTitle:(NSString *)cancelTitle cancelAction:(void (^)(void))cancelAction
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:okTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // 确定
                                                         if (okAction) {
                                                             okAction();
                                                         }
                                                         
                                                     }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:cancelTitle
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // cancel
                                                             if (cancelAction) {
                                                                 cancelAction();
                                                             }
                                                             
                                                         }];
    [av addAction:actionOK];
    [av addAction:actionCancel];
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVc;
        [nav.topViewController presentViewController:av animated:YES completion:nil];
    }else{
        [currentVc presentViewController:av animated:YES completion:nil];
    }
}



+ (void)showSheetTitle:(NSString *)title message:(NSString *)message actions:(NSArray<XYAlertAction *> *)actions actionHandler:(void (^)(NSInteger))handler
{
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
           message:message
    preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction * __strong uiaction = nil;
    NSInteger index = -1;
    for (XYAlertAction *action in actions) {
        index ++;
        uiaction = [UIAlertAction actionWithTitle:action.title
          style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * _Nonnull action) {
            // 确定
            if (handler) {
                handler(index);
            }
        }];
        
        [av addAction:uiaction];
    }
    
    UIViewController *currentVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([currentVc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)currentVc;
        [nav.topViewController presentViewController:av animated:YES completion:nil];
    }else{
        [currentVc presentViewController:av animated:YES completion:nil];
    }
}


@end
