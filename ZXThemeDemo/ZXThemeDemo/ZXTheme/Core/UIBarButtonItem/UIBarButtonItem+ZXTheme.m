//
//  UIBarButtonItem+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/14.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIBarButtonItem+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UIBarButtonItem (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}
#pragma mark - UIBarButtonItemThemeReset
- (void)zx_setStyle:(UIBarButtonItemStyle)setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setStyle:[ZXThemeData(ZXThemeTypeBarButtonItem) intValue]];
}

- (void)zx_setTintColor:(UIColor *)set{
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeBarButtonItem)];
}

- (void)zx_setCustomView:(UIView *)set{
    [self zx_setCustomView:ZXThemeData(ZXThemeTypeBarButtonItem)];
}

#pragma mark - UIBarButtonItemThemeInit
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
    if([ZXTheme defaultTheme].zx_barButtonItemThemeBlock){
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
