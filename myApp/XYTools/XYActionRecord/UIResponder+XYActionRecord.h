//
//  UIResponder+XYActionRecord.h
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/7.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (XYActionRecord)

/** 监听用户事件的EventID */
@property(nonatomic , copy) IBInspectable NSString *xy_eventID;

@end

NS_ASSUME_NONNULL_END
