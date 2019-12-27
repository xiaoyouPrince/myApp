//
//  UIResponder+XYActionRecord.m
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/7.
//  Copyright © 2019 渠晓友. All rights reserved.
//
//  替换点击事件 touch
/**
 @note
 本文件只能追踪非 UIControl 的对象 touch 操作,且需开启 userInteractionEnable
 */

#import "UIResponder+XYActionRecord.h"
#import <objc/runtime.h>
#import "XYActionRecord.h"

@implementation UIResponder (XYActionRecord)
const NSString *eventIDKey = @"eventIDKey";

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // viewWillAppear 替换
        SEL originalTouchBegin_SEL = @selector(touchesBegan:withEvent:);
        SEL swizzledTouchBegin_SEL = @selector(xy_touchesBegan:withEvent:);
        
#warning -- 这里的两个点击方法替换之后，在进入服务-出行服务时候出现问题，应该是阻断了消息传递机制，这里需要找时间好好研究一下消息传递机制。。。尤其是这种view->tableView->cell(内部cellcontentView)->view 这种情况下点击cell的内部的view，消息是如何传递到对应的tableView上的。
        
        //[self xy_swizzledMethodWithSEL:originalTouchBegin_SEL SEL:swizzledTouchBegin_SEL];
        
        
//        // viewWillDisappear 替换
//        SEL originalViewWillDisappear_SEL = @selector(viewWillDisappear:);
//        SEL swizzledViewWillDisappear_SEL = @selector(xy_viewWillDisappear:);
//
//        [self xy_swizzledMethodWithSEL:originalViewWillDisappear_SEL SEL:swizzledViewWillDisappear_SEL];
    });
    
}

+ (void)xy_swizzledMethodWithSEL:(SEL)sel1 SEL:(SEL)sel2{
    
    SEL originalSelector = sel1;
    SEL swizzledSelector = sel2;
    
    Class class = [self class];
    
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

- (void)setXy_eventID:(NSString *)xy_eventID
{
    objc_setAssociatedObject(self, &eventIDKey, xy_eventID, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)xy_eventID
{
    return objc_getAssociatedObject(self, &eventIDKey);
}

- (void)xy_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"class - %@ - %s",NSStringFromClass(self.class),__func__);
    
    //  这里处理要监听文件中加载到的类的，具体点击，并非每个 UIResponder 的点击都监听处理
    
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    
    // 这里也需要是从文件中读取的才行
    NSArray <XYEvent *>*array = xy_getEventRecord();
    for (XYEvent *e in array) {
        if ([e.eventID isEqualToString:view.xy_eventID]) {
            
            NSLog(@"class - %@ - %s",NSStringFromClass(view.class),sel_getName(_cmd));
            
            [XYActionRecord xy_actionWithDesc:@"View:Touch" file:object_getClassName(self) func:sel_getName(_cmd)];
        }
    }
    
    // 直接让其两层以上的view接收点击看看
    
    UIView *suView = view.superview;                // contentView
    UIView *ssuView = suView.superview;             // cell -> 自己的类
    UIView *sssuView = ssuView.superview;           // tableView -> kindofScrollView
    
    [self xy_touchesBegan:touches withEvent:event];
}


@end
