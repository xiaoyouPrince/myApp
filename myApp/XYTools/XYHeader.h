//
//  XYHeader.h
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/6.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

#ifndef XYHeader_h
#define XYHeader_h

/** DEBUG LOG **/
#ifdef DEBUG

#define DLog(...) NSLog( @"< %s:(第%d行) > %@",__func__ , __LINE__, [NSString stringWithFormat:__VA_ARGS__] )

#define XYFunc DLog(@"");

#else

#define DLog( s, ... )
#define XYFunc;

#endif


#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

// 2.获得RGB颜色
#define XYColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XYRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha: (a)]
#define XYGrayColor(v) XYColor(v,v,v)

// 3.获得随机颜色
#define XYRandomColor XYColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define HEXCOLOR(hexValue) ([UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1])

// 4.通知中心
#define kNotificationCenter [NSNotificationCenter defaultCenter]

// 5.userDefault
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kGlobalBgColor XYColor(0xf4, 0xf6, 0xf8)




#pragma mark -- 项目中用到的部分


/// 保存GPS定位城市
#define kSetGPSLocationCity(city) [[NSUserDefaults standardUserDefaults] setObject:(city) forKey:@"GPSLocationCity"]
#define kGetGPSLocationCity [kUserDefaults stringForKey:@"GPSLocationCity"]
/// 保存GPS定位Location
#define kSetGPSLocation(location) [[NSUserDefaults standardUserDefaults] setObject:(location) forKey:@"yc_GPSLocationAddress"]
#define kGetGPSLocation [kUserDefaults objectForKey:@"yc_GPSLocationAddress"]


/// 保存/获取  用户要定位的城市
#define kSetUserLocationCity(city) [[NSUserDefaults standardUserDefaults] setObject:(city) forKey:@"locationCity"]
#define kGetUserLocationCity \
[kUserDefaults stringForKey:@"locationCity"].length ? [kUserDefaults stringForKey:@"locationCity"] : kGetGPSLocationCity



#import "Masonry.h"
#import "MJExtension.h"

#import "XYKit.h"
#import "XYAlertView.h"

#endif /* XYHeader_h */


