//
//  XYActionDataAndNetTool.m
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/7.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYActionDataAndNetTool.h"
#import "FMDB.h"

NSNotificationName UserActionShouldSendNotication = @"UserActionShouldSendNotication";

@implementation XYActionDataAndNetTool

/*!
 
 @abstract
 1. 创建数据库、数据表（主键 and 一个 desc 字段）
 2. 保存对应的 desc 到表中（除主键，只有一个描述字段）
 3. 监听网络请求报错的一个字段，，，然后被触发的时候，直接发送对应的file到服务器
 
 4. 监听对应的用户操作文件表的数据量，半个小时之前的自动移除，防止数据量过大
 */

#define DB_Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"userAction.sqlite"]

// 声明一个只有本文件能用的数据库全局队列
static FMDatabaseQueue *_queue;

+ (void)initialize
{
    // 0.获得沙盒中的数据库文件名
    NSString *path = DB_Path;
    
    NSLog(@"%@",path);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    // 2.创表 地址 和 乘车人
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists t_userActions (id integer primary key autoincrement, desc text);"];
    }];
    
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendUserActionData) name:UserActionShouldSendNotication object:nil];
}


+ (void)saveRecordWithDesc:(NSString *)desc
{
    /// 前期验证，存入数据为空直接返回
    if (!desc.length) return;
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        // 存储数据
        BOOL isSuccess = [db executeUpdate:@"insert into t_userActions ( desc ) values( ? )",desc];
        if (isSuccess) {
            NSLog(@"保存成功");
        }
    }];
}

+ (NSArray *)getAllRecords{
    
    NSMutableArray *result = @[].mutableCopy;
    [_queue inDatabase:^(FMDatabase *db) {
        // 查询所有数据
        FMResultSet *set = [db executeQuery:@"select * from t_userActions"];
        
        
        while (set.next) {
            NSInteger index = [set intForColumn:@"id"];
            NSString *desc = [set stringForColumn:@"desc"];
            NSString *record = [NSString stringWithFormat:@"%ld. %@",(long)index,desc];
            [result addObject:record];
        }
    }];
    
    return result;
}



/**
 发送用户的相关数据
 */
+ (void)sendUserActionData{
    
    // 1. 获取对应的文件数据
    NSArray *array = [XYActionDataAndNetTool getAllRecords];
    
    
    NSLog(@"最终数据为 - %@",array);
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
