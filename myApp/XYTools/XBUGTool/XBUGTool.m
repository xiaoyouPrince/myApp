//
//  XBUGTool.m
//  XBUG
//
//  Created by 渠晓友 on 2019/4/22.
//  Copyright © 2019年 渠晓友. All rights reserved.
//

/*!
 配置文件 xconfig.plist , 可以从中读取具体项目中的配置，
 
 通常需要的配置如下:
 0. 切换当前项目的登录方式 (RELEASE/DEBUG 环境下不同)
 1. 项目根地址切换(可以自己设置)
 2. 子模块根地址切换(可以自己设置)
 
 */




#import <UIKit/UIKit.h>
#import "XBUGTool.h"
#import "XBUGConfigView.h"

static NSString *key_isxbug = @"key_isxbug";
static NSString *key_loginMethod = @"key_loginMethod";
static NSString *key_projURL = @"key_projURL";
static NSString *key_sqProjURL = @"key_sqProjURL";
#define XUserDefault [NSUserDefaults standardUserDefaults]

typedef void(^XBlock)(void);
void performOperation(XBlock debug,XBlock release);
void performOperation(XBlock debug,XBlock release){
#if DEBUG
    if (debug) {
        debug();
    }
#else
    if (release) {
        release();
    }
#endif
}

void performInDEBUG(XBlock debug);
void performInDEBUG(XBlock debug){
#if DEBUG
    performOperation(debug, nil);
#endif
}

void performInRELEASE(XBlock release);
void performInRELEASE(XBlock release){
#if RELEASE
    if (release) {
        release();
    }
#endif
}

@implementation XBUGTool

#pragma mark - 设置、取消、获取XBUG环境

+ (void)setXBUG
{
    performInDEBUG(^{
        [XUserDefault setObject:@(YES) forKey:key_isxbug];
    });
}

+ (void)resignXBUG{
    
    performInDEBUG(^{
        [XUserDefault setObject:@(NO) forKey:key_isxbug];
    });
}

+ (BOOL)getXBUG{
    
    __block BOOL isXBUG = [XUserDefault boolForKey:key_isxbug];
    
    // RELEASE 环境下非 xbug
    performInRELEASE(^{
        isXBUG = NO;
    });
    
    return isXBUG;
}

#pragma mark - 设置登录方式

+ (void)setLoginMethod:(LoginMethod)loginMethod{
    
    if (!xBUG) return;
    
    performInDEBUG(^{
        [XUserDefault setInteger:loginMethod forKey:key_loginMethod];
    });
    
}

+ (LoginMethod)loginMethod{
    
    __block LoginMethod loginMethod = [XUserDefault integerForKey:key_loginMethod];
    
    // RELEASE 环境下非 xbug
    performInRELEASE(^{
        loginMethod = LoginMethodPhoneSMS;
    });
    
    return loginMethod;
}


#pragma mark - 设置项目根地址

+ (void)setProjectRootURL:(NSString *)projURL{
    
    if (!xBUG) return;
    
    performInDEBUG(^{
        [XUserDefault setObject:projURL forKey:key_projURL];
    });
    
}

+ (NSString *)projectRootURL{
    
    __block NSString * projURL = [XUserDefault valueForKey:key_projURL];
    
    // RELEASE 环境下非 xbug
    performInRELEASE(^{
        projURL = @"https://api2.fescotech.com/appserver";
    });
    
    return projURL;
    
}


#pragma mark - 设置子模块根地址

+ (void)setShouQiProjectRootURL:(NSString *)subProjURL{
    
    if (!xBUG) return;
    
    performInDEBUG(^{
        [XUserDefault setObject:subProjURL forKey:key_sqProjURL];
    });
    
}

+ (NSString *)shouQiProjectRootURL{
    
    __block NSString * subProjURL = [XUserDefault valueForKey:key_sqProjURL];
    
    // RELEASE 环境下非 xbug
    performInRELEASE(^{
        subProjURL = [XUserDefault stringForKey:@"bookcar_base_url"];
    });
    
    
    if (subProjURL.length) {
        // 如果已经设置了就按照用户设置的来
        return subProjURL;
    }else
    {
        // 用户未设置的情况下，默认选择
        return [XUserDefault stringForKey:@"bookcar_base_url"];
    }
    
}


#pragma mark - 设置默认情况下地址【即xconfig.plist中配置的地址】

+ (void)setDefaultConfig
{
    // 设置 XBUG 环境
    // 设置 登录方式
    // 设置 项目地址
    // 设置 首汽项目地址
    
    
}


+ (void)showConfigView{
    
    [XBUGConfigView show];
}

@end
