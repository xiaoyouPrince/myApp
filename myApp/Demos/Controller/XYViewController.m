//
//  XYViewController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/14.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYViewController.h"
#import "XYSwitch.h"

@interface XYViewController ()
/** switch */
@property (nonatomic, strong)         XYSwitch * my_switch;
@end

@implementation XYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    
    [self my_switch];
    [self refreshContent];
}

- (void)refreshContent{
    XYWeakSelf
    [self setContentWithData:[self customData] itemConfig:^(XYInfomationItem * _Nonnull item) {
        item.titleWidthRate = 0.7;
        if (![item.valueColor isEqual:UIColor.blueColor]) {// 第一组不处理
            item.type = weakSelf.my_switch.settingValue ? XYInfoCellTypeOther : XYInfoCellTypeChoose;
            if (!weakSelf.my_switch.settingValue) { // chooseType
                item.titleFont = [UIFont boldSystemFontOfSize:20];
                item.titleColor = UIColor.brownColor;
                item.value = @"";
            }
        }
    } sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
        if (section.tag != 0) { // 从第二组开始
            section.separatorHeight = 10;
        }
    } sectionDistance:10 contentEdgeInsets:UIEdgeInsetsZero cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        
        UIViewController *vc = [NSClassFromString(cell.model.titleKey) new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

- (XYSwitch *)my_switch
{
    if (!_my_switch) {
        XYSwitch *my_switch = [XYSwitch new];
        my_switch.settingKey = @"show_detail";
        my_switch.on = my_switch.settingValue;
        XYWeakSelf
        my_switch.valueChangedHandler = ^(BOOL isOn) {
            [weakSelf refreshContent];
        };
        _my_switch = my_switch;
    }
    return _my_switch;
}

- (NSArray *)customData{
    
    NSArray *section1 = @[
        @{
            @"title": @"",
            @"value": @"以下是本项目展示的 Demo 列表",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"backgroundColor": HEXCOLOR(0xf0f0f0),
            @"valueColor": UIColor.blueColor,
        },
        @{
            @"title": @"此开关将展示各组件简介",
            @"value": @" ",
            @"type": @1,
            @"backgroundColor": HEXCOLOR(0xf0f0f0),
            @"valueColor": UIColor.blueColor,
            @"accessoryView": _my_switch
        },
    ];
    
    UIImage *image = [UIImage imageNamed:@"rightArraw_gray2"];
    NSArray *section2 = @[
        @{
            @"title": @"XYInfomationSection",
            @"titleKey": @"",
            @"value": @"""简介: ""\n\t一组可自定义的表单组件，致力于快速实现表单、列表、设置等相关功能\n\t本项目中所有相关列表(比如本目录)均基于此构建\
            \n\n此项目基于纯代码实现""",
            @"type": _my_switch.settingValue ? @3 : @1,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"XYCheckBox",
            @"value": @"一组复选框组件,可以方便实现复选框功能，常用案例为选择某些信息。\n\n支持自定义cell",
            @"titleKey": @"XYCheckBoxVC",
            @"type": _my_switch.settingValue ? @3 : @1,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
        },
        @{
            @"imageName": @"",
            @"title": @"XYStarView",
            @"titleKey": @"XYStarViewController",
            @"value": @"一个星星框组件,常用于展示用户评分功能。\n\n支持自定义cell",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
        },
        @{
            @"imageName": @"",
            @"title": @"XYPickerView",
            @"titleKey": @"XYPickerViewController",
            @"value": @"一个单列表选择器控件，简单易用。可一行代码集成\n\n使用的时候只需要关心数据，内部处理展示与选中相关业务。",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
        },
        @{
            @"imageName": @"",
            @"title": @"XYDatePickerView",
            @"titleKey": @"XYPickerViewController",
            @"value": @"一个日期/时间选择控件，简单易用。可一行代码集成\n\n使用的时候只需要关心业务代码，简洁的 API 设计，如同系统 DatePicker。",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
        },
        @{
            @"imageName": @"",
            @"title": @"XYChooseLocationView",
            @"titleKey": @"XYPickerViewController",
            @"value": @"一个地址选择器控件【亦可用作各种多级选择器】，简单易用。可一行代码集成\n\n使用的时候只需要关心数据，内部处理展示与选中相关业务。",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
        },
        @{
            @"imageName": @"",
            @"title": @"-------------",
            @"titleKey": @"XYPickerViewController",
            @"value": @"一个单列表选择器控件，简单易用\n\n使用的时候只需要关心数据，内部处理展示与选中相关业务。",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"valueCode": @"",
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}

@end
