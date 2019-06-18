//
//  UITextView+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UITextView+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UITextView (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}
#pragma mark - UITextViewThemeReset
- (void)zx_setTextColor:(UIColor *)set{
    [self zx_setTextColor:ZXThemeData(ZXThemeTypeTextView)];
}

- (void)zx_setFont:(UIFont *)set{
    [self zx_setFont:ZXThemeData(ZXThemeTypeTextView)];
}

- (void)zx_setTextAlignment:(NSTextAlignment)setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setTextAlignment:[ZXThemeData(ZXThemeTypeTextView) intValue]];
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeTextView)];
}
#pragma mark - UITextViewThemeInit
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
    if([ZXTheme defaultTheme].zx_textViewThemeBlock){
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
