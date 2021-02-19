//
//  XYSwitch.m
//  myApp
//
//  Created by 渠晓友 on 2021/2/19.
//  Copyright © 2021 渠晓友. All rights reserved.
//

#import "XYSwitch.h"

@implementation XYSwitch

- (instancetype)init
{
    if (self = [super init]) {
        [self addTarget:self action:@selector(changeSeting:) forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

- (void)changeSeting:(UISwitch *)sender {
    if (self.settingKey) {
        [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:self.settingKey];
    }
    
    if (self.valueChangedHandler) {
        self.valueChangedHandler(sender.isOn);
    }
}

- (BOOL)settingValue
{
    if (!self.settingKey) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:self.settingKey];
}

@end
