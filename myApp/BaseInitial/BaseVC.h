//
//  SceneDelegate.h
//  myApp
//
//  Created by 渠晓友 on 2019/11/17.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <XYInfomationBaseViewController.h>

@interface BaseVC : XYInfomationBaseViewController

/** 自定义cell点击回调 */
@property (nonatomic, copy)         void(^ _Nullable customCellClickCallBcak)(NSInteger index, XYInfomationCell * _Nonnull cell);

@end

