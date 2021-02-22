#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    XYWeakSelf
    [self setContentWithData:[self customData] itemConfig:^(XYInfomationItem * _Nonnull item) {
        item.titleWidthRate = 0.7;
    } sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
        if (section.tag != 0) { // 从第二组开始
            section.separatorHeight = 10;
        }
    } sectionDistance:10 contentEdgeInsets:UIEdgeInsetsZero cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        if (weakSelf.customCellClickCallBcak) {
            weakSelf.customCellClickCallBcak(index, cell);
        }else{
            UIViewController *vc = [NSClassFromString(cell.model.titleKey) new];
            vc.title = cell.model.title;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
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
            @"title": @"Controller 工具(控制器)",
            @"value": @"拍照\n\n拍摄身份证照片\n\n导航控制器",
            @"titleKey": @"XYVCController",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"视图工具类",
            @"value": @"XYInfomationSection\n\nXYCheckBox\n\nXYStarView\n\nXYPickerView\n\nXYDatePickerView\n\nXYChooseLocationView\n\nXYSwitch",
            @"titleKey": @"XYViewController",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"逻辑工具类",
            @"titleKey": @"FileTool\n\nHealthKitTool\n\nConfigTool\n\nPushServiceTool\n\nPinyinTool\n\nHTTPTool",
            @"value": @"FileTool\n\nHealthKitTool\n\nConfigTool\n\nPushServiceTool\n\nPinyinTool\n\nHTTPTool",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"系统分类，增强系统功能",
            @"titleKey": @"XYPickerViewController",
            @"value": @"",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        },
        @{
            @"title": @"组件工具",
            @"titleKey": @"",
            @"value": @"后续计划独立成组件的工具。\n\nXYInfomationSection",
            @"type": @3,
            @"customCellClass": @"XYItemListCell",
        }
    ];
    
    NSArray *array = @[section1,section2];
    return array;
}

@end
