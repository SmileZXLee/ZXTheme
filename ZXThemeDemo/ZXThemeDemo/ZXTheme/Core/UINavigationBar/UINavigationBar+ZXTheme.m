//
//  UINavigationBar+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UINavigationBar+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UINavigationBar (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}
#pragma mark - UINavigationBarThemeReset
- (void)zx_setTintColor:(UIColor *)set{
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeNavigationBar)];
}

- (void)zx_setTranslucent:(BOOL)setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setTranslucent:[ZXThemeData(ZXThemeTypeNavigationBar) intValue]];
}

- (void)zx_setBarTintColor:(UIColor *)set{
    [self zx_setBarTintColor:ZXThemeData(ZXThemeTypeNavigationBar)];
}

- (void)zx_setShadowImage:(UIImage *)set{
    [self zx_setShadowImage:ZXThemeData(ZXThemeTypeNavigationBar)];
}

- (void)zx_setTitleTextAttributes:(NSDictionary *)set{
    [self zx_setTitleTextAttributes:ZXThemeData(ZXThemeTypeNavigationBar)];
}
#pragma mark - UINavigationBarThemeInit
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
    if([ZXTheme defaultTheme].zx_navigationBarThemeBlock){
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
