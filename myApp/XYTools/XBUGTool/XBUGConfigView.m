//
//  XBUGConfigView.m
//  XBUG
//
//  Created by 渠晓友 on 2019/4/23.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

#import "XBUGConfigView.h"
#import "XBUGTool.h"

@interface XBUGConfigView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *phoneSMSBtn;
@property (weak, nonatomic) IBOutlet UIButton *accountPWDBtn;
@property (weak, nonatomic) IBOutlet UITextField *projUrlTF;
@property (weak, nonatomic) IBOutlet UITextField *bookcarUrlTF;

@end

@implementation XBUGConfigView
{
    UIButton *_selectedBtn; // 默认的被选中的按钮
    XBUGConfigView *_instance; // 实体
}

+ (void)show
{
    XBUGConfigView *instance = [[NSBundle mainBundle] loadNibNamed:@"XBUGConfigView" owner:nil options:nil].firstObject;
    [instance show];
}

- (void)show{
    
    _instance = self;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _instance.frame = keyWindow.bounds;
    [keyWindow addSubview:_instance];
}

- (void)dismiss{
    
    [_instance removeFromSuperview];
    _instance = nil;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.phoneSMSBtn addTarget:self action:@selector(chooseLoginMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.accountPWDBtn addTarget:self action:@selector(chooseLoginMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    // 默认选中账号密码登录
    [self chooseLoginMethod:self.accountPWDBtn];
    
    // 展示默认地址
    self.projUrlTF.text = xBUGProjUrl;
    self.bookcarUrlTF.text = xBUGBookCarURL;
    self.projUrlTF.delegate = self;
    self.bookcarUrlTF.delegate = self;
}


#pragma mark - UITextViewDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 1. 加载默认可选项
    
    if (textField == self.projUrlTF) { // 项目根地址
        
        XYAlertAction *action = [XYAlertAction modelWithTitle:@"https://api2.fescotech.com/appserver" value:nil];
        XYAlertAction *action1 = [XYAlertAction modelWithTitle:@"http://47.93.126.37/appserver" value:nil];
        NSArray *array = @[action,action1];
//        [XYAlertView showSheetTitle:@"选择项目地址" message:nil actions:array actionHandler:^(NSInteger index) {
//            XYAlertAction *action = array[index];
//
//            textField.text = action.title;
//        }];
    }
    
    if (textField == self.bookcarUrlTF) { // 子项目根地址
        
        XYAlertAction *action = [XYAlertAction modelWithTitle:@"https://api2.fescotech.com" value:nil];
        XYAlertAction *action1 = [XYAlertAction modelWithTitle:@"http://47.93.126.37" value:nil];
        XYAlertAction *action2 = [XYAlertAction modelWithTitle:@"http://10.0.84.222" value:nil];
        NSArray *array = @[action,action1,action2];
//        [XYAlertView showSheetTitle:@"选择首汽地址" message:nil actions:array actionHandler:^(NSInteger index) {
//            XYAlertAction *action = array[index];
//            
//            textField.text = action.title;
//        }];
    }
    
    return NO;
}



#pragma mark - actions


- (void)chooseLoginMethod:(UIButton *)sender
{
    
    if (sender.selected) {
        return;
    }
    
    _selectedBtn.selected = NO;
    sender.selected = YES;
    _selectedBtn = sender;
}


- (IBAction)saveAction:(id)sender {
    
    // xbug 环境 、 LoginMethod 、 projURL 、 bookcarURL
    [XBUGTool setXBUG];
    
    if (_selectedBtn == self.phoneSMSBtn) {
        [XBUGTool setLoginMethod:LoginMethodPhoneSMS];
    }
    if (_selectedBtn == self.accountPWDBtn) {
        [XBUGTool setLoginMethod:LoginMethodAccount];
    }
    
    if (self.projUrlTF.text) {
        [XBUGTool setProjectRootURL:self.projUrlTF.text];
    }
    
    if (self.bookcarUrlTF.text) {
        [XBUGTool setShouQiProjectRootURL:self.bookcarUrlTF.text];
    }
    
    // 退出
    [self dismiss];
    
    // 修改配置，重新登录
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RE_LOGIN_NOTI" object:nil];
}


- (IBAction)cancelAction:(id)sender {
    
    // 移除 xbug 环境
    [XBUGTool resignXBUG];
    
    // 退出
    [self dismiss];
}



@end
