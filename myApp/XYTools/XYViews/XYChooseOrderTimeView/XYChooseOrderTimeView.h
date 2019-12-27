//
//  XYChooseOrderTimeView.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2019/12/26.
//  Copyright © 2019 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYChooseOrderTimeView : UIView

// 直接调用选择方法即可
+ (void)chooseDateWithHandler:(void(^)(NSDateComponents *components))handler;

@end

NS_ASSUME_NONNULL_END
