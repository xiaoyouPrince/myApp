//
//  XYCheckBox.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/15.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYCheckBox.h"
#import "Masonry.h"

@implementation XYCheckBoxItem

+ (instancetype)modelWithTitle:(NSString *)title code:(NSString *)code select:(BOOL)select{
    XYCheckBoxItem *item = [XYCheckBoxItem new];
    item.title = title;
    item.code = code;
    item.select = select;
    return item;
}
+ (instancetype)modelWithDict:(NSDictionary *)dict{
    XYCheckBoxItem *item = [XYCheckBoxItem new];
    return [item modelWithDict:dict];
}
- (instancetype)modelWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{/*防止KVC报错*/}

- (CGFloat)cellHeight
{
    return _cellHeight ?: 50;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"item = {title = %@, code = %@}",_title,_code];
}

@end

@interface XYCheckBoxCell ()

/** imageView */
@property (nonatomic, weak)         UIImageView * imageView;
/** titleLabel */
@property (nonatomic, weak)         UILabel * titleLabel;

@end
@implementation XYCheckBoxCell{
    UIImage *_selectedImage;
    UIImage *_unSelectedImage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // image
        NSString *currentBundle = [[NSBundle bundleForClass:self.class] pathForResource:@"CheckBox" ofType:@"bundle"];
        NSString *path_sel = [[NSBundle bundleWithPath:currentBundle] pathForResource:@"icon_box_choose@3x" ofType:@"png"];
        _selectedImage = [UIImage imageNamed:path_sel];
        NSString *path_unSel = [[NSBundle bundleWithPath:currentBundle] pathForResource:@"icon_box_unchoose@3x" ofType:@"png"];
        _unSelectedImage = [UIImage imageNamed:path_unSel];
        
        // iv
        UIImageView *icon = [UIImageView new];
        [self addSubview:icon];
        self.imageView = icon;
        
        // label
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(15);
            make.left.equalTo(self).offset(15);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self);
            make.left.equalTo(icon.mas_right).offset(15);
        }];
    }
    return self;
}

- (void)setModel:(XYCheckBoxItem *)model
{
    _model = model;
    [self setSelected:model.isSelected];
    
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(model.cellHeight));
    }];
    
    // 设置title
    self.titleLabel.text = model.title;
    // 设置code
    // 设置选中状态
}

- (BOOL)isSelected
{
    return self.model.isSelected;
}

- (void)setSelected:(BOOL)selected{
    self.model.select = selected;
    self.imageView.image = selected ? _selectedImage : _unSelectedImage;
}

@end

@interface XYCheckBox ()
/** contentView */
@property (nonatomic, strong)       UIView* contentView;
@end
@implementation XYCheckBox
@synthesize headerView=__headerView;

+ (instancetype)checkBoxWith:(UIView *)headerView dataArray:(NSArray<XYCheckBoxItem *> *)dataArray isMutex:(BOOL)isMutex allowCancelSelected:(BOOL)allowCancelSelected itemSelectedHandler:(void (^)(XYCheckBoxItem * _Nonnull))itemSelectedHandler{
    
    XYCheckBox *cb = [XYCheckBox new];
    cb.headerView = headerView;
    cb.dataArray = dataArray;
    cb.isMutex = isMutex;
    cb.allowCancelSelected = allowCancelSelected;
    cb.itemSelectedHandler = itemSelectedHandler;
    return cb;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupContent];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    // base
    self.clipsToBounds = true;
    _isMutex = YES;
    
    // headerView
    __headerView = [UIView new];
    __headerView.backgroundColor = UIColor.clearColor;
    [self addSubview:__headerView];
    
    // contentView
    _contentView = [UIView new];
    _contentView.backgroundColor = UIColor.clearColor;
    [self addSubview:_contentView];
    
    [__headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(__headerView.mas_bottom);
        make.left.right.equalTo(self);
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).priorityHigh();
    }];
}

#pragma mark - headerView
- (void)setHeaderView:(UIView *)headerView
{
    if (!headerView) { return; }
    
    // 默认
    [__headerView addSubview:headerView];
    
    [__headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (headerView.frame.size.height) {
            make.height.equalTo(@(headerView.frame.size.height));
        }else{
            make.height.equalTo(headerView.mas_height);
        }
    }];
}

- (UIView *)headerView
{
    return __headerView.subviews.firstObject;
}

#pragma mark - cells

- (void)setDataArray:(NSArray<XYCheckBoxItem *> *)dataArray
{
    if (dataArray.count == 0) { return; }
    
    _dataArray = dataArray;
    
    CGFloat index = -1;
    UIView *lastCell;
    for (XYCheckBoxItem *model in dataArray) {
        index++;
        
        // 创建view[查看是否有子类自定义]
        Class cellClass = NSClassFromString(model.customCellClass) ?: [XYCheckBoxCell class];
        
        XYCheckBoxCell *cell = [cellClass new];
        cell.tag = index;
        cell.model = model;
        [self.contentView addSubview:cell];
        
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            if (index == 0) {
                make.top.equalTo(self.contentView);
            }else
            {
                make.top.equalTo(lastCell.mas_bottom);
            }
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@(cell.model.cellHeight));
            
            if (index == dataArray.count-1) {
                make.bottom.equalTo(self.contentView);
            }
        }];
        
        lastCell = cell;
        
        // 添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapCell:)];
        [cell addGestureRecognizer:tap];
        
        // 一个分割线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = HEXCOLOR(0xeaeaea);
        [cell addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cell).offset(0);
            make.left.equalTo(cell).offset(15);
            make.right.equalTo(cell).offset(-15);
            make.height.mas_equalTo(0.5);
        }];
    }
}

- (void)didTapCell:(UITapGestureRecognizer *)tap{
    
    // 确认点击cell
    XYCheckBoxCell *cell = (XYCheckBoxCell *)tap.view;
    
    if (self.isMutex) {
        // 通知其他的cell 取消选中
        for (XYCheckBoxCell *cell in self.contentView.subviews) {
            [cell setSelected:NO];
        }
    }
    
    if (self.allowCancelSelected && cell.isSelected) {
        // 取消选中当前
        [cell setSelected:NO];
    }else{
        // 选中当前
        [cell setSelected:YES];
        if (self.itemSelectedHandler) {
            self.itemSelectedHandler(cell.model);
        }
        
    }
}

- (NSArray *)allSelectedItems{
    // 遍历自己内部的内容，返回
    NSMutableArray *result = @[].mutableCopy;
    
    for (XYCheckBoxCell *cell in self.contentView.subviews) {
        if (cell.isSelected) {
            [result addObject:cell.model];
        }
    }
    
    return result;
}

// 由于内部使用autoLayout，外界设置的 frame 会因为内部原因导致frame 在布局时候发生改变。所有应使用 autoLayout 给 CheckBox 布局
//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//}
//
//- (void)layoutSubviews{
//    [super layoutSubviews];
//
//    NSLog(@"frame = %@",NSStringFromCGRect(self.frame));
//}
@end
