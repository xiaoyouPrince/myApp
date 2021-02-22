//
//  XYVCController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/22.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYVCController.h"

@interface XYVCController ()

@end

@implementation XYVCController

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
            @"title": @"XYImagePickerController",
            @"value": @"一个基于 UIImagePickerController 的简易图片选择器",
            @"titleKey": @"XYImageDemoController",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"XYTakePhotoController",
            @"value": @"一个基于AVFoundation的自定义拍照工具，用于拍摄身份证、银行卡，自动裁剪图片",
            @"titleKey": @"XYImageDemoController",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"逻辑工具类",
            @"titleKey": @"FileTool\n\nHealthKitTool\n\nConfigTool\n\nPushServiceTool\n\nPinyinTool\n\nHTTPTool",
            @"value": @"FileTool\n\nHealthKitTool\n\nConfigTool\n\nPushServiceTool\n\nPinyinTool\n\nHTTPTool",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}



@end
