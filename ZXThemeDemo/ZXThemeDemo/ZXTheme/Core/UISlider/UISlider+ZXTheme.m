//
//  UISlider+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UISlider+ZXTheme.h"
#import "ZXThemeTool.h"

@implementation UISlider (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}

#pragma mark - UISliderControlReset
- (void)zx_setMinimumTrackTintColor:(UIColor *)set{
    [self zx_setMinimumTrackTintColor:ZXThemeData(ZXThemeTypeSlider)];
}

- (void)zx_setMaximumTrackTintColor:(UIColor *)set{
    [self zx_setMaximumTrackTintColor:ZXThemeData(ZXThemeTypeSlider)];
}

- (void)zx_setThumbTintColor:(UIColor *)set{
    [self zx_setThumbTintColor:ZXThemeData(ZXThemeTypeSlider)];
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeSlider)];
}

- (void)zx_setMinimumValueImage:(UIImage *)set{
    [self zx_setMinimumValueImage:ZXThemeData(ZXThemeTypeSlider)];
}

- (void)zx_setMaximumValueImage:(UIImage *)set{
    [self zx_setMaximumValueImage:ZXThemeData(ZXThemeTypeSlider)];
}
#pragma mark - UISliderThemeInit
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
    if([ZXTheme defaultTheme].zx_sliderThemeBlock){
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
