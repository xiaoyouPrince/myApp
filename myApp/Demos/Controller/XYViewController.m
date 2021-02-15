//
//  XYViewController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/14.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYWeakSelf
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    
    [self setContentWithData:[self customData] itemConfig:^(XYInfomationItem * _Nonnull item) {
        item.titleWidthRate = 0.4;
    } sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
        section.separatorHeight = 10;
    } sectionDistance:10 contentEdgeInsets:UIEdgeInsetsZero cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
        UIViewController *vc = [NSClassFromString([cell.model.title stringByAppendingString:cell.model.titleKey]) new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (NSArray *)customData{
    NSArray *section1 = @[
        @{
            @"title": @"",
            @"value": @"以下是本项目展示的 Demo 列表",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"backgroundColor": UIColor.clearColor,
            @"valueColor": UIColor.blueColor
        },
        @{
            @"title": @"XYInfomationSection",
            @"titleKey": @"",
            @"value": @"""简介: ""\n\t一组可自定义的表单组件，致力于快速实现表单、列表、设置等相关功能\n\t本项目中所有相关列表(比如本目录)均基于此构建\
            \n\n此项目基于纯代码实现""",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        }
    ];
    
    UIImage *image = [UIImage imageNamed:@"rightArraw_gray2"];
    NSArray *section2 = @[
        @{
            @"title": @"XYCheckBox",
            @"value": @"一组复选框组件,可以方便实现复选框功能，常用案例为选择某些信息。\n\n支持自定义cell",
            @"titleKey": @"VC",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"职位名称",
            @"titleKey": @"",
            @"value": @"财富规划师",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"员工名称",
            @"titleKey": @"",
            @"value": @"支付宝",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"员工邮箱名称",
            @"titleKey": @"",
            @"value": @"xiaoyouPrince@163.com",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}

@end
