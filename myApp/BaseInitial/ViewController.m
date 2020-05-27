//
//  ViewController.m
//  myApp
//
//  Created by 渠晓友 on 2019/11/17.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XYAlertView.h"
#import "XYKit.h"
#import "XYDemoListController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    AFHTTPResponseSerializer *responsSer = [AFHTTPResponseSerializer serializer];
//    responsSer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    mgr.responseSerializer = responsSer;
//
//
//    [mgr GET:@"http://10.0.84.95" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
//
//        debugLog(@"responseObject = %@",responseObject);
//
//        debugLog(@"dict = %@",dict);
//
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        debugLog(@"error = %@",error);
//    }];
    
    
    
//    UIImage *image = [[UIImage imageNamed:@"wk_backIcon"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIButton *backBtn = [[UIButton alloc] init];
//    [backBtn setImage:image forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    UIView *cusBack = [UIView new];
//    cusBack.backgroundColor = UIColor.redColor;
//    [cusBack addSubview:backBtn];
//    cusBack.frame = CGRectMake(0, 0, 30, 44);
//    backBtn.frame = cusBack.bounds;
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cusBack];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [btn setTitle:@"关闭" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
//    [btn sizeToFit];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    UIEdgeInsets inset = UIEdgeInsetsMake(-20, 10, 0, 0);
    UIEdgeInsets inset2 = UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(backAction) nomalImage:[UIImage imageNamed:@"left"] higeLightedImage:[UIImage imageNamed:@"down"] imageEdgeInsets:inset];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(closeAction) nomalImage:[UIImage imageNamed:@"down"] higeLightedImage:[UIImage imageNamed:@"right"] imageEdgeInsets:inset2];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(closeAction) title:@"你好" font:[UIFont systemFontOfSize:15] titleColor:UIColor.redColor highlightedColor:UIColor.greenColor titleEdgeInsets:UIEdgeInsetsZero];
    
    
    
    
    
    
    
}

- (void)backAction{
    XYFunc
    
    
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"wbenefit.fesco.com.cn://"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"wxser.fesco.com.cn://"]];
    
    
}

- (void)closeAction{
    XYFunc
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

//    [XYAlertView showAlertOnVC:self
//                         title:@"提示"
//                       message:@"目前是一个空项目，请等待"
//                       okTitle:@"好的"
//                            Ok:nil];
    
    
    XYDemoListController *detail = [XYDemoListController new];
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
