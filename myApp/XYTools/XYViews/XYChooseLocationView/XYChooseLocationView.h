//
//  XYChooseLocationView.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/9/26.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

//  一个多级联动选择地区的 View

#import <UIKit/UIKit.h>
#import "XYLocation.h"
#import "XYLocationBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseLocationView : UIView

/**
 
 1. 设置可选择等级  省市区，省市 默认无限
 2. 必须设置第一级别的id
 3. 自定义 title
 
 */

// ######################## 下面属性为可选 ##########################
/** 想要设置的 title, default is “选择地区” */
@property (nonatomic, copy)         NSString * title;
/** 想要加载到哪个view上 default is the keyWindow.  推荐设置为 VC.view*/
@property (nonatomic, weak)         UIView * viewToShow;
/** 可选最大层级数. default is 0, 支持无限层级选择。eg: 当选择省市区，可设置为3， 当选择省市，可设置为2 */
@property (nonatomic, assign)         NSUInteger maxLevel;

// ######################## 下面属性为必填 ##########################

/** 第一组基础数据 dataArray, default is nil @note 展示之前必须赋值*/
@property (nonatomic, strong)       NSArray <XYLocation *>* baseDataArray;

/// 获取第一组后面的数据 dataArray @note 调用时候内部需要同步返回，异步无效
@property (nonatomic, strong)       NSArray <XYLocation *>*(^getNextDataArrayHandler)(XYLocation* cuttentLocation);

/** 选择完毕，回调 */
@property (nonatomic, copy)         void(^finishChooseBlock)(NSArray <XYLocation *>*locations);


/// 快速创建实例 并 展示
/// @param config 展示之前需要进行设置，数据源必须设置
+ (instancetype)viewAndShowWithConfig:(void(^)(XYChooseLocationView *clv))config;
+ (instancetype)instanceAndShowWithConfig:(void(^)(XYChooseLocationView *clv))config;

/// 创建展示默认数据源的位置选择器 - 不可自定义数据源
/// @param finishChooseBlock 选完地址之后的回调
+ (instancetype)instanceAndShowWithDefault:(void(^)(NSArray <XYLocation *>*locations))finishChooseBlock;


@end

NS_ASSUME_NONNULL_END
