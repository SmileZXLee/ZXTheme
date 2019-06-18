//
//  UIActivityIndicatorView+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIActivityIndicatorView+ZXTheme.h"
#import "ZXThemeTool.h"

@implementation UIActivityIndicatorView (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}

#pragma mark - UIActivityIndicatorViewReset
- (void)zx_setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle )setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setActivityIndicatorViewStyle:[ZXThemeData(ZXThemeTypeActivityIndicatorView) intValue]];
}
- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeSwitch)];
}

#pragma mark - UIActivityIndicatorViewThemeInit
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
    if([ZXTheme defaultTheme].zx_activityIndicatorViewThemeBlock){
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
