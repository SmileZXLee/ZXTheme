//
//  UILabel+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UILabel+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UILabel (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}
#pragma mark - UILabelThemeReset
- (void)zx_setTextColor:(UIColor *)set{
    if([self shouldIgnoreTheme]){
        [self zx_setTextColor:set];
        return;
    }
    [self zx_setTextColor:ZXThemeData(ZXThemeTypeLabel)];
}

- (void)zx_setFont:(UIFont *)set{
    if([self shouldIgnoreTheme]){
        [self zx_setFont:set];
        return;
    }
    [self zx_setFont:ZXThemeData(ZXThemeTypeLabel)];
}

- (void)zx_setTextAlignment:(NSTextAlignment)setValue{
    if([self shouldIgnoreTheme]){
        [self zx_setTextAlignment:setValue];
        return;
    }
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setTextAlignment:[ZXThemeData(ZXThemeTypeLabel) intValue]];
}

- (void)zx_setLineBreakMode:(NSLineBreakMode)setValue{
    if([self shouldIgnoreTheme]){
        [self zx_setLineBreakMode:setValue];
        return;
    }
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setLineBreakMode:[ZXThemeData(ZXThemeTypeLabel) intValue]];
}

- (void)zx_setHighlighted:(BOOL)setValue{
    if([self shouldIgnoreTheme]){
        [self zx_setHighlighted:setValue];
        return;
    }
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setHighlighted:[ZXThemeData(ZXThemeTypeLabel) intValue]];
}

- (void)zx_setHighlightedTextColor:(UIColor *)set{
    if([self shouldIgnoreTheme]){
        [self zx_setHighlightedTextColor:set];
        return;
    }
    [self zx_setHighlightedTextColor:ZXThemeData(ZXThemeTypeLabel)];
}

- (void)zx_setAdjustsFontSizeToFitWidth:(BOOL)setValue{
    if([self shouldIgnoreTheme]){
        [self zx_setAdjustsFontSizeToFitWidth:setValue];
        return;
    }
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setAdjustsFontSizeToFitWidth:[ZXThemeData(ZXThemeTypeLabel) intValue]];
}

- (void)zx_setNumberOfLines:(long long)setValue{
    if([self shouldIgnoreTheme]){
        [self zx_setNumberOfLines:setValue];
        return;
    }
    id set = [NSNumber numberWithLongLong:setValue];
    [self zx_setNumberOfLines:[ZXThemeData(ZXThemeTypeLabel) longLongValue]];
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    if([self shouldIgnoreTheme]){
        [self zx_setBackgroundColor:set];
        return;
    }
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeLabel)];
}

#pragma mark - UILabelThemeInit
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
    if([ZXTheme defaultTheme].zx_labelThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    }
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
}

#pragma mark - Judge
- (BOOL)zx_belongsToBtn{
    return [self isKindOfClass:NSClassFromString(@"UIButtonLabel")];
}

- (BOOL)zx_belongsToTextFieldPlaceholder{
    return [self isKindOfClass:NSClassFromString(@"UITextFieldLabel")];
}

#pragma mark - Private
- (BOOL)shouldIgnoreTheme{
    return NO;
    //return self.zx_belongsToBtn || self.zx_belongsToTextFieldPlaceholder;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
