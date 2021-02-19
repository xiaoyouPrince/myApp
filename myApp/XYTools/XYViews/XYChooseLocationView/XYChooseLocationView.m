//
//  XYChooseLocationView.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/26.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import "XYChooseLocationView.h"
#import "XYLocationCell.h"
#import "FMDB.h"

@interface XYChooseLocationView ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

/** 背景 coverBtn */
@property (nonatomic, strong)         UIButton * corverBtn;

/** scrollView */
@property (nonatomic, weak)         UIScrollView * scrollView;
/** contentView */
@property (nonatomic, weak)         UIView * contentView;

/** titleLabel */
@property (nonatomic, weak)         UILabel * titleLabel;

/** locationBar */
@property (nonatomic, weak)         XYLocationBar * locationBar;

/** 指示当前选项的 lineView */
@property (nonatomic, weak)         UIView * lineView;

/** locationBarItems */
@property (nonatomic, strong)       NSMutableArray * locationBarItems;

/** TableViews */
@property (nonatomic, strong)       NSMutableArray * tableViews;

/** 内部真实的数据 dataArray */
@property (nonatomic, strong)       NSMutableArray <NSArray <XYLocation *>*> * dataArray;

@end

@implementation XYChooseLocationView

#pragma mark - Public Methods - allow custom

+ (instancetype)viewAndShowWithConfig:(void (^)(XYChooseLocationView * _Nonnull))config
{
    return [self instanceAndShowWithConfig:config];
}
+ (instancetype)instanceAndShowWithConfig:(void (^)(XYChooseLocationView * _Nonnull))config
{
    // 创建
    XYChooseLocationView *clv = [XYChooseLocationView new];
    if (config) {
        config(clv);
    }
    [clv setupContent];
    
    // 添加 - 默认 height 是60%屏幕高度
    [clv.viewToShow addSubview:clv.corverBtn];
    clv.corverBtn.frame = clv.viewToShow.bounds;
    
    [clv.corverBtn addSubview:clv];
    clv.frame = CGRectMake(0, clv.corverBtn.frame.size.height, clv.corverBtn.frame.size.width, clv.corverBtn.frame.size.height * 0.6);
    
    // 展示
    [clv show];
    
    return clv;
}

#pragma mark - Public Methods - not allow custom

+ (instancetype)instanceAndShowWithDefault:(void (^)(NSArray<XYLocation *> * _Nonnull))finishChooseBlock{
    return [self instanceAndShowWithConfig:^(XYChooseLocationView * _Nonnull clv) {
        clv.baseDataArray = [self cityArrayForPid:@"0"];
        clv.getNextDataArrayHandler = ^NSArray<XYLocation *> * _Nonnull(XYLocation * _Nonnull cuttentLocation) {
            return [self cityArrayForPid:cuttentLocation.id];
        };
        clv.finishChooseBlock = finishChooseBlock;
    }];
}

+ (NSArray *)cityArrayForPid:(NSString *)pid
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"cityArray" ofType:@"sqlite"];
//    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
//
//    NSMutableArray *arrayM = @[].mutableCopy;
//
//    [queue inDatabase:^(FMDatabase *db) {
//        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_allCities WHERE pid = (?)",pid];
//
//        while (rs.next) {
//            long cid = [rs longForColumn:@"id"];
//            long pid = [rs longForColumn:@"pid"];
//            NSString * name = [rs stringForColumn:@"name"];
//            NSMutableDictionary *dict = @{}.mutableCopy;
//
//            [dict setValue:@(cid) forKey:@"id"];
//            [dict setValue:@(pid) forKey:@"pid"];
//            [dict setValue:name forKey:@"name"];
//            [arrayM addObject:dict];
//        }
//    }];
//    return arrayM;
    
#warning todo - XY 添加一个默认的数据源
    
    @throw [NSException exceptionWithName:@"XYChooseLocationView" reason:@"暂时不支持默认，因为本地数据异常。需要重新整理一下基础数据" userInfo:nil];
    
    return @[];
}

#pragma mark - Private Methods

- (void)show{
    
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
        self.corverBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        self.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -self.frame.size.height);
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:UINavigationControllerHideShowBarDuration animations:^{
        self.corverBtn.backgroundColor = UIColor.clearColor;
        self.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            [self.corverBtn removeFromSuperview];
            self.corverBtn = nil;
        }
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupBasic];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBasic];
    }
    return self;
}

- (void)setupBasic{
    self.title = @"选择地区";
    self.viewToShow = [UIApplication sharedApplication].keyWindow;
    self.corverBtn = [self getCoverBtn];
    self.backgroundColor = UIColor.whiteColor;
    self.locationBarItems = @[].mutableCopy;
    self.tableViews = @[].mutableCopy;
    self.dataArray = @[].mutableCopy;
}

- (UIButton *)getCoverBtn{
    UIButton *corverBtn = [UIButton new];
    corverBtn.backgroundColor = UIColor.clearColor;
    [corverBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return corverBtn;
}

- (void)setupContent{
    
    // 顶部toolBar 【取消 + titleLabel + 确定】
    UIView *toolBar = [[UIView alloc] init];
    toolBar.backgroundColor = HEXCOLOR(0xeaeaea);
    [self addSubview:toolBar];
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(41);
    }];
    
    // barView 内部
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:btn];

        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolBar).offset(0);
            make.left.equalTo(toolBar).offset(15);
            make.bottom.equalTo(toolBar).offset(-0);
        }];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = self.title;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        titleLabel.tintColor = UIColor.blackColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [toolBar addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(toolBar).offset(0);
        }];

        
        UIButton *btn_ensure = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn_ensure setTitle:@"确定" forState:UIControlStateNormal];
        [btn_ensure addTarget:self action:@selector(ensureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [toolBar addSubview:btn_ensure];
        
        [btn_ensure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolBar).offset(0);
            make.right.equalTo(toolBar).offset(-15);
            make.bottom.equalTo(toolBar).offset(-0);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = HEXCOLOR(0xeaeaea);
        [toolBar addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(toolBar).offset(0);
            make.left.equalTo(toolBar).offset(0);
            make.right.equalTo(toolBar).offset(-0);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    
    // 2. locationBar
    XYLocationBar *locationBar = [XYLocationBar new];
    self.locationBar = locationBar;
    [self addSubview:locationBar];
    [locationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolBar.mas_bottom).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.height.mas_equalTo(41);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = HEXCOLOR(0xeaeaea);
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(locationBar).offset(-0);
        make.left.equalTo(locationBar).offset(0);
        make.right.equalTo(locationBar).offset(-0);
        make.height.mas_equalTo(1);
    }];
    
    // 指示当前选中的View
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = HEXCOLOR(0xFF0000);
    [self addSubview:line];
    line.layer.cornerRadius = 2.5;
    line.clipsToBounds = YES;
    self.lineView = line;
    // 需要的时候再设置布局
    
    
    // 3. 底部内容View
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    self.scrollView.delegate = self;
    [self addSubview:scrollView];
    
    UIView *contentView = [UIView new];
    self.contentView = contentView;
    [self.scrollView addSubview:contentView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(82);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(-0);
        make.bottom.equalTo(self).offset(-0);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset(0);
        make.left.equalTo(scrollView).offset(0);
        make.right.equalTo(scrollView).offset(-0);
        make.height.equalTo(scrollView).offset(-0);
    }];
    
    
    /// 初始化3个操作
    // 创建 locationBarItem
    [self addLocationBarItem];
    [self addTableView];
    // 滑动底部滑块
    [self changeUnderLineFrame];
}


#pragma mark - private methods

/// locationBar 上面添加新的item
- (void)addLocationBarItem{
    
    XYLocationBarItemView *btn = [XYLocationBarItemView new];
    [btn setTitle:@"请选择" forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0x000000) forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(0xd92427) forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = self.locationBar.subviews.count;
    [self.locationBar addSubview:btn];
    [self.locationBarItems addObject:btn];
}

/// contentView 上面添加新的tableView
- (void)addTableView{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionFooterHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:XYLocationCell.class forCellReuseIdentifier:NSStringFromClass(XYLocationCell.class)];
    
    [self.contentView addSubview:tableView];
    tableView.tag = self.tableViews.count;
    [self.tableViews addObject:tableView];
    
    CGFloat contentW = ScreenW;//self.scrollView.frame.size.width;
    CGFloat contentH = self.scrollView.frame.size.height;
    int tableCount = 0;
    for (UIView *subView in self.contentView.subviews) {
        if ([subView isKindOfClass:UITableView.class]) {
            tableCount ++;
        }
    }
    
    // 更新contentW
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(tableCount * contentW);
    }];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset((tableCount - 1) * contentW);
        make.width.equalTo(self.scrollView).offset(0);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}


//滚动到下级界面,并重新设置顶部按钮条上对应按钮的title
- (void)scrollToNextItem:(XYLocation *)location{
    
    CGFloat contentW =  self.scrollView.frame.size.width;
    
    NSInteger index = self.scrollView.contentOffset.x / contentW;
    XYLocationBarItemView * btn = self.locationBarItems[index];
    btn.model = location;
    [btn setTitle:location.name forState:UIControlStateNormal];
    [btn sizeToFit];
    [self.locationBar layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollView.contentSize = (CGSize){self.tableViews.count * contentW,0};
        CGPoint offset = self.scrollView.contentOffset;
        self.scrollView.contentOffset = CGPointMake(offset.x + contentW, offset.y);

        // 滑动底部滑块
        [self changeUnderLineFrame];
    }];
}


- (void)changeUnderLineFrame{
    
    [self.locationBar layoutIfNeeded];
    UIButton *lastView = self.locationBar.subviews.lastObject;
    if ([lastView isKindOfClass:UIButton.class]) {
        lastView.selected = YES;
    }
    [lastView sizeToFit];
    self.lineView.frame = CGRectMake(lastView.frame.origin.x, 77, lastView.bounds.size.width, 5);
}


- (void)scrollToSpecificalPageInde:(NSInteger)pageIndex
{
    
    // 只有当滑动到上级页面才执行刷新数据等
    if (pageIndex >= self.locationBarItems.count-1) {
        return;
    }
    
    // 0. 移除当前页面之后的页面
    while (self.locationBarItems.count-1 > pageIndex) {
        [self.locationBar.subviews.lastObject removeFromSuperview];
        [self.locationBarItems removeLastObject];
        
        [self.contentView.subviews.lastObject removeFromSuperview];
        [self.tableViews removeLastObject];
        
        [self.dataArray removeLastObject];
    }
    
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.tableViews.count * self.scrollView.frame.size.width);
    }];
    
    
    // 1. 拿到locationBar上当前的item
    UIButton *item = self.locationBarItems[pageIndex];
    [item setTitle:@"请选择" forState:UIControlStateNormal];
    
    // 2. 滑动底部滑块指示器
    [self changeUnderLineFrame];
}


/// 设置最外部的基础数据
/// @param baseDataArray 基础数据源
- (void)setBaseDataArray:(NSArray<XYLocation *> *)baseDataArray
{
    [self.dataArray addObject:baseDataArray];
    [self.tableViews.firstObject reloadData];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count == 0) {
        return 0;
    }
    
    NSInteger tableIndex = tableView.tag;//[self.tableViews indexOfObject:tableView];
    NSArray *tableDataArray = self.dataArray[tableIndex];
    return tableDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(XYLocationCell.class)];
    
    NSInteger tableIndex = [self.tableViews indexOfObject:tableView];
    NSArray *tableDataArray = self.dataArray[tableIndex];
    XYLocation *location = tableDataArray[indexPath.row];
    cell.model = location;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 请求新数据，并展示
    XYLocationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // 1. 修改当前选中的内容为选中项目 - 修改顶部，本级别名称
    // 2. 查询本级别数据 - 加载新页面数据 1，新title 2 新列表
    // 1. 修改顶部 title
    
    // 请求新级别的数据
    NSInteger tableIndex = tableView.tag;
    NSArray *tableDataArray = self.dataArray[tableIndex];
    XYLocation *location = tableDataArray[indexPath.row];
    
    // 获取下一级数据。交给外界回调处理
    NSArray *nextLocations = @[];
    if (self.getNextDataArrayHandler) {
        if ([location isKindOfClass:NSDictionary.class]) { // 防止外界传入数组包字典。
            location = [XYLocation modelWithDict:(NSDictionary *)location];
        }
        nextLocations = self.getNextDataArrayHandler(location) ?: @[];
    }
    NSArray *locations = nextLocations;
    
    // 如果有数据
    if (locations.count) {
        // 1. 添加新的 item 和 列表
        [self.dataArray addObject:locations];
        [self addLocationBarItem];
        [self addTableView];
        
        // 2. 修改标题
        [self scrollToNextItem:cell.model];
    }else
    {
        // 1. 修改标题
        [self scrollToNextItem:cell.model];
        // 2. 直接跳转出去完成选择
        [self ensureBtnClick:nil];
    }
    
}


#pragma mark - scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollView != scrollView) {
        return;
    }
    
    int pageIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    
    [self scrollToSpecificalPageInde:pageIndex];
}



#pragma mark - btn actions

- (void)cancelBtnClick:(UIButton *)sender
{
    [self dismiss];
}

- (void)ensureBtnClick:(UIButton *)sender
{
    NSMutableArray *arrayM = @[].mutableCopy;
    for (XYLocationBarItemView *btn in self.locationBar.subviews) {
        // 最后一个为选择的，不进行添加
        if (btn.model) {
            [arrayM addObject:btn.model];
        }
    }
    
    // 回调
    if (self.finishChooseBlock) {
        self.finishChooseBlock(arrayM);
    }
    
    // 移除自己
    [self dismiss];
}

- (void)locationBtnClick:(UIButton *)sender
{
    // 重新选择当前级别内容
    NSInteger pageIndex = sender.tag;
    [self scrollToSpecificalPageInde:pageIndex];
}


- (void)dealloc
{
    NSLog(@"---------------------XYChooseLocationView---------------dealloc----------------------");
}

@end
