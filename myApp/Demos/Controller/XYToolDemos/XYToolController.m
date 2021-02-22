//
//  XYToolController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/22.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYToolController.h"

@interface XYToolController ()

@end

@implementation XYToolController

- (void (^)(NSInteger, XYInfomationCell * _Nonnull))customCellClickCallBcak{
    return ^(NSInteger index, XYInfomationCell * _Nonnull cell){
        UIViewController *vc = [NSClassFromString(cell.model.titleKey) new];
        vc.title = cell.model.title;
        if ([cell.model.placeholderValue length]) {
            [vc setValue:cell.model.placeholderValue forKey:@"urlString"];
        }
        [self.navigationController pushViewController:vc animated:YES];
    };
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
        }
    ];
    NSArray *section2 = @[
        @{
            @"title": @"健康App",
            @"value": @"展示请求步数数据\n\n一行代码导入获取健康App，用户步数权限。方便实现类似微信步数排名功能。",
            @"titleKey": @"XYHealthViewController",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"推送权限",
            @"value": @"展示需要推送权限",
            @"titleKey": @"XYPushViewController",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"KVO",
            @"titleKey": @"WebViewController",
            @"value": @"KVO 实现原理",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
            @"placeholderValue": @"https://www.jianshu.com/p/b6671bd841ce"
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}

@end
