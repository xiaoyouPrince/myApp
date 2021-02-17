//
//  XYStarView.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/23.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

// 1. 核心功能 - 属性值 + 功能框架的抽取
// 2. 附加优化细节

/*
    一个星星视图, 可自定义星星图片、星星大小(正方形)、星星间距、
 */

/*
 starView 布局规则 frame 布局 / autoLayout
 
 1. 提供两种构建方法,直接构建是 autoLayout 布局的。另提供一种 frame 布局的构建方案
 
 2. 星星在中间，第一个星的 left.top.bottom 均与 starView 相同。 从第二颗星星开始有星星间的间距。最后一颗星 .right 与 starView 右边距相同。
 
 starView 布局示意图:
 
 ---------------
 |*-*-*-*-*-*-*|
 —--------------
 
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYStarView : UIView

/** 选中星星数量 default is 34*/
@property(nonatomic, assign) CGFloat starWH;
/** 选中星星数量 default is 22*/
@property(nonatomic, assign) CGFloat starMargin;
/** 星星总数量 default is 5*/
@property(nonatomic, assign) NSInteger starCount;
/** 是否支持交互 default is NO, 如果可以选择星星请手动设置为YES*/
@property(nonatomic, assign) BOOL allowUserAction;
/** 选中星星数量 default is 0, 此值会实时更新*/
@property(nonatomic, assign) NSInteger selectedStarCount;
/** 星星图片的名称 default 为默认值*/
@property(nonatomic, copy) NSString* starImageName;
/** 选择星星回调 */
@property (nonatomic, copy) void (^starTapHandler)(NSInteger starCount);

+ (instancetype)starViewWithConfig:(nullable void(^)(XYStarView * starView))config;
+ (instancetype)instanceWithConfig:(nullable void(^)(XYStarView * starView))config;

NS_ASSUME_NONNULL_END

@end
