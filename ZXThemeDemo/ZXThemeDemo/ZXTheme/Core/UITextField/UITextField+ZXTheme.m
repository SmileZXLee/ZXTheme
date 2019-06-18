//
//  UITextField+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UITextField+ZXTheme.h"
#import "ZXThemeTool.h"

@implementation UITextField (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
    [ZXThemeRuntime zx_exchangeInstanceMethodWithTargetCls:self oldSel:@selector(setValue:forKeyPath:) newSel:@selector(zx_setValue:forKeyPath:)];
}

#pragma mark - UILabelThemeReset
- (void)zx_setTextColor:(UIColor *)set{
    [self zx_setTextColor:ZXThemeData(ZXThemeTypeTextField)];
}

- (void)zx_setFont:(UIFont *)set{
    [self zx_setFont:ZXThemeData(ZXThemeTypeTextField)];
}

- (void)zx_setTextAlignment:(NSTextAlignment)setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setTextAlignment:[ZXThemeData(ZXThemeTypeTextField) intValue]];
}

- (void)zx_setTintColor:(UIColor *)set{
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeTextField)];
}

- (void)zx_setValue:(id)value forKeyPath:(id)keyPath{
    if([keyPath isEqualToString:@"_placeholderLabel.textColor"]){
        if([ZXTheme defaultTheme].zx_textFieldThemeBlock){
            ZXTextFieldTheme *textFieldTheme = [ZXTheme defaultTheme].zx_textFieldThemeBlock(self);
            if(textFieldTheme.placeholderColor){
                value = textFieldTheme.placeholderColor;
            }
        }
    }
    [self zx_setValue:value forKeyPath:keyPath];
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeTextField)];
}
#pragma mark - UISegmentedControlThemeInit
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
    if([ZXTheme defaultTheme].zx_textFieldThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    }
    
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
    [self setValue:[self valueForKeyPath:@"placeholderLabel.textColor"] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
