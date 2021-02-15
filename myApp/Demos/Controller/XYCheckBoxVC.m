//
//  XYCheckBoxVC.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/15.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYCheckBoxVC.h"
#import "XYCheckBox.h"

@interface XYCheckBoxVC ()
/** XYCheckBox */
@property (nonatomic, weak)         XYCheckBox * cb;
@end

@implementation XYCheckBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    
    NSMutableArray *arrayM = @[].mutableCopy;
    for (int i = 0; i < 10; i++) {
        XYCheckBoxItem *item = [XYCheckBoxItem new];
        item.title = [NSString stringWithFormat:@"周%d",i];
        item.code = [NSString stringWithFormat:@"%d",i];
        [arrayM addObject:item];
    }
    
    XYCheckBox *cb = [XYCheckBox new];
    
    // 创建 header View
    UILabel *dateLabel = [[UILabel alloc] init];
    [dateLabel xy_setText:@"计划出行日期" font:[UIFont boldSystemFontOfSize:12] textColor:UIColor.blackColor];
    
    // 手动设置 header 高度 - 内部优先采用 高度 height 值
//    [dateLabel sizeToFit];
    
    // autolayout 设置 header 高度
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
    }];
    
    cb.headerView = dateLabel;
    cb.dataArray = arrayM;//@[item,item1,item2,item3];
    cb.isMutex = NO;
    cb.allowCancelSelected = YES;
    [self.view addSubview:cb];
    
//    cb.frame = CGRectMake(25, 150, ScreenW -50, 200);
    cb.backgroundColor = UIColor.greenColor;
    
//    [cb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(150);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//
//        // 直接不设置高度，其高度会自适应
//
//        // 下面两种设置 checkBox 高度方法，会设置 checkBox 高度，其内容高度自适应
////        make.bottom.equalTo(self.view).offset(-23);
////        make.height.equalTo(@(dateLabel.xy_height + cb.dataArray.count * 50));
//    }];
    
    self.cb = cb;
    
    
    [self setHeaderView:cb edgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"选中内容为 %@", self.cb.allSelectedItems);
}

@end

// todo
// cb 抽取一个更好用的基本构造方法
// 整理使用手册
