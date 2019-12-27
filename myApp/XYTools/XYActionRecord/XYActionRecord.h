//
//  XYActionRecord.h
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/6.
//  Copyright © 2019 渠晓友. All rights reserved.
//

//  事件记录工具

//  记录格式为 time - file - func - desc - [obj]

#import <Foundation/Foundation.h>
#import "XYActionDataAndNetTool.h"

NS_ASSUME_NONNULL_BEGIN

/***************************** 用于具体页面中 ****************************/
#define XYACTION_OBJ(desc,obj_) [XYActionRecord xy_actionWithDesc:(desc) file:__FILE__ func:__func__ obj:obj_];
#define XYACTION(desc) XYACTION_OBJ(desc,nil);

@interface XYActionRecord : NSObject


/*************************** 类 PAI 记录对应参数 **************************/
/**
 顺序执行埋点，记录当前操作
 
 @note 可用于 tracking 页面中
 */
+ (void)xy_actionWithDesc:(NSString *)desc;
+ (void)xy_actionWithDesc:(NSString *)desc
                     file:(nullable const char *)filePath;
+ (void)xy_actionWithDesc:(NSString *)desc
                     file:(nullable const char *)filePath
                     func:(nullable const char *)func;
+ (void)xy_actionWithDesc:(NSString *)desc
                     file:(nullable const char *)filePath
                     func:(nullable const char *)func
                      obj:(nullable id)obj;


@end

@interface XYEvent : NSObject

/** eventID 需要在 EventRecord.plist 中设置好 */
@property(nonatomic , copy)     NSString *eventID;
/** 事件描述 */
@property(nonatomic , copy)     NSString *desc;
/** 返回结果 */
@property(nonatomic , retain)   id resultObj;

+ (instancetype)modelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

#pragma mark - open functions

/// 替换某个类中的两个方法
void xy_swizzledMethod(Class cls , SEL sel1 , SEL sel2);

/// 获取需要监听的页面数据数组
NSArray * xy_getPageRecord(void);

/// 获取需要监听的事件数据数组
NSArray * xy_getEventRecord(void);

NS_ASSUME_NONNULL_END
