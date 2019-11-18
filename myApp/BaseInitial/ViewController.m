//
//  ViewController.m
//  myApp
//
//  Created by 渠晓友 on 2019/11/17.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responsSer = [AFHTTPResponseSerializer serializer];
    responsSer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    mgr.responseSerializer = responsSer;
    
    
    [mgr GET:@"http://10.0.84.95" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        debugLog(@"responseObject = %@",responseObject);
        
        debugLog(@"dict = %@",dict);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        debugLog(@"error = %@",error);
    }];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    debugLog(@"this is a null project!");
}

@end
