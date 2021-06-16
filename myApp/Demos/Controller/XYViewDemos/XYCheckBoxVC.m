//
//  XYCheckBoxVC.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/15.
//  Copyright © 2021 渠晓友. All rights reserved.
//

// XYCheckBox 会根据自适应计算出高度。推荐使用自动布局

#import "XYCheckBoxVC.h"
#import "XYCheckBox.h"

@interface XYCheckBoxVC ()
/** XYCheckBox */
@property (nonatomic, strong)         XYCheckBox * cb;
/** XYCheckBox */
@property (nonatomic, strong)         XYCheckBox * cb1;
/** XYCheckBox */
@property (nonatomic, strong)         XYCheckBox * cb2;
@end

@implementation XYCheckBoxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEXCOLOR(0xf0f0f0);
    
    [self cbDemo1];
    [self cbDemo2];
    [self cbDemo3];
}

- (void)cbDemo1{
    
    // 数据源
    NSArray *arrayM = [self dateArrayWithTitle:@"周" count:7];
    // header View
    UIView *headerView = [self headerWithTitle:@"   选择重复周期(仿写叮咚App选择运动提醒页面)" height:40];
    headerView.backgroundColor = HEXCOLOR(0xf0f0f0);
    
    XYCheckBox *cb = [XYCheckBox new];
    cb.headerView = headerView;
    cb.dataArray = arrayM;//@[item,item1,item2,item3];
    cb.isMutex = NO;
    cb.allowCancelSelected = YES;
    cb.backgroundColor = UIColor.whiteColor;
    
    self.cb = cb;
    
    // 由于内部采用自动布局，针对 cb 设置 frame 会失效
    // cb.frame = CGRectMake(25, 150, ScreenW -50, 200);
    
    // 使用自动布局 - 先添加到view上
//    [self.view addSubview:cb];
//    [cb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(150);
//        make.left.equalTo(self.view).offset(15);
//        make.right.equalTo(self.view).offset(-15);
//
//        // 不需要设置高度，其高度会自适应内容
//        // 若手动设置 checkBox 高度，也只会设置其本身高度，内容会自适应自己高度
//    }];
    
    // 此类使用基类方法，直接设置内容，如果使用者是放到自己View直接使用 autolayout 设置布局即可: 如上
    [self setHeaderView:cb edgeInsets:UIEdgeInsetsMake(20, 0, 0, 0)];
}

- (void)cbDemo2{
    
    // 数据源
    NSArray *arrayM = [self dateArrayWithTitle:@"周计划出行日期计划出行日期计划出行日期计划出行日期/Users/quxiaoyou/Documents/GitHub/myApp/myApp/Demos/Controller/XYCheckBoxVC.m计划出行日期" count:7];
    // header View
    UIView *headerView = [self headerWithTitle:@"计划出行日期" height:40];
    headerView.backgroundColor = XYRandomColor;
    // cb
    XYCheckBox *cb = [XYCheckBox checkBoxWithHeaderView:headerView dataArray:arrayM isMutex:NO allowCancelSelected:YES itemSelectedHandler:^(XYCheckBoxItem * _Nonnull item) {
        NSLog(@"当前选中的 item %@",item);
    }];
    cb.backgroundColor = XYRandomColor;
    self.cb1 = cb;
    
    // 布局
    [self setContentView:cb edgeInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
}

- (void)cbDemo3{
    
    // 数据源
    NSArray *arrayM = [self dateArrayWithTitle:@"周" count:7];
    
    // header View
    UIView *headerView = [self headerWithTitle:@"计划出行日期" height:40];
    headerView = nil;
    
    XYCheckBox *cb = [XYCheckBox checkBoxWithHeaderView:headerView dataArray:arrayM isMutex:NO allowCancelSelected:YES itemSelectedHandler:^(XYCheckBoxItem * _Nonnull item) {
        NSLog(@"当前选中的 item %@",item);
    }];
    cb.backgroundColor = XYRandomColor;
    self.cb2 = cb;
    
    [self setFooterView:cb edgeInsets:UIEdgeInsetsMake(40, 40, 40, 40)];
}

- (NSArray *)dateArrayWithTitle:(NSString *)title count:(NSInteger)count{
    NSMutableArray *arrayM = @[].mutableCopy;
    for (int i = 1; i <= count; i++) {
        XYCheckBoxItem *item = [XYCheckBoxItem new];
        item.title = [NSString stringWithFormat:@"%@%d",title,i];
        item.code = [NSString stringWithFormat:@"%d",i];
        [arrayM addObject:item];
    }
    return arrayM;
}

- (UIView *)headerWithTitle:(NSString *)title height:(NSInteger)height{
    
    UILabel *label = [[UILabel alloc] init];
    [label xy_setText:title font:[UIFont boldSystemFontOfSize:17] textColor:UIColor.blackColor];
    
    // 手动设置 header 高度 - 内部优先采用 高度 height 值
    // [dateLabel sizeToFit];
    
    // autolayout 设置 header 高度
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(ScreenW));
        make.height.equalTo(@(height));
    }];
    
    return label;
}



- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"cb1 选中内容为 %@", self.cb.allSelectedItems);
    NSLog(@"cb2 选中内容为 %@", self.cb1.allSelectedItems);
    NSLog(@"cb3 选中内容为 %@", self.cb2.allSelectedItems);
}

@end




// ---- 使用手册 ----
// 直接使用
// 需要使用 AutoLayout
// XYCheckBox *cb = [XYCheckBox new];
// cb.dataArray = @[];
// [view addsubView:cb];
// [cb mas_makeConstraints];
// 如果使用 headerView。 需手动设置 headerView 高度(高度约束)
//
// 直接使用类方法(推荐)
//

