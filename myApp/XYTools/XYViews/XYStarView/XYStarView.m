//
//  XYStarView.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/23.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

#import "XYStarView.h"

@implementation XYStarView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupDefault];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupDefault];
    }
    return self;
}

- (void)setupDefault{
    self.starWH = 34;
    self.starMargin = 22;
    self.starCount = 5;
    self.allowUserAction = NO;
    self.selectedStarCount = 0;
    self.starImageName = @"icon_star";
}

- (void)setStarImageName:(NSString *)starImageName
{
    UIImage *image = [UIImage imageNamed:starImageName];
    if (!image) {
        _starImageName = @"icon_star";
    }else
    {
        _starImageName = starImageName;
    }
}

- (void)setupStar{
    
    // 根据用户设置的size取值
    CGFloat H = _starWH;
    CGFloat W = H;
    
    for (int i = 0; i < _starCount; i++) {
        UIImageView *iv = [[UIImageView alloc] init];
        CGFloat X = i * (W + _starMargin);
        iv.frame = CGRectMake( X, 0, W, H);
        if (i < self.selectedStarCount) {
            iv.image = [UIImage imageNamed:self.starImageName];
        }else{
            NSString *bgNname = [NSString stringWithFormat:@"%@_bg",self.starImageName];
            iv.image = [UIImage imageNamed:bgNname];
        }
        
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.tag = i;
        [self addSubview:iv];
        
        if (self.allowUserAction) {
            iv.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStarForAppraise:)];
            [iv addGestureRecognizer:tap];
        }
    }
}

- (void)tapStarForAppraise:(UITapGestureRecognizer *)tap{
    // 设置用户点击星星数量
    UIImageView *iv = (UIImageView *)tap.view;
    // 选中部分替换成选中星星，后面不变
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSUInteger index = idx;
        if (index >= 0 && index <= iv.tag) {
            obj.image = [UIImage imageNamed:self.starImageName];
        }else if (index >iv.tag){
            NSString *bgNname = [NSString stringWithFormat:@"%@_bg",self.starImageName];
            obj.image = [UIImage imageNamed:bgNname];
        }
    }];
    
    // 通知外界
    self.selectedStarCount = iv.tag + 1;
    if (self.starTapHandler) {
        self.starTapHandler(self.selectedStarCount);
    }
}

+ (instancetype)starViewWithConfig:(void (^)(XYStarView *))config {
    return [self instanceWithConfig:config];
}
+ (instancetype)instanceWithConfig:(void (^)(XYStarView *))config {
    XYStarView *starView = [XYStarView new];
    if (config) {
        config(starView);
    }
    [starView setupStar];
    CGFloat width = starView->_starCount * (starView.starWH + starView.starMargin) - starView.starMargin;
    starView.frame = CGRectMake(0, 0, width, starView.starWH);
    return starView;
}

@end
