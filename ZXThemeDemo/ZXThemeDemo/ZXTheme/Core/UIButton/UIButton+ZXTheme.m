//
//  UIButton+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIButton+ZXTheme.h"
#import "ZXThemeTool.h"
#import "ZXButtonTheme.h"
@implementation UIButton (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}
#pragma mark - UIButtonThemeReset
- (void)zx_setTintColor:(UIColor *)set{
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeButton)];
}

- (void)zx_setTitleShadowColor:(UIColor *)set{
    [self zx_setTitleShadowColor:ZXThemeData(ZXThemeTypeButton)];
}

- (void)zx_setTitleColor:(UIColor *)color forState:(UIControlState)state{
    if([ZXTheme defaultTheme].zx_buttonThemeBlock){
        ZXButtonTheme *buttonTheme = [ZXTheme defaultTheme].zx_buttonThemeBlock(self);
        NSMutableDictionary *titleColorMapper = buttonTheme.titleColorMapper;
        UIColor *themeColor = [self handleBtnContentWithState:state mapper:titleColorMapper];
        if(themeColor){
            color = themeColor;
        }
    }
    [self zx_setTitleColor:color forState:state];
}

- (void)zx_setTitleShadowColor:(UIColor *)color forState:(UIControlState)state{
    if([ZXTheme defaultTheme].zx_buttonThemeBlock){
        ZXButtonTheme *buttonTheme = [ZXTheme defaultTheme].zx_buttonThemeBlock(self);
        NSMutableDictionary *titleShadowColorMapper = buttonTheme.titleShadowColorMapper;
        UIColor *themeColor = [self handleBtnContentWithState:state mapper:titleShadowColorMapper];
        if(themeColor){
            color = themeColor;
        }
    }
    [self zx_setTitleShadowColor:color forState:state];
}

- (void)zx_setImage:(UIImage *)image forState:(UIControlState)state{
    if([ZXTheme defaultTheme].zx_buttonThemeBlock){
        ZXButtonTheme *buttonTheme = [ZXTheme defaultTheme].zx_buttonThemeBlock(self);
        NSMutableDictionary *imageMapper = buttonTheme.imageMapper;
        NSMutableDictionary *imageColorMapper = buttonTheme.imageColorMapper;
        UIImage *themeImage = [self handleBtnContentWithState:state mapper:imageMapper];
        if(themeImage){
            if(imageColorMapper){
                UIColor *themeImageColor = [self handleBtnContentWithState:state mapper:imageColorMapper];
                if(themeImageColor){
                    themeImage = [themeImage renderColor:themeImageColor];
                }
            }
            image = themeImage;
        }
    }
    [self zx_setImage:image forState:state];
}

- (void)zx_setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    if([ZXTheme defaultTheme].zx_buttonThemeBlock){
        ZXButtonTheme *buttonTheme = [ZXTheme defaultTheme].zx_buttonThemeBlock(self);
        NSMutableDictionary *backgroundImageMapper = buttonTheme.backgroundImageMapper;
        NSMutableDictionary *backgroundImageColorMapper = buttonTheme.backgroundImageColorMapper;
        UIImage *themeImage = [self handleBtnContentWithState:state mapper:backgroundImageMapper];
        if(themeImage){
            if(backgroundImageColorMapper){
                UIColor *themeImageColor = [self handleBtnContentWithState:state mapper:backgroundImageColorMapper];
                if(themeImageColor){
                    themeImage = [themeImage renderColor:themeImageColor];
                }
            }
            image = themeImage;
        }
    }
    [self zx_setBackgroundImage:image forState:state];
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeButton)];
}
#pragma mark - UIButtonThemeInit
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
    if([ZXTheme defaultTheme].zx_buttonThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    }
    
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
    [self setTitleColor:self.currentTitleColor forState:self.state];
    [self setTitleColor:[self titleColorForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self setTitleShadowColor:self.currentTitleShadowColor forState:self.state];
    [self setTitleColor:[self titleShadowColorForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:self.state];
    [self setImage:[self imageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [self setBackgroundImage:self.currentBackgroundImage forState:self.state];
    [self setBackgroundImage:[self backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    
}

#pragma mark - Private
- (id)handleBtnContentWithState:(UIControlState)state mapper:(NSMutableDictionary *)mapper{
    NSNumber *themeKey = [NSNumber numberWithInt:state];
    if([mapper.allKeys containsObject:themeKey]){
        UIColor *themeColor = mapper[themeKey];
        return themeColor;
    }
    return nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
