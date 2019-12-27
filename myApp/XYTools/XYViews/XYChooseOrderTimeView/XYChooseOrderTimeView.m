//
//  XYChooseOrderTimeView.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/12/26.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import "XYChooseOrderTimeView.h"
#import "Masonry.h"

#define kMaxDay 7
#define KMinMinute 25

@interface XYChooseOrderTimeView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *coverBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *ensureBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIView *contentView;


/** 回调 */
@property (nonatomic, copy)         void(^handler)(NSDateComponents *components);


/** daysArray */
@property (nonatomic, strong)       NSMutableArray * daysArray;
/** hoursArray */
@property (nonatomic, strong)       NSMutableArray <NSString *>* hoursArray;
/** minutesArray */
@property (nonatomic, strong)       NSMutableArray <NSString *>* minutesArray;

/** dataArray */
@property (nonatomic, strong)       NSMutableArray <NSArray *>* dataArray;

@end

@implementation XYChooseOrderTimeView
{
    BOOL specialForMinute;
}

- (NSMutableArray *)dataArray
{
    if (!_daysArray) {
        _dataArray = @[].mutableCopy;
        
        // 天
        [_dataArray addObject:self.daysArray];
        
        // 时
        [_dataArray addObject:self.hoursArray];
        
        // 分
        [_dataArray addObject:self.minutesArray];
    }
    return _dataArray;
}

- (NSMutableArray *)daysArray
{
    if (!_daysArray) {
        
        // 从今天起往后7天
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSMutableArray *arrayM = @[].mutableCopy;
        for (int i = 0; i <= kMaxDay; i++) {
            
            NSDate *date = [NSDate dateWithTimeIntervalSinceNow:i * 24 * 3600 + 60 * KMinMinute];
            if (specialForMinute) {
                date = [date dateByAddingTimeInterval:5 * 60];
            }
            NSInteger currentMonth = [cal component:NSCalendarUnitMonth fromDate:date];
            NSInteger currentDay = [cal component:NSCalendarUnitDay fromDate:date];
            NSInteger currentWeek = [cal component:NSCalendarUnitWeekday fromDate:date];
                        
            if ([cal isDateInToday:date]) {
                [arrayM addObject:[NSString stringWithFormat:@"%zd月%zd日 %@",currentMonth,currentDay,@"今天"]];
            }else
            {
                [arrayM addObject:[NSString stringWithFormat:@"%zd月%zd日 周%@",currentMonth,currentDay,[self hanziForNum:currentWeek]]];
            }
            
        }
        _daysArray = arrayM;
        
    }
    return _daysArray;
}

- (NSString *)hanziForNum:(NSInteger)num
{
    // 中国习惯
    if (num == 1) {
        return @"日";
    }
    if (num == 2) {
        return @"一";
    }
    if (num == 3) {
        return @"二";
    }
    if (num == 4) {
        return @"三";
    }
    if (num == 5) {
        return @"四";
    }
    if (num == 6) {
        return @"五";
    }
    if (num == 7) {
        return @"六";
    }
    
    return nil;
}

- (NSMutableArray *)hoursArray
{
    NSMutableArray *resultArray = @[].mutableCopy;
    NSMutableArray *baseArr = @[].mutableCopy;
    for (int i = 0; i <= 23; i++) {
        [baseArr addObject:[NSString stringWithFormat:@"%2d",i]];
    }
    
    if ([self.picker selectedRowInComponent:0] != 0) {
        resultArray = baseArr;
    }
    
    if ([self.picker selectedRowInComponent:0] == 0) {
        
        // 当前50分钟后
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60 * KMinMinute]; // 50 分钟
        if (specialForMinute) {
            date = [date dateByAddingTimeInterval:5 * 60];
        }
        NSInteger hour = [cal component:NSCalendarUnitHour fromDate:date];

        NSMutableArray *arrayM = @[].mutableCopy;
        for (NSString *str in baseArr) {
            if (str.integerValue >= hour) {
                [arrayM addObject: [NSString stringWithFormat:@"%zd",str.integerValue]];
            }
        }
        resultArray = arrayM;
    }
    
    _hoursArray = resultArray;
    return _hoursArray;
}

- (NSMutableArray *)minutesArray
{
    
    NSMutableArray *resultArray = @[].mutableCopy;
    NSMutableArray *baseArr = @[].mutableCopy;
    for (int i = 0; i <= 55; i += 5) {
        [baseArr addObject:[NSString stringWithFormat:@"%2d",i]];
    }
    
    
    
    if ([self.picker selectedRowInComponent:0] == 0 && [self.picker selectedRowInComponent:1] == 0) {
        
        // 当前50分钟后
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60 * KMinMinute]; // 50 分钟
        if (specialForMinute) {
            date = [date dateByAddingTimeInterval:5 * 60];
        }
        NSInteger minute = [cal component:NSCalendarUnitMinute fromDate:date];

        NSMutableArray *arrayM = @[].mutableCopy;
        for (NSString *str in baseArr) {
            if (str.integerValue >= minute) {
                [arrayM addObject: [NSString stringWithFormat:@"%zd",str.integerValue]];
            }
        }
        resultArray = arrayM;
    }else
    {
        resultArray = baseArr;
    }
    
    _minutesArray = resultArray;
    return _minutesArray;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    /// 规则设置
    /// 当前时间起，往后7天，时间间隔为5分钟
    ///
    /// 展示规则
    /// 共3列 日期(周) 小时 分钟(间隔5m)
    /// end
    
    
    /// @note 额外处理一下，当时间为58分钟情况下，分钟数组没有值的情况
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60 * KMinMinute]; // 50 分钟
    NSInteger minute = [cal component:NSCalendarUnitMinute fromDate:date];
    if (minute > 55) {
        specialForMinute = YES;
    }
    
    self.picker.delegate = self;
    self.picker.dataSource = self;
    [self.picker reloadAllComponents];

}

// 直接调用选择方法即可
+ (void)chooseDateWithHandler:(void(^)(NSDateComponents *components))handler
{
    // 1. 创建对象
    XYChooseOrderTimeView *view = [[NSBundle mainBundle] loadNibNamed:@"XYChooseOrderTimeView" owner:nil options:nil].firstObject;
    
    // 2. 展示对象
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view.superview);
    }];
    
    // 2.1 动画效果
    [UIView animateWithDuration:0.25 animations:^{
        view.coverBtn.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.2];
    }];
    
    // 3. 设置回调
    view.handler = handler;
}


#pragma mark - pickerDategate & dataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) { // 7天
        return self.daysArray.count;
    }

    if (component == 1) { // 24小时(第一天和最后一天单独处理)
        return self.hoursArray.count;
    }

    if (component == 2) { // 每小时有12个时间（5分钟间隔）
        return self.minutesArray.count;
    }
    
    return 0;

}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component API_UNAVAILABLE(tvos)
{
    if (component == 0) {
        return self.contentView.bounds.size.width * (0.5);
    }
    
    return self.contentView.bounds.size.width * (0.25);
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component API_UNAVAILABLE(tvos)
{
    return 44;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component API_UNAVAILABLE(tvos)
{
    if (component == 0) { // 7天
        return self.daysArray[row];
    }

    if (component == 1) { // 24小时
        return [self.hoursArray[row] stringByAppendingString:@"点"];
    }

    if (component == 2) { // 每小时有12个时间（5分钟间隔）
        return [self.minutesArray[row] stringByAppendingFormat:@"分"];
    }
    
    return @"--";

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component API_UNAVAILABLE(tvos)
{
    if (component == 0) {
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }

    if (component == 1) {
        [pickerView reloadComponent:2];
    }
}



#pragma mark - acitons

- (IBAction)colseAction:(id)sender {
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = frame;
        self.coverBtn.backgroundColor = UIColor.clearColor;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (IBAction)ensureAction:(id)sender {
    
    
    // 查看选择内容
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSInteger day = [self.picker selectedRowInComponent:0];
    NSDate *selectedDate = [NSDate dateWithTimeIntervalSinceNow:day * 24 * 3600];
    NSDateComponents *components = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:selectedDate];
    components.calendar = calender;
    
    components.hour = [self.hoursArray[[self.picker selectedRowInComponent:1]] integerValue];
    
    components.minute = [self.minutesArray[[self.picker selectedRowInComponent:2]] integerValue];
    
    if (self.handler) {
        self.handler(components);
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.contentView.frame;
        frame.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = frame;
        self.coverBtn.backgroundColor = UIColor.clearColor;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
