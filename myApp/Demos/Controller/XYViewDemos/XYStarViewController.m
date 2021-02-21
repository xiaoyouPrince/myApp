//
//  XYStarViewController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/16.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYStarViewController.h"
#import "XYStarView.h"

@interface XYStarViewController ()

@end

@implementation XYStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xfafafa);
    
    // starView 创建完成后会自动更新自己 size
    
    [self setContentWithData:[self customData] itemConfig:nil sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
        section.separatorHeight = 10;
    } sectionDistance:10 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        // cell 本身点击回调
    }];

}

- (UIView *)showContentWithStar:(NSInteger)count
                  selectedCount:(NSInteger)selectCount
                     userAction:(BOOL)allowUserAction
                           size:(NSInteger)size
                         margin:(NSInteger)margin
                      imageName:(NSString *)imageName
{
    XYStarView *starView = [XYStarView starViewWithConfig:^(XYStarView *starView) {
        starView.allowUserAction = allowUserAction;
        starView.starCount = count;
        starView.selectedStarCount = selectCount;
        starView.starWH = size;
        starView.starMargin = margin;
        starView.starImageName = imageName;
        __weak typeof(XYStarView *) weakStar = starView;
        starView.starTapHandler = ^(NSInteger starCount) {
            XYInfomationCell *cell = (XYInfomationCell *)weakStar.superview.superview;
            cell.model.value = [NSString stringWithFormat:cell.model.placeholderValue,starCount];
            cell.model = cell.model;
        };
    }];
    starView.frame = CGRectMake(20, 150, starView.frame.size.width, starView.frame.size.height);
    return  starView;
}

- (NSArray *)customData{
    NSArray *section1 = @[
        @{
            @"title": @"默认 starView",
            @"value": @"只能看当前状态,不可点击. 【当前选择的数量为:2】",
            @"placeholderValue": @"只能看当前状态,不可点击. 【当前选择的数量为:%d】",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"accessoryView": [self showContentWithStar:5 selectedCount:2 userAction:NO size:34 margin:22 imageName:@""],
        },
        @{
            @"title": @"默认 starView",
            @"value": @"只能看当前状态,可点击. 【当前选择的数量为:0】",
            @"placeholderValue": @"只能看当前状态,可点击. 【当前选择的数量为:%d】",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"accessoryView": [self showContentWithStar:5 selectedCount:0 userAction:YES size:34 margin:22 imageName:@""],
        },
        @{
            @"title": @"自定义星星图标 starView",
            @"value": @"只能看当前状态,可点击. 【当前选择的数量为:2】",
            @"placeholderValue": @"只能看当前状态,可点击. 【当前选择的数量为:%d】",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"accessoryView": [self showContentWithStar:5 selectedCount:2 userAction:YES size:50 margin:20 imageName:@"my_star"],
        },
        @{
            @"title": @"自定义星星图标、尺寸 starView",
            @"value": @"只能看当前状态,可点击. 【当前选择的数量为:2】",
            @"placeholderValue": @"只能看当前状态,可点击. 【当前选择的数量为:%d】",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"accessoryView": [self showContentWithStar:5 selectedCount:2 userAction:YES size:20 margin:5 imageName:@"my_star"],
        }
    ];
    
    NSArray *array = @[section1];
    return array;
}

@end



