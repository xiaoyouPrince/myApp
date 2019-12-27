//
//  XYPopoverViewController.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/24.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

#import "XYPopoverViewController.h"

NSNotificationName PopoviewUpdateStatusNotification = @"PopoverUpdateStatusNotification";

@interface XYPopoverViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIImageView *alertBgIV;

@end

@implementation XYPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImage *originImage = [UIImage imageNamed:@"alertBg"];
    //拉伸后的图片
    CGFloat width = originImage.size.width / 8.0;
    CGFloat height = originImage.size.height / 8.0;
    UIImage *newImage = [originImage resizableImageWithCapInsets:UIEdgeInsetsMake(height * 7,width,height,width * 7) resizingMode:UIImageResizingModeStretch];//取正中间一个点，拉伸方式
    self.alertBgIV.image = newImage;
    
    // 初次设置两个按钮样式
    [self setupBtnEnable];
    
    
    // 添加通知，监听当前订单状态
    [kNotificationCenter addObserver:self selector:@selector(updateStatusNoty:) name:PopoviewUpdateStatusNotification object:nil];
    
}

- (void)updateStatusNoty:(NSNotification *)noty{
    
    // 状态码
    NSNumber * statusNumber = noty.object;
    
    if (statusNumber.integerValue >= 6) {   // 6 BookCarStatusComplete
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    // 根据状态码修改对应状态
    self.shareBenEnable = statusNumber.integerValue >= 3 ?  YES : NO; // 3 BookCarStatusCarComing
    self.cancelBenEnable = statusNumber.integerValue < 5 ?  YES : NO; // 5 BookCarStatusGetInCar
    
    // 重新设置自己的按钮状态
    self.cancelBtn.enabled = self.cancelBenEnable;
    self.shareBtn.enabled = self.shareBenEnable;
}

- (void)setupBtnEnable{
    
    if (self.cancelBenEnable == YES) {
        self.cancelBtn.enabled = self.cancelBenEnable;
    }
    
    if (self.shareBenEnable == YES) {
        self.shareBtn.enabled = self.shareBenEnable;
    }
}

- (IBAction)shareBtnClick:(id)sender {
    
    if (self.callback) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.callback(0);
    }
    
}


- (IBAction)cancelBtnClick:(id)sender {
    if (self.callback) {
        self.callback(1);
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [kNotificationCenter removeObserver:self name:PopoviewUpdateStatusNotification object:nil];
}

@end
