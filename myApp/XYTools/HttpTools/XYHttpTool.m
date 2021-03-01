//
//  XYHttpTool.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

/**
 
 FESCO 网络返回值固定格式:
 
 {
     "status": 0,
     "message": null,
     "errorCode": null,
     "data": {
            ... 具体返回值
        }
 }
 
 解析类中直接解析外围参数，
 成功回调中直接返回data内部数据，外部自己解析data内部数据
 
 
 【 租车模块 】网络返回值固定格式:
 
 {
 errorCode = "izu_0001";
 failed = 1;
 message = "\U672a\U5f00\U901a\U7ea6\U8f66\U670d\U52a1";
 status = "-1";
 success = 0;
 }
 
 */


#import "XYHttpTool.h"
#import "AFNetworking.h"

static AFHTTPSessionManager *manager = nil;

@implementation XYHttpTool


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *error))failure
{
    // 0 检查网络
    if (![self testNetWork]) return;
    
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    [self setupHeader];
    
    // 2.发送请求
    [manager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 下面三行 ---  适配目前返回结构，优化自己解码
            NSDictionary *data = responseObject[@"data"];
            
            NSLog(@"url = %@",url);
            NSLog(@"header = %@",[manager.requestSerializer valueForHTTPHeaderField:@"Transport-Channels"]);
            NSLog(@"params = %@",params);
            NSLog(@"response = %@",responseObject);
            
            // 成功调用成功block
            if (success) {
                success(data);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 失败调用失败block
            if (failure) {
                failure(error);
                
                NSLog(@"url = %@",url);
                NSLog(@"params = %@",params);
                NSLog(@"error = %@",error);
            }
            
            
            // 提示没有网络hud
            [self hudForNoInternet];
        }];
    
}

+ (void)postWithTipsURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    [self setupHeader];
    
    // 2.发送请求
    [manager POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject[@"data"]);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
}




+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formData:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    [self setupHeader];
    
    [manager POST:url parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull totalFormData) {
            for (XYFormData* formData in formDataArray) {
                [totalFormData appendPartWithFileData:formData.data name:formData.name fileName:formData.filename mimeType:formData.mimeType];
            }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
}

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.创建管理者
    manager = [AFHTTPSessionManager manager];
    
    [self setupHeader];
    
    [manager GET:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    
}

+ (void)cancelAllTasks
{
    [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}


+ (void)setupHeader
{
    /// 设置请求头
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
}

/// 检查网络
+ (BOOL)testNetWork{
    return YES;
}


/// 没有网络的提示
+ (void)hudForNoInternet{
}

@end


/**
 *  用来封装文件数据的模型
 */
@implementation XYFormData

@end
