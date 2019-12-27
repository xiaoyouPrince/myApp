//
//  UIControl+XYActionRecord.m
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/7.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "UIControl+XYActionRecord.h"
#import <objc/runtime.h>
#import "XYActionRecord.h"

@implementation UIControl (XYActionRecord)

const NSString *clickDataKey = @"pageDataKey";
const NSString *controlEventIDKey = @"controlEventIDKey";

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // touchesBegan 替换
        SEL originalTouchBegin_SEL = @selector(touchesBegan:withEvent:);
        SEL swizzledTouchBegin_SEL = @selector(xy_touchesBegan:withEvent:);
        
        [self xy_swizzledMethodWithSEL:originalTouchBegin_SEL SEL:swizzledTouchBegin_SEL];

    });
    
}

+ (void)xy_swizzledMethodWithSEL:(SEL)sel1 SEL:(SEL)sel2{
    
    SEL originalSelector = sel1;
    SEL swizzledSelector = sel2;
    Class class = [self class];
    
    xy_swizzledMethod(class, originalSelector, swizzledSelector);
    
    return;
}

#pragma mark - setter && getter

/**
 获取对应需要监听的文件数组
 */
- (NSArray <XYEvent *>*)eventData{
    
#warning todo - 需要优化，这里的数据类型，应该是获取一次就行了，现在的代码相当于每次加载都单独加载一次
    
    return xy_getEventRecord();
    
//    NSArray *eventData = objc_getAssociatedObject(self, &clickDataKey);
//    if (!eventData) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"EventRecord" ofType:@"plist"];
//        eventData = [NSArray arrayWithContentsOfFile:path];
//
//        NSMutableArray *arrayM = @[].mutableCopy;
//        for (NSDictionary *dict in eventData) {
//            XYEvent *event = [XYEvent modelWithDict:dict];
//            [arrayM addObject:event];
//        }
//
//        objc_setAssociatedObject(self, &clickDataKey, arrayM, OBJC_ASSOCIATION_RETAIN);
//
//        eventData = arrayM.copy;
//    }
//    return eventData;
}

- (void)setXy_eventID:(NSString *)xy_eventID
{
    objc_setAssociatedObject(self, &controlEventIDKey, xy_eventID, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)xy_eventID
{
    return objc_getAssociatedObject(self, &controlEventIDKey);
}


- (void)xy_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIControl *control = (UIControl *)[touch view];
//    NSLog(@"class - %@ - %s",NSStringFromClass(control.class),sel_getName(_cmd));
    
    for (XYEvent *e in [self eventData]) {
        if ([e.eventID isEqualToString:control.xy_eventID]) { // 说明是对应的事件
            
            NSLog(@"class - %@ - %s",NSStringFromClass(control.class),sel_getName(_cmd));
            
//            [XYActionRecord xy_actionWithDesc:e.desc file:nil func:nil obj:@"返回数据，进入新页面"];
            
            // 保存 描述 类 eventID obj(如果有)
    
            
//            [XYActionRecord xy_actionWithDesc:e.desc file:object_getClassName(self) func:sel_getName(_cmd)];
            
            [XYActionRecord xy_actionWithDesc:e.desc file:object_getClassName(self) func:[e.eventID cStringUsingEncoding:kCFStringEncodingUTF8]];
        }
    }
    
    [self xy_touchesBegan:touches withEvent:event];
}

- (void)xy_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
}





@end
