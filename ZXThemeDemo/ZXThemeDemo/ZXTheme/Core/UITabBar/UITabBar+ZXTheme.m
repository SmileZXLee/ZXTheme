//
//  UITabBar+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UITabBar+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UITabBar (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}
#pragma mark - UITabBarThemeReset
- (void)zx_setTintColor:(UIColor *)set{
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeTabBar)];
}

- (void)zx_setTranslucent:(BOOL)setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setTranslucent:[ZXThemeData(ZXThemeTypeTabBar) intValue]];
}

- (void)zx_setBarTintColor:(UIColor *)set{
    [self zx_setBarTintColor:ZXThemeData(ZXThemeTypeTabBar)];
}

- (void)zx_setBackgroundImage:(UIImage *)set{
    [self zx_setBackgroundImage:ZXThemeData(ZXThemeTypeTabBar)];
}

- (void)zx_setSelectionIndicatorImage:(UIImage *)set{
    [self zx_setSelectionIndicatorImage:ZXThemeData(ZXThemeTypeTabBar)];
}

- (void)zx_setShadowImage:(UIImage *)set{
    [self zx_setShadowImage:ZXThemeData(ZXThemeTypeTabBar)];
}
#pragma mark - UITabBarThemeInit
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
    if([ZXTheme defaultTheme].zx_tabBarThemeBlock){
        [self triggerSetTheme];
        
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
}
- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
