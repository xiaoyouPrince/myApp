//
//  WebViewController.m
//  myApp
//
//  Created by 渠晓友 on 2020/6/11.
//  Copyright © 2020 渠晓友. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "XYKVO.h"
#import <objc/runtime.h>
#import "UIColor+XYAdd.h"
#import "NSObject+CJKVO.h"
@interface MyWebView : WKWebView
@end
@implementation MyWebView : WKWebView
- (void)dealloc{ XYFunc }
@end

@interface WebViewController ()
/** webview */
@property (nonatomic, weak)       MyWebView * webView;

/** name */
@property (nonatomic, readonly, copy)         NSString * name;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyWebView *webView = [[MyWebView alloc] init];
    self.webView = webView;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

//    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
//    object_setClass(webView, class_getSuperclass(object_getClass(webView)));
    
//    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    self.view.backgroundColor = UIColor.xy_titleColor;
    
    
    
    // 获取其内部方法
    Method getM = class_getInstanceMethod(object_getClass(webView), @selector(title));
    const char * getTypes = method_getTypeEncoding(getM);
    
    Method setM = class_getInstanceMethod(object_getClass(webView), @selector(setTitle:));
    const char * setTypes = method_getTypeEncoding(setM);
    
    NSLog(@"getM = %p,types = %s",getM,getTypes);
    NSLog(@"setM = %@,types = %s",setM,setTypes);
    
    Ivar var = class_getInstanceVariable(object_getClass(webView), "title");
    NSLog(@"name = %s,type = %s",ivar_getName(var),ivar_getTypeEncoding(var));
    
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList(object_getClass(webView), &outCount);
    NSLog(@"一共有%d个",outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar var = ivars[i];
        NSLog(@"ivar_name = %s,type = %s",ivar_getName(var),ivar_getTypeEncoding(var));
    }
    
    unsigned int outCount2;
    objc_property_t *propertys = class_copyPropertyList(object_getClass(webView), &outCount2);
    NSLog(@"一共有%d个",outCount2);
    for (int i = 0; i < outCount2; i++) {
        objc_property_t property = propertys[i];
        NSLog(@"property_name = %s,type = %s",property_getName(property),property_getAttributes(property));
    }
    
    
    
    
//    [self.webView xy_addObserverForKey:@"estimatedProgress" options:NSKeyValueObservingOptionNew observerHandler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull dict) {
//
//    }];

    XYWeakSelf;
    [self.webView xy_addObserverForKey:@"title" options:NSKeyValueObservingOptionNew observerHandler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull dict) {


        NSLog(@"%@,%@,",[NSThread currentThread],dict);

        weakSelf.title = dict[@"new"];
        weakSelf.name = dict[@"new"];
    }];

    [self xy_addObserverForKey:@"name" options:NSKeyValueObservingOptionNew observerHandler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull dict) {
        NSLog(@"%@,%@,",[NSThread currentThread],dict);

    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.name = @"dddd";
    });
    
    
    // 获取title 和 name 实现
//    SEL titleSel = [self selWithKey:@"title"];
//    SEL nameSel = [self selWithKey:@"name"];
    
    
//    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//
//    [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    
//    [self.webView CJ_addObserver:self forKey:@"title" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
//
//        NSLog(@"%@,%@,%@,%@,%@",[NSThread currentThread],observedObject,observedKey,oldValue,newValue);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.title = newValue;
//        });
//    }];
//
//    [self CJ_addObserver:self forKey:@"title" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
//
//        NSLog(@"%@,%@,%@,%@,%@",[NSThread currentThread],observedObject,observedKey,oldValue,newValue);
//    }];
    
//    [self CJ_addObserver:self forKey:@"name" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
//            NSLog(@"%@,%@,%@,%@,%@",[NSThread currentThread],observedObject,observedKey,oldValue,newValue);
//    }];
    
}

- (void)setName:(NSString *)name
{
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.name = @"你好";
//    self.title = @"你好";
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self) {
        if ([keyPath isEqualToString:@"title"]) {
            NSLog(@"title 发生改变");
        }else
        {
            NSLog(@"name 发生改变");
        }
    }
    
    
    
    if (object == self.webView) {
        if ([keyPath isEqualToString:@"title"]) {
            self.title = change[NSKeyValueChangeNewKey];
        }
        
        if ([keyPath isEqualToString:@"estimatedProgress"]) {
            
            CGFloat progress = [change[NSKeyValueChangeNewKey] floatValue];
            if (progress != 1.0) {
                [SVProgressHUD showProgress:progress];
            }else{
                [SVProgressHUD dismiss];
            }
        }
    }
}

- (void)dealloc
{
//    [self.webView removeObserver:self forKeyPath:@"title"];
//    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    
    [SVProgressHUD dismiss];
    
    XYFunc
}




@end
