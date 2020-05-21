//
//  XYHealthViewController.m
//  myApp
//
//  Created by 渠晓友 on 2020/5/20.
//  Copyright © 2020 渠晓友. All rights reserved.
//
//  健康Demo

#import "XYHealthViewController.h"

#import "XYHealthKitTool.h"

@interface XYHealthViewController ()
@property (weak, nonatomic) IBOutlet UILabel *authLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;




@end

@implementation XYHealthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)authBtnClick:(id)sender {
    
    [XYHealthKitTool getTodayTotalStepCountHandler:^(NSInteger totalCount, NSError * _Nullable error) {
        
        if (error) {
            self.authLabel.text = [NSString stringWithFormat:@"%@",error.domain];
        }else
        {
            self.authLabel.text = @"用户许可";
        }
    }];
    
    
}

- (IBAction)getStepCountBtnClick:(id)sender {
    
    [XYHealthKitTool getTodayTotalStepCountHandler:^(NSInteger totalCount, NSError * _Nullable error) {
        
        if (error) {
            self.stepLabel.text = [NSString stringWithFormat:@"error = %@",error.domain];
        }else
        {
            self.stepLabel.text = [NSString stringWithFormat:@"一共%zd步",totalCount];
        }
    }];
}

@end
