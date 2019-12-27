//
//  XYFileTool.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/14.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//
//  文件管理工具类<计算缓存和删除等>

#import <Foundation/Foundation.h>

@interface XYFileTool : NSObject


/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)getAllFileSizeForDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion;




@end
