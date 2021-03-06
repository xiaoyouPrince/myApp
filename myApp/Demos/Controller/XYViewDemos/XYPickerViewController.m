//
//  XYPickerViewController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/17.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYPickerViewController.h"
#import "XYPickerView.h"
#import "XYDatePickerView.h"
#import "XYChooseLocationView.h"
#import "DataTool.h"
#import "NSString+Tool.h"

@interface XYPickerViewController ()

@end

@implementation XYPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    XYWeakSelf
    
    [self setContentWithData:[self customData] itemConfig:nil sectionConfig:^(XYInfomationSection * _Nonnull section) {
        section.layer.cornerRadius = 0;
    } sectionDistance:20 contentEdgeInsets:UIEdgeInsetsMake(20, 0, 0, 0) cellClickBlock:^(NSInteger index, XYInfomationCell * _Nonnull cell) {
        // cell 本身点击回调
        [weakSelf sectionCellClicked:cell];
    }];
}

- (void)sectionCellClicked:(XYInfomationCell *)cell{

    if (cell.model.type == XYInfoCellTypeChoose) {
        
        // 处理要请求何种数据picker / datePicker / location
        if ([cell.model.titleKey isEqualToString:@"csrq"] ||
            [cell.model.titleKey isEqualToString:@"nsrpocsrq"] ||
            [cell.model.titleKey isEqualToString:@"sjyrqq"] ||
            [cell.model.titleKey isEqualToString:@"yjbysj"] ||
            [cell.model.titleKey isEqualToString:@"zjsjysj"] ||
            [cell.model.titleKey isEqualToString:@"zlrqq"] ||
            [cell.model.titleKey isEqualToString:@"zlrqz"]
            ) {// 出生日期 & 受教育起止时间等
            [self showDatePickerForCell:cell];
        }else if(
                 [cell.model.titleKey isEqualToString:@"gzcs"] ||
                 [cell.model.titleKey isEqualToString:@"fwdz"]
                 )
        {
            [self showChooseLocationViewForCell:cell];
        }else
        {
            [self showPickerForCell:cell];
        }
    }
}

#pragma mark - XYPickerView 处理

- (void)showPickerForCell:(XYInfomationCell *)cell
{
    [self.view endEditing:YES];
    // 此处可以模拟比较耗时的数据请求,下面直接写到代码中了
    
    [XYPickerView showPickerWithConfig:^(XYPickerView * _Nonnull picker) {
       
        picker.dataArray = [DataTool dataArrayForKey:cell.model.titleKey];
        picker.title = [NSString stringWithFormat:@"请选择%@",cell.model.title];
        
        // 可以自己设置默认选中行
        for (int i = 0; i < picker.dataArray.count; i++) {
            XYPickerViewItem *item = picker.dataArray[i];
            if ([item.title isEqualToString:cell.model.value]) {
                picker.defaultSelectedRow = i;
            }
        }
        
    } result:^(XYPickerViewItem * _Nonnull selectedItem) {
        NSLog(@"选择完成，结果为:%@",selectedItem);
        cell.model.value = selectedItem.title;
        cell.model.valueCode = selectedItem.code;
        cell.model = cell.model;
    }];
}

#pragma mark - XYDatePicker 处理

- (void)showDatePickerForCell:(XYInfomationCell *)cell{
    
    [self.view endEditing:YES];
    
    NSTimeInterval yearSecond = 365 * 24 * 60 * 60;
    [XYDatePickerView showDatePickerWithConfig:^(XYDatePickerView * _Nonnull datePicker) {
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow: -50 * yearSecond];
        datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow: -2 * yearSecond];
        datePicker.title = [@"选择" stringByAppendingString:cell.model.title];

        // 如果已经有选好的时间，默认展示对应的时间
        if ([cell.model.value isDateFromat]) {
            NSDateFormatter *mft = [NSDateFormatter new];
            mft.dateFormat = @"yyyy-MM-dd";
            NSDate *date = [mft dateFromString:cell.model.value];
            datePicker.date = date;
        }

    } result:^(NSDate * _Nonnull choosenDate) {

        NSLog(@"选择完成，结果为:%@",choosenDate);

        NSDateFormatter *mft = [NSDateFormatter new];
        mft.dateFormat = @"yyyy-MM-dd";
        NSString *dateStr = [mft stringFromDate:choosenDate];

        NSLog(@"选择完成，结果为:%@",dateStr);
        cell.model.value = dateStr;
        cell.model.valueCode = dateStr;
        cell.model = cell.model;
    }];
}

#pragma mark - XYChooseLocationView

- (void)showChooseLocationViewForCell:(XYInfomationCell *)cell
{
    [self.view endEditing:YES];
    
    // 一行代码搞定 chooseLocationView。blcok 内可以随便使用 self,不会有循环引用问题
    [XYChooseLocationView instanceAndShowWithConfig:^(XYChooseLocationView * _Nonnull clv) {
        clv.baseDataArray = [DataTool cityArrayForPid:@"0"];
        clv.getNextDataArrayHandler = ^NSArray<XYLocation *> * _Nonnull(XYLocation * _Nonnull cuttentLocation) {
            return [DataTool cityArrayForPid:cuttentLocation.id];
        };
        
        clv.finishChooseBlock = ^(NSArray <XYLocation *>*locations) {
            if (locations.count) {// 有数据处理
                [self hasChooseLocations:locations forCell:cell];
            }
        };
    }];
}

// 内部拿到选择城市数据，具体处理
- (void)hasChooseLocations:(NSArray <XYLocation *>*)locations forCell:(XYInfomationCell *)weakCell
{
    NSLog(@"locations = %@",locations);
    
    NSMutableString *stringM = @"".mutableCopy;
    for (XYLocation *location in locations) {
        if (location == locations.lastObject) {
            [stringM appendFormat:@"%@",location.name];
        }else
        {
            [stringM appendFormat:@"%@,",location.name];
        }
    }
    
    weakCell.model.value = stringM;
    weakCell.model.valueCode = stringM;
    weakCell.model = weakCell.model;
}

#pragma mark - 数据源 构建

- (NSArray *)customData{
    // 0. 子女信息
    NSArray *childInfos = @[
                            @{
                                @"title": @"",
                                @"value": @"子女信息",
                                @"type": @3,
                                @"customCellClass": @"XYItemListCell",
                                @"backgroundColor": self.view.backgroundColor,
                                @"valueColor": UIColor.redColor
                            },
                            @{
                                @"title" : @"子女姓名",
                                @"titleKey" : @"xm",
                                @"type" : @0,
                                @"detail" : @"请输入姓名"
                                },
                            @{
                                @"title" : @"子女证件类型",
                                @"titleKey" : @"sfzjlx",
                                @"type" : @1,
                                @"detail" : @"居民身份证"
                                },
                            @{
                                @"title" : @"子女证件号码",
                                @"titleKey" : @"sfzjhm",
                                @"type" : @0,
                                @"detail" : @"请输入证件号码"
                                },
                            @{
                                @"title" : @"子女出生日期",
                                @"titleKey" : @"csrq",
                                @"type" : @1,
                                @"detail" : @"请选择出生日期"
                                },
                            @{
                                @"title" : @"子女国籍",
                                @"titleKey" : @"gjhdqsz",
                                @"type" : @1,
                                @"detail" : @"中国"
                                },
                            @{
                                @"title" : @"与员工关系",
                                @"titleKey" : @"ynsrgx",
                                @"type" : @1,
                                @"detail" : @""
                                }
                            ];
    // 0. 配偶信息
    NSArray *poInfos = @[
                            @{
                                 @"title": @"",
                                 @"value": @"配偶信息",
                                 @"type": @3,
                                 @"customCellClass": @"XYItemListCell",
                                 @"backgroundColor": self.view.backgroundColor,
                                 @"valueColor": UIColor.redColor
                             },
                            @{
                                @"title" : @"是否有配偶",
                                @"titleKey" : @"sfypo",
                                @"type" : @1,
                                @"detail" : @""
                                },
                            @{
                                @"title" : @"配偶姓名",
                                @"titleKey" : @"nsrpoxm",
                                @"type" : @0,
                                @"detail" : @"请输入姓名"
                                },
                            @{
                                @"title" : @"配偶证件类型",
                                @"titleKey" : @"nsrposfzjlx",
                                @"type" : @1,
                                @"detail" : @"居民身份证"
                                },
                            @{
                                @"title" : @"配偶证件号码",
                                @"titleKey" : @"nsrposfzjhm",
                                @"type" : @0,
                                @"detail" : @"请输入证件号码" // 选择身份证自带出生日期
                                },
                            @{
                                @"title" : @"配偶出生日期",
                                @"titleKey" : @"nsrpocsrq",
                                @"type" : @1,
                                @"detail" : @"请选择出生日期"
                                },
                            @{
                                @"title" : @"配偶国籍",
                                @"titleKey" : @"nsrpogj",
                                @"type" : @1,
                                @"detail" : @"中国"
                                }
                            ];
    // 受教育信息
    NSArray *eduInfos = @[
                        @{
                              @"title": @"",
                              @"value": @"受教育信息",
                              @"type": @3,
                              @"customCellClass": @"XYItemListCell",
                              @"backgroundColor": self.view.backgroundColor,
                              @"valueColor": UIColor.redColor
                          },
                         @{
                             @"title" : @"当前受教育阶段",
                             @"titleKey" : @"sjyjd",
                             @"type" : @1,
                             @"detail" : @"请选择受教育阶段"
                             },
                         @{
                             @"title" : @"当前教育时间起",
                             @"titleKey" : @"sjyrqq",
                             @"type" : @1,
                             @"detail" : @"请选择开始时间"
                             },
                         @{
                             @"title" : @"当前教育时间止",
                             @"titleKey" : @"yjbysj",
                             @"type" : @1,
                             @"detail" : @"选填"
                             },
                         @{
                             @"title" : @"教育终止时间",
                             @"titleKey" : @"zjsjysj",
                             @"type" : @1,
                             @"detail" : @"不再接受教育时填写"
                             },
                         @{
                             @"title" : @"就读国家（地区）",
                             @"titleKey" : @"jdgjhdqsz",
                             @"type" : @1,
                             @"detail" : @"中国"
                             },
                         @{
                             @"title" : @"就读学校名称",
                             @"titleKey" : @"jdxx",
                             @"type" : @0,
                             @"detail" : @""
                             },
                         @{
                             @"title" : @"分配比例",
                             @"titleKey" : @"fpbl",
                             @"type" : @1,
                             @"detail" : @""
                             }
                         ];
    // 租房信息
    NSArray *rentInfos = @[
                        @{
                              @"title": @"",
                              @"value": @"租房信息",
                              @"type": @3,
                              @"customCellClass": @"XYItemListCell",
                              @"backgroundColor": self.view.backgroundColor,
                              @"valueColor": UIColor.redColor
                          },
                          @{
                              @"title" : @"工作城市",
                              @"titleKey" : @"gzcs",
                              @"type" : @1,
                              @"detail" : @"请选择工作城市(省市)"
                              },
                          @{
                              @"title" : @"出租方类型",
                              @"titleKey" : @"czflx",
                              @"type" : @1,
                              @"detail" : @""
                              },
                          @{
                              @"title" : @"出租方名称", // 企业类型 ： 单位名称
                              @"titleKey" : @"czrxm",
                              @"type" : @0,
                              @"detail" : @"选填"
                              },
                          @{
                              @"title" : @"出租方证件类型",
                              @"titleKey" : @"czrsfzjlx",
                              @"type" : @1,
                              @"detail" : @"选填"  // 选填
                              },
                          @{
                              @"title" : @"出租方证件号码", // 企业类型 ： 社会统一信用代码
                              @"titleKey" : @"czrsfzjhm",
                              @"type" : @0,
                              @"detail" : @"选填"
                              },
                          @{
                              @"title" : @"住房租赁合同编号",
                              @"titleKey" : @"zfzlhtbh",
                              @"type" : @0,
                              @"detail" : @"选填"
                              },
                          @{
                              @"title" : @"房屋地址",
                              @"titleKey" : @"fwdz",
                              @"type" : @1,
                              @"detail" : @"请选择省市区"
                              },
                          @{
                              @"title" : @"房屋详细地址",
                              @"titleKey" : @"jzdxxdz",
                              @"type" : @0,
                              @"detail" : @"请输入街道,小区,楼栋,单元室等"
                              },
                          @{
                              @"title" : @"租赁日期起",
                              @"titleKey" : @"zlrqq",
                              @"type" : @1,
                              @"detail" : @"请选择开始时间" // 不可大于系统当前日期
                              },
                          @{
                              @"title" : @"租赁日期止",
                              @"titleKey" : @"zlrqz",
                              @"type" : @1,
                              @"detail" : @"请选择结束时间"  // 不可小于租赁日期起日期
                              }
                          ];
    return @[childInfos, poInfos, eduInfos, rentInfos];
}

@end
