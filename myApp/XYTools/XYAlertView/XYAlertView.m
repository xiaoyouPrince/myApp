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

/// 只是一个通知类型的alert
+ (void)showAlertOnVC:(UIViewController *)currentVC
                title:(NSString *)title
              message:(NSString *)message
              okTitle:(NSString *)okTitle
                   Ok:(void (^)(void))OK{
    
    UIAlertController *av = [UIAlertController alertControllerWithTitle:title
                                                                message:message
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:okTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // 确定
                                                         if (OK) {
                                                             OK();
                                                         }
                                                     }];
    [av addAction:actionOK];
    [currentVC presentViewController:av animated:YES completion:nil];
}

/// 两个选择的alert <OK/Cancel>
+ (void)showAlertOnVC:(UIViewController *)currentVC
                title:(NSString *)title
              message:(NSString *)message
              okTitle:(NSString *)okTitle
             okAction:(void (^)(void))okAction
          cancelTitle:(NSString *)cancelTitle
         cancelAction:(void (^)(void))cancelAction{
    
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
    [currentVC presentViewController:av animated:YES completion:nil];
}

#pragma mark - showSheet
/// 可以设置多个action
+ (void)showSheetOnVC:(UIViewController *)currentVC
                title:(NSString *)title
              message:(NSString *)message
              actions:(NSArray<XYAlertAction *>*)actions
        actionHandler:(void (^)(NSInteger index))handler{
    
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
    
    [currentVC presentViewController:av animated:YES completion:nil];
}


@end
