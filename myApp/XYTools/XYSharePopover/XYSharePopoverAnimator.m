
//
//  XYSharePopoverAnimator.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/4/23.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYSharePopoverAnimator.h"
#import "XYSharePresentationController.h"

@interface XYSharePopoverAnimator() <UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@end

@implementation XYSharePopoverAnimator

- (instancetype)initWithCallBack:(callBack)callback
{
    self = [super init];
    self.callback = callback;
    return self;
}

#pragma -- mark 自定义转场动画

// 展出动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.present = YES;
    return self;
}


// 隐藏动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.present = NO;
    if (self.callback) {
        self.callback(self.isPresent);
    }
    
    return self;
}

// 自定义弹出VC
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    
    XYSharePresentationController *presentVC = [[XYSharePresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    
    if (self.presentFrame.size.width){
        presentVC.presentFrame = self.presentFrame;
    }else{
        CGFloat screenW = UIScreen.mainScreen.bounds.size.width;
        presentVC.presentFrame = CGRectMake(screenW - 155, 64, 140, 120);
    }
    
    
    return presentVC;
}


#pragma -- mark 自定义弹出和消失动画


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.isPresent ? [self animationForPresent:transitionContext] : [self animationForDismiss:transitionContext];
}

// 自定义弹出动画
- (void)animationForPresent:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 得到要展示的View，并添加到ContainerView中
    UIView *presentView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    [transitionContext.containerView addSubview:presentView];
    
    // 执行对应动画
    presentView.transform = CGAffineTransformMakeScale(1.0, 0.0);
    presentView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        presentView.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        // 必须告诉转场上下文你已经完成动画
        [transitionContext completeTransition:YES];
    }];
    
    
}

// 自定义消失动画
- (void)animationForDismiss:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    // 得到要展示的View，并添加到ContainerView中
    UIView *presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    [transitionContext.containerView addSubview:presentView];
    
    // 执行对应动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        presentView.transform = CGAffineTransformMakeScale(1.0, 0.0001);
    } completion:^(BOOL finished) {
        
        // 移除View并告诉上下文已经完成动画
        [presentView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
    
}

@end
