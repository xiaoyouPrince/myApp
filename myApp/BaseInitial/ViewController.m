//
//  ViewController.m
//  myApp
//
//  Created by 渠晓友 on 2019/11/17.
//  Copyright © 2019 渠晓友. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XYAlertView.h"
#import "XYKit.h"
#import "XYDemoListController.h"
#import <objc/runtime.h>
#import <UIImageView+WebCache.h>
#import "UIColor+XYAdd.h"

@interface ViewController ()

/** name */
@property (nonatomic, copy)         NSString * name;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    // UI
    [self buildUI];
    
        
}


- (void)buildUI{
    
    IMP imp = [NSObject instanceMethodForSelector:@selector(class)];
    NSMethodSignature *ms = [NSObject instanceMethodSignatureForSelector:@selector(class)];
    /**
        (lldb) po ms
        <NSMethodSignature: 0x6000018e5440>
            number of arguments = 2
            frame size = 224
            is special struct return? NO
            return value: -------- -------- -------- --------
                type encoding (#) '#'
                flags {isObject}
                modifiers {}
                frame {offset = 0, offset adjust = 0, size = 8, size adjust = 0}
                memory {offset = 0, size = 8}
            argument 0: -------- -------- -------- --------
                type encoding (@) '@'
                flags {isObject}
                modifiers {}
                frame {offset = 0, offset adjust = 0, size = 8, size adjust = 0}
                memory {offset = 0, size = 8}
            argument 1: -------- -------- -------- --------
                type encoding (:) ':'
                flags {}
                modifiers {}
                frame {offset = 8, offset adjust = 0, size = 8, size adjust = 0}
                memory {offset = 0, size = 8}
     */
    
    UIImageView *imageView = [UIImageView new];
    
    NSURL *url = [NSURL URLWithString:@"http://img.jj20.com/up/allimg/tx13/082120191238.jpg"];
    imageView.backgroundColor = UIColor.lightGrayColor;
    [imageView sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    imageView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:imageView];
    
    
    UIView *v1 = [UIView new];
    v1.frame = CGRectMake(100, 250, 50, 50);
    v1.backgroundColor = [UIColor xy_titleColor];
    [self.view addSubview:v1];
    
    UIView *v2 = [UIView new];
    v2.frame = CGRectMake(100, 350, 50, 50);
    v2.backgroundColor = [UIColor xy_contentColor];
    [self.view addSubview:v2];
    
    UIView *v3 = [UIView new];
    v3.frame = CGRectMake(100, 450, 50, 50);
    v3.backgroundColor = [UIColor xy_placeholderColor];
    [self.view addSubview:v3];
        
    
    // nav
    [self setupNav];
}

- (void)setupNav{
    
    UIEdgeInsets inset = UIEdgeInsetsMake(-20, 10, 0, 0);
    UIEdgeInsets inset2 = UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(backAction) nomalImage:[UIImage imageNamed:@"left"] higeLightedImage:[UIImage imageNamed:@"down"] imageEdgeInsets:inset];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(closeAction) nomalImage:[UIImage imageNamed:@"down"] higeLightedImage:[UIImage imageNamed:@"right"] imageEdgeInsets:inset2];
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem xy_itemWithTarget:self action:@selector(closeAction) title:@"你好" font:[UIFont systemFontOfSize:15] titleColor:UIColor.redColor highlightedColor:UIColor.greenColor titleEdgeInsets:UIEdgeInsetsZero];
}


- (void)backAction{
    XYFunc
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"wbenefit.fesco.com.cn://"]];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"wxser.fesco.com.cn://"]];
    
    
    // ---------------- opreationQueue ---- 加入queue中的任务都是异步执行的
    NSOperationQueue *oq = [[NSOperationQueue alloc] init];
    NSInvocationOperation *invo = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invo) object:nil];
    NSInvocationOperation *invo2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invo) object:nil];
    [oq addOperation:invo];
    [oq addOperation:invo2];
    
    for (int i = 0; i < 5; i++) {
        NSLog(@"%@ : %d",[NSThread currentThread],i);
    }
}

- (void)closeAction{
    XYFunc
    
    
    // KVC 合并数组
    NSArray *arr1, *arr2, *arr3, *arr4;
    arr1 = @[@1,@2,@3];
    arr2 = @[@4,@5,@3];
    arr3 = @[@1,@6,@7,arr1];
    
    arr4 = [@[arr1, arr2, arr3] valueForKeyPath:@"@unionOfArrays.self"];
    DLog(@"arr4 = %@",arr4);
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"%@ : %d",[NSThread currentThread],i);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"%@ : %d",[NSThread currentThread],i);
        }
    });
 
//    这样会直接阻塞主线程，是不可取的 -- 注意，是卡的主线程
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
//    for (int i = 0; i < 5; i++) {
//        NSLog(@"over");
//    }
    
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"Over! : %d",i);
        }
        NSLog(@"Over! : %@",[NSThread currentThread]);
        // 这里依旧是子线程，如果修改UI 要去主线程
    });
    
    for (int i = 0; i < 5; i++) {
        NSLog(@"Finish! : %d",i);
    }
    

    
}

- (void)invo{
    for (int i = 0; i < 5; i++) {
        NSLog(@"%@ : %d",[NSThread currentThread],i);
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [XYAlertView showAlertOnVC:self
                             title:@"提示"
                           message:@"目前是一个空项目，但是已经有一些Demo，是否查看"
                           okTitle:@"好的" okAction:^{
                                XYDemoListController *detail = [XYDemoListController new];
                                [self.navigationController pushViewController:detail animated:YES];
                                return;
                        }
                       cancelTitle:@"不进入了"
                      cancelAction:^{
            return;
        }];
    });
    
    
    XYDemoListController *detail = [XYDemoListController new];
    [self.navigationController pushViewController:detail animated:YES];
    
}

@end
