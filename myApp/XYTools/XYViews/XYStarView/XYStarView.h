//
//  XYStarView.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/23.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

/**
 使用方式 :
    如果XIB加载，请在 viewDidAppear 方法中设置starView的frame
 
 /// 1.设置星星 ,viewDidLoad 中 frame 不准
     XYStarView *starView = [[XYStarView alloc] initWithFrame:superView.bounds];
     starView.starCount = 2;
     [superView addSubview:starView];
 
 /// 2.取start数量
     CGFloat startCount = starView.starCount;
 
 /// 3.自定义starSize大小,并自动重置星星间距
     XYStarView *starView = [[XYStarView alloc] initWithFrame:superView.bounds starSize:size autoResizeStarMargin:YES];
     starView.starCount = 2;
     [superView addSubview:starView];
 
 /// 4.自定义star图片和星星大小
     XYStarView *starView = [[XYStarView alloc] initWithFrame:superView.bounds starSize:size autoResizeStarMargin:YES];
     [starView count:count withName:name]
     [superView addSubview:starView];
 
 /// 5.评价只需设置星星数量为 0
     XYStarView *starView = [[XYStarView alloc] initWithFrame:superView.bounds autoResizeStarMargin:YES];
     starView.starCount = 0;  // 当starCount == 0 的时候默认是可评价状态
     [superView addSubview:starView];
 */

#import <UIKit/UIKit.h>

@interface XYStarView : UIView

/** 默认星星，直接设置星星数就行*/
@property(nonatomic, assign) NSInteger starCount;

/** 自定义的背景图的星星数量*/
- (void)count:(NSInteger)count withName:(NSString *)name;

/** 可以自定义星星大小 */
- (instancetype)initWithFrame:(CGRect)frame starSize:(CGFloat)size autoResizeStarMargin:(BOOL)autoResizeMargin;

@end
