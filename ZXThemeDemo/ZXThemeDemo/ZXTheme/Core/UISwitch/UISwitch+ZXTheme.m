//
//  UISwitch+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UISwitch+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UISwitch (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}

#pragma mark - UISwitchReset
- (void)zx_setTintColor:(UIColor *)set{
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeSwitch)];
}
- (void)zx_setOnTintColor:(UIColor *)set{
    [self zx_setOnTintColor:ZXThemeData(ZXThemeTypeSwitch)];
}
- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeSwitch)];
}
#pragma mark - UISwitchThemeInit
- (instancetype)zx_initWithCoder:(NSCoder *)aDecoder{
    id selfIns = [self zx_initWithCoder:aDecoder];
    [self zx_initAction];
    return selfIns;
}

- (instancetype)zx_initWithFrame:(CGRect)rect{
    id selfIns = [self zx_initWithFrame:rect];
    [self zx_initAction];
    return selfIns;
}

- (void)zx_initAction{
    if([ZXTheme defaultTheme].zx_switchThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    }
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
