//
//  XYSwitch.h
//  myApp
//
//  Created by 渠晓友 on 2021/2/19.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYSwitch : UISwitch
/** 对象要设置属性 key */
@property (nonatomic, copy)         NSString * settingKey;
/** settingKey 对应的值 */
@property (nonatomic, assign, readonly)         BOOL settingValue;

/** 开关状态值改变回调 */
@property (nonatomic, copy)         void(^valueChangedHandler)(BOOL isOn);

@end

NS_ASSUME_NONNULL_END
