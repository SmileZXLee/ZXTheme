//
//  UIPageControl+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIPageControl+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UIPageControl (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}

#pragma mark - UIPageControlReset
- (void)zx_setPageIndicatorTintColor:(UIColor *)set{
    [self zx_setPageIndicatorTintColor:ZXThemeData(ZXThemeTypePageControl)];
}
- (void)zx_setCurrentPageIndicatorTintColor:(UIColor *)set{
    [self zx_setCurrentPageIndicatorTintColor:ZXThemeData(ZXThemeTypePageControl)];
}

#pragma mark - UIPageControlThemeInit
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
    if([ZXTheme defaultTheme].zx_pageControlThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    };
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
