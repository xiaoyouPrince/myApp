//
//  XBUGTool.h
//  XBUG
//
//  Created by 渠晓友 on 2019/4/22.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

/*!
 
 @note
 此文件只支持 DEBUG 环境
 
 使用可以在 DEBUG 环境下，某个功能出设置一个 UI页面进行如下功能配置(依据项目而定)
 
 1. 设置、取消、获取XBUG环境
 2. 设置项目登录方式
 3. 设置项目根地址
 4. 设置某个子模块根地址(根据子模块扩展，当前为首汽约车)
 
  @why
 此工具是基于 DEBUG 环境来创建和生成的，但是为什么不直接使用 DEBUG 环境在代码中实现呢，原因很简单，就是直接使用 DEBUG 会使得代码逻辑过于松散，本来是同样一套逻辑功能但是在整个项目中和其他逻辑一样使用 DEBUG 环境，显得十分混乱也不利于维护，这样通过一个工具封装起来就会使得逻辑自成一体比较清晰，重要的是方便后期维护
 
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 一些公用宏

#define xBUG                    [XBUGTool getXBUG] // 是否为 xbug 环境
#define xBUGLoginMethod         [XBUGTool loginMethod] // xbug 登录方式
#define xBUGProjUrl             [XBUGTool projectRootURL] // xbug 根地址
#define xBUGBookCarURL          [XBUGTool shouQiProjectRootURL] // xbug 首汽地址

typedef NS_ENUM(NSUInteger, LoginMethod) {
    LoginMethodAccount = 0,     ///< 账号密码登录
    LoginMethodPhoneSMS,        ///< 验证手机短信
    LoginMethodOther,           ///< 可能后期扩展三方登录
};

@interface XBUGTool : NSObject

#if 1

#pragma mark - 设置、取消、获取XBUG环境

+ (void)setXBUG;
+ (void)resignXBUG;
+ (BOOL)getXBUG;

#pragma mark - 设置登录方式


/**
 设置登录方式，手机验证码登录还是账号密码登录
 */
+ (void)setLoginMethod:(LoginMethod)loginMethod;
/**
 获取登录方式
 */
+ (LoginMethod)loginMethod;


#pragma mark - 设置项目根地址

/**
 设置项目根地址
 
 @param projURL 项目的根地址
 */
+ (void)setProjectRootURL:(NSString *)projURL;

/**
 获取项目的根地址
 */
+ (NSString *)projectRootURL;


#pragma mark - 设置子模块根地址(可以根据具体模块来扩展)


/**
 设置首汽约车子项目根地址
 
 @param subProjURL 子项目的根地址
 */
+ (void)setShouQiProjectRootURL:(NSString *)subProjURL;



/**
 获取首汽约车的根地址
 */
+ (NSString *)shouQiProjectRootURL;


#pragma mark - 设置默认情况下地址【即xconfig.plist中配置的地址】


/**
 设置配置文件中默认的配置
 */
+ (void)setDefaultConfig;

+ (void)showConfigView;

#endif

@end

NS_ASSUME_NONNULL_END
