//
//  XYImageDemoController.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/22.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYImageDemoController.h"
#import "XYImagePickerController.h"
#import "XYTakePhotoController.h"
#import "UIView+XYAdd.h"
#import "XYAlertView.h"

@interface XYImageDemoController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_idCard;

@end

@implementation XYImageDemoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
    self.imageView_idCard.userInteractionEnabled = YES;
    [self.imageView_idCard addGestureRecognizer:tap2];
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap{
    
    UIImageView *receiverView = (UIImageView *)tap.view;
    if (receiverView == self.imageView) {
        [self chooseImage];
    }else{
        [self takeIDCardPhoto];
    }
}

- (void)chooseImage{
    
    XYAlertAction *action = [XYAlertAction modelWithTitle:@"相机" value:@"1"];
    XYAlertAction *action2 = [XYAlertAction modelWithTitle:@"相册" value:@"2"];
    XYAlertAction *action3 = [XYAlertAction modelWithTitle:@"取消" value:@"3" style:UIAlertActionStyleCancel];
    NSArray *actions = @[action,action2,action3];
    [XYAlertView showSheetOnVC:self title:@"选择图片来源" message:@"就是一个解释说明" actions:actions actionHandler:^(NSInteger index) {
        
        UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypeCamera;
        if (index == 0) {
            type = UIImagePickerControllerSourceTypeCamera;
        }else if(index == 1)
        {
            type = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else{
            return;
        }
        
        // 2. 一行代码添加 XYImagePickerController 选择图片
        [XYImagePickerController presentImagePickerFromVC:self sourceType:type result:^(UIImage * _Nonnull image, NSString * _Nonnull errorMsg) {
            
            if (errorMsg) { // 处理错误信息
                NSLog(@"%@",errorMsg);
                return;
            }
            
            // 使用图片
            self.imageView.image = image;
        }];
    }];
}

- (void)takeIDCardPhoto{
    
    XYAlertAction *action = [XYAlertAction modelWithTitle:@"身份证正面" value:@"1"];
    XYAlertAction *action2 = [XYAlertAction modelWithTitle:@"身份证反面" value:@"2"];
    XYAlertAction *action3 = [XYAlertAction modelWithTitle:@"同时正反面" value:@"3"];
    XYAlertAction *action4 = [XYAlertAction modelWithTitle:@"银行卡片等" value:@"4"];
    XYAlertAction *action5 = [XYAlertAction modelWithTitle:@"取消" value:@"5" style:UIAlertActionStyleCancel];
    NSArray *actions = @[action,action2,action3,action4,action5];
    [XYAlertView showSheetOnVC:self title:@"选择图片来源" message:@"就是一个解释说明" actions:actions actionHandler:^(NSInteger index) {
        
        XYTakePhotoMode type = XYTakePhotoModeSingleFront;
        if (index == 0) {
            type = XYTakePhotoModeSingleFront;
        }else if(index == 1)
        {
            type = XYTakePhotoModeSingleBack;
        }else if(index == 2){
            type = XYTakePhotoModeFrontRear;
        }else if(index == 3){
            type = XYTakePhotoModeNormalCard;
        }else
        {
            return;
        }
        
        // 一行代码拍摄照片
        [XYTakePhotoController presentFromVC:self mode:type resultHandler:^(NSArray<UIImage *> * _Nonnull images, NSString * _Nonnull errorMsg) {
            
            if (errorMsg) {
                NSLog(@"errorMsg = %@",errorMsg);
            }else
            {
                // 放照片
                self.imageView_idCard.image = images.firstObject;
            }
            
        }];
    }];
}

@end
