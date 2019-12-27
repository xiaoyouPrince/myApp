//
//  XYStarView.m
//  feifanyouwo
//
//  Created by 渠晓友 on 2018/2/23.
//  Copyright © 2018年 zhuang chaoxiao. All rights reserved.
//

#import "XYStarView.h"

@implementation XYStarView

static CGFloat _starWH = 34;     // 默认 34pt 宽高
static CGFloat _starMargin = 22; // 默认是 22pt 间距

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 这个默认是星星，放到 设置星星的个数去执行星星背景了。
        [self setupDefaultSizeAndMargin];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 这个默认是星星，放到 设置星星的个数去执行星星背景了。
        [self setupDefaultSizeAndMargin];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        // 这个默认是星星，放到 设置星星的个数去执行星星背景了。
        [self setupDefaultSizeAndMargin];
    }
    return self;
}

- (void)setupDefaultSizeAndMargin{
    
    _starWH = 34;
    _starMargin = 22;
}

- (instancetype)initWithFrame:(CGRect)frame starSize:(CGFloat)size autoResizeStarMargin:(BOOL)autoResizeMargin
{
    if (self = [super initWithFrame:frame]) {
        // 这个默认是星星，放到 设置星星的个数去执行星星背景了。
        _starWH = size; //default is 34
        
        if (autoResizeMargin) {
            //比例关系入下: 34 : 22  = _starWH : _starMargin
            _starMargin = (_starWH * 22)/34;
        }else
        {
            _starMargin = 22;
        }
    }
    return self;
}



- (void)layoutSubviews{
    
}

/// 设置这里的时候已经有了frame了
- (void)setBgWithName:(NSString *)name
{
    // 根据用户设置的size取值
    CGFloat H = _starWH ? _starWH : 34;
    CGFloat W = H;
    
    NSString *bgNname = [NSString stringWithFormat:@"%@_bg",name];
    
    for (int i = 0; i < 5; i++) {
        UIImageView *iv = [[UIImageView alloc] init];
        
        iv.frame = CGRectMake(0, 0, W, H);
        iv.center = self.center;
        if (i == 2) { // 中间星星就在中间
            // 无需操作
        }else
        {
            int index = i - 2;  // 其他的星星以 中间这个为准布局,左右倍数
            CGFloat deltaX = W + _starMargin;  // 每个星星偏差距离 星星宽度 + 22pt
            
            iv.xy_centerX = self.xy_centerX + (index * deltaX);
        }
        
        iv.image = [UIImage imageNamed:bgNname];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iv];
    }
    
}


- (void)setFgWithName:(NSString *)name
{
    // 根据用户设置的size取值
    CGFloat H = _starWH ? _starWH : 34;
    CGFloat W = H;
    
    for (int i = 0; i < _starCount; i++) {
        UIImageView *iv = [[UIImageView alloc] init];
        
        iv.frame = CGRectMake(0, 0, W, H);
        iv.center = self.center;
        if (i == 2) { // 中间星星就在中间
            // 无需操作
        }else
        {
            int index = i - 2;  // 其他的星星以 中间这个为准布局,左右倍数
            CGFloat deltaX = W + _starMargin;  // 每个星星偏差距离 星星宽度 + 22pt
            iv.xy_centerX = self.xy_centerX + (index * deltaX);
        }
        
        iv.image = [UIImage imageNamed:name];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iv];
    }
    
}

- (void)setStarCount:(NSInteger)starCount
{
    _starCount = starCount;
    // 1. 设置背景
    [self setBgWithName:@"icon_star"];
    
    // 2. 设置前景
    [self setFgWithName:@"icon_star"];
    
    // 如果是 0 颗星，就是要评价的状态，
    if(starCount == 0)
    {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapStarForAppraise:)];
            [obj addGestureRecognizer:tap];
        }];
    }
}

- (void)tapStarForAppraise:(UITapGestureRecognizer *)tap{
    // 设置用户点击星星数量
    UIImageView *iv = (UIImageView *)tap.view;
    NSUInteger idx = [self.subviews indexOfObject:iv];
    _starCount = idx + 1; // 供外界使用用户评价了几个星
    
    // 选中部分替换成黄色星星，后面不变
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (iv == obj) {
            for (int i = 0; i < idx + 1; i++) {
                UIImageView *starView = (UIImageView *)self.subviews[i];
                starView.image = [UIImage imageNamed:@"icon_star"];
            }
            
            for (NSUInteger i = idx + 1; i < 5; i++) {
                UIImageView *starView = (UIImageView *)self.subviews[i];
                starView.image = [UIImage imageNamed:@"icon_star_bg"];
            }
        }
    }];
}


// 用户自己设置的，
- (void)count:(NSInteger)count withName:(NSString *)name
{
    _starCount = count;
    // 1. 设置背景
    [self setBgWithName:name];
    
    // 2. 设置前景
    [self setFgWithName:name];
}



@end
