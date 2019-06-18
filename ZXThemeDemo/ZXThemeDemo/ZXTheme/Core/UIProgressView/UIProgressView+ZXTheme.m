//
//  UIProgressView+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIProgressView+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UIProgressView (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}

#pragma mark - UIProgressViewReset
- (void)zx_setProgressTintColor:(UIColor *)set{
    [self zx_setProgressTintColor:ZXThemeData(ZXThemeTypeProgressView)];
}
- (void)zx_setTrackTintColor:(UIColor *)set{
    [self zx_setTrackTintColor:ZXThemeData(ZXThemeTypeProgressView)];
}
- (void)zx_setProgressImage:(UIImage *)set{
    [self zx_setProgressImage:ZXThemeData(ZXThemeTypeProgressView)];
}
- (void)zx_setTrackImage:(UIImage *)set{
    [self zx_setTrackImage:ZXThemeData(ZXThemeTypeProgressView)];
}

#pragma mark - UIProgressViewThemeInit
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
    if([ZXTheme defaultTheme].zx_progressViewThemeBlock){
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
