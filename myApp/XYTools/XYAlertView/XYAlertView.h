//
//  XYAlertView.h
//  MyMapDemo
//
//  Created by 渠晓友 on 2018/2/1.
//  Copyright © 2018年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYAlertAction : NSObject
/** title */
@property (nonatomic, copy)         NSString * title;
/** value */
@property (nonatomic, copy)         NSString * value;
+ (instancetype)modelWithTitle:(NSString *)title value:(NSString *)value;
@end

@interface XYAlertView : NSObject

#pragma mark - showAlert

/// 只是一个通知类型的alert
+ (void)showAlertOnVC:(UIViewController *)currentVC
                title:(NSString *)title
              message:(NSString *)message
              okTitle:(NSString *)okTitle
                   Ok:(void (^)(void))OK;

/// 两个选择的alert <OK/Cancel>
+ (void)showAlertOnVC:(UIViewController *)currentVC
                title:(NSString *)title
              message:(NSString *)message
              okTitle:(NSString *)okTitle
             okAction:(void (^)(void))okAction
          cancelTitle:(NSString *)cancelTitle
         cancelAction:(void (^)(void))cancelAction;

#pragma mark - showSheet
/// 可以设置多个action
+ (void)showSheetOnVC:(UIViewController *)currentVC
                title:(NSString *)title
              message:(NSString *)message
              actions:(NSArray<XYAlertAction *>*)actions
        actionHandler:(void (^)(NSInteger index))handler;


@end
