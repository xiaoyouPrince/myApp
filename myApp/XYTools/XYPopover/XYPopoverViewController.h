//
//  XYPopoverViewController.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/24.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSNotificationName PopoviewUpdateStatusNotification;

typedef void(^PopoverChooserCallBack)(NSUInteger index);

@interface XYPopoverViewController : UIViewController

@property(nonatomic , copy) PopoverChooserCallBack callback;
@property(nonatomic , assign) BOOL shareBenEnable;   /// 用户设置是否可以分享行程
@property(nonatomic , assign) BOOL cancelBenEnable;  /// 用户设置是否可以取消行程

@end
