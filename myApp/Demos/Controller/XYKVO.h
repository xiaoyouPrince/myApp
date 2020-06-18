//
//  XYKVO.h
//  myApp
//
//  Created by 渠晓友 on 2020/6/15.
//  Copyright © 2020 渠晓友. All rights reserved.
//

// 自定义实现KVO
/// 核心步骤
/// 添加观察者
///     首次添加 -
///         创建子类 - 重写子类方法 - 添加观察者到缓存
///             setKey 和 class 方法
///     非首次添加 -
///         从缓存中，拿到KVO的观察关系，添加一个新的观察关系
/// 移除观察者/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^xy_observerHandler)(NSDictionary <NSKeyValueChangeKey,id>*dict);

@interface NSObject (XY_KVO)
/// 一行代码添加KVO监听
/// @param key 需要被监听的key
/// @param options 一个混合选项，在 readonly 属性中与系统同效果
/// @param handler 监听回调
- (void)xy_addObserverForKey:(NSString *)key
                     options:(NSKeyValueObservingOptions)options
             observerHandler:(xy_observerHandler)handler;
@end


NS_ASSUME_NONNULL_END
