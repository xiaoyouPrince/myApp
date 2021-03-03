//
//  XYAuthenticationTool.h
//  AFNetworking
//
//  Created by 渠晓友 on 2021/3/3.
//

/*
 这是一个生物识别认证的工具
 
 功能:
 1. 获取当前设备可用的认证方式
 2. 调起生物识别。根据回调处理认证结果
 
 使用注意:
 如果支持 FaceID，需要在 Info.plist 中添加 Privacy - Face ID Usage Description
 eg: Privacy - Face ID Usage Description -> 使用 Face ID 来解锁
 eg: NSFaceIDUsageDescription -> 使用 Face ID 来解锁
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XYAuthType) {
    XYAuthTypeNone,
    XYAuthTypeTouchID,
    XYAuthTypeFaceID,
};
typedef void (^AuthTypeBlock)(XYAuthType type);

@interface XYAuthenticationTool : NSObject

/** 返回可用于认证类型 */
@property (class, nonatomic, assign, readonly)   XYAuthType authType;

/// 调起生物识别认证
/// @param tipString 给用户的提示语(直接表达用途即可，不需包含AppName)
/// @param reply 认证成功、失败回调
+ (void)startAuthWithTip:(NSString *)tipString reply:(void (^)(BOOL success, NSError *error))reply;

@end

NS_ASSUME_NONNULL_END
