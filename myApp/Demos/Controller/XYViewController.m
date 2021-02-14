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
    
    self.view.backgroundColor = HEXCOLOR(0xfafafa);
    
    [self setContentWithData:[self customData] itemConfig:nil sectionConfig:nil sectionDistance:10 contentEdgeInsets:UIEdgeInsetsZero cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
    }];
}

- (NSArray *)customData{
    NSArray *section1 = @[
        @{
            @"imageName": @"grade",
            @"title": @"更换头像",
            @"titleKey": @"",
            @"value": @"",
            @"type": @1,
            @"customCellClass": @"SectionDemo.PersonInfoHeaderCell",
            @"cellHeight": @250,
            @"valueCode": @"",
        }
    ];
    
    UIImage *image = [UIImage imageNamed:@"rightArraw_gray2"];
    NSArray *section2 = @[
        @{
            @"imageName": @"",
            @"title": @"企业名称",
            @"titleKey": @"",
            @"value": @"蚂蚁金服有限公司",
            @"type": @1,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @120,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"职位名称",
            @"titleKey": @"",
            @"value": @"财富规划师",
            @"type": @1,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @120,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"员工名称",
            @"titleKey": @"",
            @"value": @"支付宝",
            @"type": @1,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @120,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"员工邮箱名称",
            @"titleKey": @"",
            @"value": @"xiaoyouPrince@163.com",
            @"type": @1,
            @"customCellClass": @"SectionDemo.PersonInfoCell",
            @"cellHeight": @120,
            @"valueCode": @"",
            @"accessoryView": [[UIImageView alloc] initWithImage:image]
        },
        @{
            @"imageName": @"",
            @"title": @"选择您的身份",
            @"titleKey": @"CommonViewController",
            @"value": @"HR",
            @"type": @1,
            @"customCellClass": @"SectionDemo.PersonInfoDutyCell",
            @"cellHeight": @170,
            @"valueCode": @""
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}

@end
