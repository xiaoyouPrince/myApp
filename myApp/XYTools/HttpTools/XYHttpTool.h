//
//  XYHttpTool.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//
//  通用的网络请求工具类

#import <Foundation/Foundation.h>

@interface XYHttpTool : NSObject


/**
 发送post网络请求

 @param url 请求地址
 @param params 请求参数 dict
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

/**
 发送post网络请求，带有对应状态下tipsView
 
 @param url 请求地址
 @param params 请求参数 dict
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)postWithTipsURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formDataArray success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

+ (void)cancelAllTasks;

@end


/**
 *  用来封装文件数据的模型
 */
@interface XYFormData : NSObject
/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end
