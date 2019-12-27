//
//  XYActionRecord.m
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/6.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "XYActionRecord.h"
#import <objc/runtime.h>

@implementation XYActionRecord

#pragma mark - private tools

/**
 返回当前时间 yyyy/MM/dd HH:mm:ss:ssssss
 */
+ (NSString *)xy_currentTime{
    NSDate *date = [NSDate date];
    NSTimeInterval interval = [date timeIntervalSince1970];
    NSArray *timeArr = [[NSString stringWithFormat:@"%lf",interval] componentsSeparatedByString:@"."];
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyy/MM/dd HH:mm:ss:";
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *result = [dateStr stringByAppendingString:timeArr.lastObject];
    
    return result;
}

/**
 获取当前文件路径的最后一个文件名

 @param filePath 文件路径
 */
+ (NSString *)xy_file:(const char *)filePath{
    if (filePath != NULL) {
        NSString *originPath = [NSString stringWithUTF8String:filePath];
        return [originPath lastPathComponent];
    }
    return nil;
}

/**
 获取当前调用的方法
 
 @param function 函数名
 */
+ (NSString *)xy_function:(const char *)function{
    if (function != NULL) {
        NSString *originFunc = [NSString stringWithUTF8String:function];
        return originFunc;
    }
    return nil;
}


#pragma mark - API

+ (void)xy_actionWithDesc:(NSString *)desc{
    [self xy_actionWithDesc:desc file:nil];
}

+ (void)xy_actionWithDesc:(NSString *)desc file:(nullable const char *)filePath{
    [self xy_actionWithDesc:desc file:filePath func:nil];
}

+ (void)xy_actionWithDesc:(NSString *)desc file:(nullable const char *)filePath func:(nullable const char *)func{
    [self xy_actionWithDesc:desc file:filePath func:func obj:nil];
}
+ (void)xy_actionWithDesc:(NSString *)desc file:(nullable const char *)filePath func:(nullable const char *)function obj:(nullable id)obj{
    
    if (!desc) return; /// 未传desc直接退出
    
    NSString *time = [self xy_currentTime];
    NSString *file = [self xy_file:filePath];
    NSString *func = [self xy_function:function];
    NSString *logStr = [time stringByAppendingString:(!file) ? @"" : [NSString stringWithFormat:@" - %@",file]];
    logStr = [logStr stringByAppendingString:(!func) ? @"" : [NSString stringWithFormat:@" - %@",func]];
    logStr = [logStr stringByAppendingString:desc];

    
    if ([obj isKindOfClass:NSString.class] ||
        [obj isKindOfClass:NSArray.class] ||
        [obj isKindOfClass:NSDictionary.class]) {
        NSLog(@"%@ - %@",logStr,obj);
        
        NSString *string = [NSString stringWithFormat:@"%@ - %@",logStr,obj];
        [XYActionDataAndNetTool saveRecordWithDesc:string];
        
    }else{
        NSLog(@"%@",logStr);
        
        NSString *string = [NSString stringWithFormat:@"%@",logStr];
        [XYActionDataAndNetTool saveRecordWithDesc:string];
    }
}

@end

@implementation XYEvent

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end


#pragma mark - open functions

/// 替换两个方法
void xy_swizzledMethod(Class cls , SEL sel1 , SEL sel2){
    
    SEL originalSelector = sel1;
    SEL swizzledSelector = sel2;
    Class class = cls;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/// 获取需要监听的页面数据数组(每次都读取同一份数据，比绑定到该对象上节省内存)
NSArray * xy_getPageRecord(){
    
    NSString *pagePath = [[NSBundle mainBundle] pathForResource:@"PageRecord" ofType:@"plist"];
    NSArray *pageData = [NSArray arrayWithContentsOfFile:pagePath];
    return pageData;
}

/// 获取需要监听的事件数据数组
NSArray * xy_getEventRecord(){
    
    NSArray *eventData = nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EventRecord" ofType:@"plist"];
    eventData = [NSArray arrayWithContentsOfFile:path];

    NSMutableArray *arrayM = @[].mutableCopy;
    for (NSDictionary *dict in eventData) {
        XYEvent *event = [XYEvent modelWithDict:dict];
        [arrayM addObject:event];
    }
    
    return arrayM;
}
