
//
//  XYSharePopoverAnimator.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/4/23.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^callBack)(BOOL);
@interface XYSharePopoverAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign , getter=isPresent) BOOL present;
@property(nonatomic , copy) callBack callback;

@property(nonatomic , assign) CGRect presentFrame; ///< 定制popover弹出的farme

- (instancetype)initWithCallBack:(callBack)callback;

@end
