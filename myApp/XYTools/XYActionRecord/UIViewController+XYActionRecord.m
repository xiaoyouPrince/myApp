//
//  UIViewController+XYActionRecord.m
//  UserActionTrack
//
//  Created by 渠晓友 on 2019/7/7.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "UIViewController+XYActionRecord.h"
#import <objc/runtime.h>
#import "XYActionRecord.h"

@implementation UIViewController (XYActionRecord)

const NSString *pageDataKey = @"pageDataKey";

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // viewWillAppear 替换
        SEL originalViewWillAppear_SEL = @selector(viewWillAppear:);
        SEL swizzledViewWillAppear_SEL = @selector(xy_viewWillAppear:);
        
        [self xy_swizzledMethodWithSEL:originalViewWillAppear_SEL SEL:swizzledViewWillAppear_SEL];
        
        
        // viewWillDisappear 替换
        SEL originalViewWillDisappear_SEL = @selector(viewWillDisappear:);
        SEL swizzledViewWillDisappear_SEL = @selector(xy_viewWillDisappear:);
        
        [self xy_swizzledMethodWithSEL:originalViewWillDisappear_SEL SEL:swizzledViewWillDisappear_SEL];
    });
    
}

+ (void)xy_swizzledMethodWithSEL:(SEL)sel1 SEL:(SEL)sel2{

    SEL originalSelector = sel1;
    SEL swizzledSelector = sel2;
    Class class = [self class];
    
    xy_swizzledMethod(class, originalSelector, swizzledSelector);
    
    return;
}


/**
 获取对应需要监听的文件数组
 */
- (NSArray *)pageData{
    
    return xy_getPageRecord();
    
//    NSArray *pageData = objc_getAssociatedObject(self, &pageDataKey);
//    if (!pageData) {
//        NSString *pagePath = [[NSBundle mainBundle] pathForResource:@"PageRecord" ofType:@"plist"];
//        pageData = [NSArray arrayWithContentsOfFile:pagePath];
//
//        objc_setAssociatedObject(self, &pageDataKey, pageData, OBJC_ASSOCIATION_RETAIN);
//    }
//    return pageData;
}


-(void)xy_viewWillAppear:(BOOL)animated {
    
    
    NSString *className = NSStringFromClass(self.class);
    // NSLog(@"class - %@ - %s",className,__func__);
    
    // 读取对应的文档
//    NSString *pagePath = [[NSBundle mainBundle] pathForResource:@"PageRecord" ofType:@"plist"];
//    NSArray *array = [NSArray arrayWithContentsOfFile:pagePath];
    
    NSArray *array = [self pageData];
    
    if ([array containsObject:className]) { // 是要被监听的类
        
//        NSLog(@"class - %@ - %s",className,__func__);
        
        NSLog(@"被监听类 %@ - %s",className,sel_getName(_cmd));
        
        [XYActionRecord xy_actionWithDesc:@"进入页面" file:object_getClassName(self) func:sel_getName(_cmd)];
    }
    
    
    
    
    [self xy_viewWillAppear:animated];
    
//    XYACTION(@"进入页面-")
    
//    const char *file = [NSStringFromClass(self.class) cStringUsingEncoding:NSUTF8StringEncoding];
//    [XYActionRecord xy_actionWithDesc:@"进入页面-" file:file];

}

-(void)xy_viewWillDisappear:(BOOL)animated {
    
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"class - %@ - %s",NSStringFromClass(self.class),__func__);
    
    
    NSArray *array = [self pageData];
    
    if ([array containsObject:className]) { // 是要被监听的类
        
        //        NSLog(@"class - %@ - %s",className,__func__);
        
        NSLog(@"被监听类 %@ - %s",className,sel_getName(_cmd));
        
        [XYActionRecord xy_actionWithDesc:@"离开页面" file:object_getClassName(self) func:sel_getName(_cmd)];
    }
    
    [self xy_viewWillDisappear:animated];

}

@end
