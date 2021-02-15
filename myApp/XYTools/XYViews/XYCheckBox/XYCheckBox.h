//
//  XYCheckBox.h
//  myApp
//
//  Created by 渠晓友 on 2021/2/15.
//  Copyright © 2021 渠晓友. All rights reserved.
//

/// 一款基本的复选框工具，示例页面 1.约车选择取消原因 2.切换账户，选择账户 3.选择列表中内容

/// 功能:
/// 1.基本功能，默认单选(可以设置参数为复选)
/// 2.具备基本cell样式，可以子类化cell，继承父类，实现选中方法即可
/// 3.支持设置自定义headerView     << end

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYCheckBoxItem : NSObject
/** title */
@property (nonatomic, copy)         NSString * title;
/** code */
@property (nonatomic, copy)         NSString * code;
/** selected */
@property (nonatomic, assign, getter=isSelected)         BOOL select;
/** cell 高度, defalut is 50 */
@property (nonatomic, assign)       CGFloat cellHeight;
/**
    自定义的选择框内部Cell的类名
    @par 默认是nil,展示基类cell. 传入自己已经自定义好的cell类名
    @note 需要继承自 XYCheckBoxCell 基类
 */
@property (nonatomic, copy)         NSString * customCellClass;


+ (instancetype)modelWithTitle:(NSString *)title code:(NSString *)code select:(BOOL)select;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end

@interface XYCheckBoxCell : UIView
/** model */
@property (nonatomic, strong)       XYCheckBoxItem * model;
/** 是否为选中状态 */
@property (nonatomic, assign, readonly)  BOOL isSelected;

/// 设置选中状态
/// @note 子类需要重写此方法 和 init 方法
/// @param selected 是否为选中状态，YES/NO
- (void)setSelected:(BOOL)selected;
@end

@interface XYCheckBox : UIView

/** 选中内容是否互斥，互斥即只允许单选 default is YES */
@property (nonatomic, assign)         BOOL isMutex;

/** 已经选中的内容，是否可以再次点击取消选中状态 default is NO */
@property (nonatomic, assign)         BOOL allowCancelSelected;

/** 需要选择的数据源 */
@property (nonatomic, strong)       NSArray <XYCheckBoxItem *>* dataArray;

/** 可自定制的headerView : default is nil*/
@property (nonatomic, strong)       UIView * headerView;

/** 每次有被选中的回调 */
@property (nonatomic, copy)         void(^itemSelectedHandler)(XYCheckBoxItem *item);

/** selectedItems,最终被选中的所有item */
@property (nonatomic, strong, readonly)       NSArray * allSelectedItems;

@end

NS_ASSUME_NONNULL_END
