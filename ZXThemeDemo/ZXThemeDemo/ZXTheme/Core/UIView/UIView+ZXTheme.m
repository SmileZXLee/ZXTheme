//
//  UIView+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIView+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UIView (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_exchangeInstanceMethodWithTargetCls:self oldSel:@selector(setBackgroundColor:) newSel:@selector(zx_setBackgroundColor_view:)];
    [ZXThemeRuntime zx_exchangeInstanceMethodWithTargetCls:self oldSel:@selector(initWithCoder:) newSel:@selector(zx_initWithCoder_view:)];
    [ZXThemeRuntime zx_exchangeInstanceMethodWithTargetCls:self oldSel:@selector(initWithFrame:) newSel:@selector(zx_initWithFrame_view:)];
}
#pragma mark - UIViewThemeReset

- (void)zx_setBackgroundColor_view:(UIColor *)set{
    
    [self zx_setBackgroundColor_view:ZXThemeData(ZXThemeTypeView)];
}
#pragma mark - UIViewThemeInit
- (instancetype)zx_initWithCoder_view:(NSCoder *)aDecoder{
    id selfIns = [self zx_initWithCoder_view:aDecoder];
    [self zx_initAction];
    return selfIns;
}

- (instancetype)zx_initWithFrame_view:(CGRect)rect{
    id selfIns = [self zx_initWithFrame_view:rect];
    [self zx_initAction];
    return selfIns;
}

- (void)zx_initAction{
    if([ZXTheme defaultTheme].zx_viewThemeBlock){
        [self triggerSetTheme_view];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme_view) name:ZXThemeUpdateNotification object:nil];
    }
    
}
- (void)triggerSetTheme_view{
    [ZXThemeRuntime addThemeTrigger:self];
}


- (UIViewController*)zx_getViewController{
    for(UIView *nextV = [self superview]; nextV; nextV = nextV.superview) {
        UIResponder* nextR = [nextV nextResponder];
        if ([nextR isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextR;
        }
    }
    return nil;
}

- (BOOL)zx_inViewClass:(Class)cls{
    for(UIView *nextV = [self superview]; nextV; nextV = nextV.superview) {
        UIResponder* nextR = [nextV nextResponder];
        if ([nextR isKindOfClass:cls]) {
            return YES;
        }
    }
    return NO;
}

@end
