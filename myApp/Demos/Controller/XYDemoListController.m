//
//  XYDemoListController.m
//  myApp
//
//  Created by 渠晓友 on 2020/5/20.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "XYDemoListController.h"

// 有一个bug，就是自己的 bgColor 不能有透明通道。

@interface XYDemoListController ()

@end

@implementation XYDemoListController

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UIView *the_bottom_view = self.scrollView.subviews.firstObject.subviews.lastObject;
    CGFloat max_y = CGRectGetMaxY(the_bottom_view.frame);
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    if (max_y < scrollViewH) {
        self.scrollView.contentSize = CGSizeMake(0, max_y);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = XYGrayColor(246);
    self.title = @"DEMO";
    
    XYInfomationItem *item = [XYInfomationItem modelWithTitle:@"健康App" titleKey:@"XYHealthViewController" type:XYInfoCellTypeChoose value:@"展示请求步数数据" placeholderValue:@"" disableUserAction:YES];
    
    XYInfomationItem *item2 = [XYInfomationItem modelWithTitle:@"推送权限" titleKey:@"XYHealthViewController" type:XYInfoCellTypeChoose value:@"展示需要推送权限" placeholderValue:@"" disableUserAction:YES];
    
    

    XYInfomationSection *section = [XYInfomationSection new];
    section.dataArray = @[item,item2];

    [self setHeaderView:section edgeInsets:UIEdgeInsetsMake(15, 15, 0, 15)];
    
    section.cellClickBlock = ^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        Class clz = NSClassFromString(cell.model.titleKey);
        UIViewController *vc = [clz new];
        [self.navigationController pushViewController:vc animated:YES];
    };
}



@end
