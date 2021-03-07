
//
//  XYSharePresentationController.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/4/23.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYSharePresentationController.h"
//#import "XYShareView.h"


@interface XYSharePresentationController ()

@property(nonatomic,strong) UIView *coverView;
@property(nonatomic , strong) UIView  *shareView;


@end

@implementation XYSharePresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAppNotInstall) name:@"APP Not Install" object:nil];
    return self;
}

- (void)showAppNotInstall{
    // 要退出了
    UIAlertController *av = [UIAlertController alertControllerWithTitle:@"提示"
                                                                message:@"您未安装该App"
                                                         preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [av addAction:action];
    [self.presentedViewController presentViewController:av animated:YES completion:nil];

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIView *)shareView
{
    if (_shareView == nil) {
        _shareView = [UIView xy_viewFromXib];
        _shareView.frame = self.containerView.bounds;
    }
    return _shareView;
}

- (UIView *)coverView;
{
    if (_coverView == nil) {
        
        UIView *coverView = [UIView new];
        _coverView = coverView;
        coverView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopoverView)];
        [coverView addGestureRecognizer:tap];
    }
    
    return _coverView;
}


// 重新布局内部presentVC 和 coverView
- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    
    self.presentedView.frame = self.presentFrame;
    [self.containerView insertSubview:self.coverView atIndex:0];
    self.coverView.frame = self.containerView.bounds;
    
    // 底部shareView
    
    [self.coverView addSubview:self.shareView];
//    self.shareView.shareBlock = ^(NSInteger index) {
//        
//        /// 发送通知，告知分享的类型和方向
//        [kNotificationCenter postNotificationName:@"ShareImageNotificationName" object:@(index)];
//        [weakSelf dismissPopoverView];
//        
//        if (index == 0) { // 取消 直接取消
//            [weakSelf dismissPopoverView];
//        }
//        
//        if (index == 1) { // wechat
//            //[XYAlertView showAlertTitle:@"分享类型" message:@"WeChat" Ok:nil cancel:nil];
//            
//            if (weakSelf.shareView.shareImage) {
//                [WeachtManger shareImage:HLPlatformType_WechatSession image:weakSelf.shareView.shareImage];
//            }
//            
//            DLog(@"wechat----好友");
//        }
//        
//        if (index == 2) { // 朋友圈
//            //[XYAlertView showAlertTitle:@"分享类型" message:@"朋友圈" Ok:nil cancel:nil];
//            
//            if (weakSelf.shareView.shareImage) {
//                [WeachtManger shareImage:HLPlatformType_WechatTimeLine image:weakSelf.shareView.shareImage];
//            }
//            
//             DLog(@"wechat----朋友圈");
//        }
//        if (index == 3) { // qq
//            //[XYAlertView showAlertTitle:@"分享类型" message:@"QQ" Ok:nil cancel:nil];
//            if (weakSelf.shareView.shareImage) {
//                [WeachtManger shareImage:HLPlatformType_QQ image:weakSelf.shareView.shareImage];
//            }
//             DLog(@"qq-----");
//        }
//    };
}

#pragma mark -- 蒙版点击,dismiss

- (void)dismissPopoverView
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}


@end

