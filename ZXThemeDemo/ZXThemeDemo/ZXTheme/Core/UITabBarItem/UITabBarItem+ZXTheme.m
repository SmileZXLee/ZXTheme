//
//  UITabBarItem+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UITabBarItem+ZXTheme.h"
#import "ZXThemeTool.h"
#import "ZXTabBarItemTheme.h"
@implementation UITabBarItem (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
    
}
#pragma mark - UITabBarItemThemeReset

- (void)zx_setImage:(UIImage *)image{
    if([ZXTheme defaultTheme].zx_tabBarItemThemeBlock){
        ZXTabBarItemTheme *tabBarItemTheme = [ZXTheme defaultTheme].zx_tabBarItemThemeBlock(self);
        UIColor *imageColor = tabBarItemTheme.imageColor;
        if(imageColor){
            image = [image renderColor:imageColor];
        }
    }
    [self zx_setImage:image];
}

- (void)zx_setSelectedImage:(UIImage *)image{
    if([ZXTheme defaultTheme].zx_tabBarItemThemeBlock){
        ZXTabBarItemTheme *tabBarItemTheme = [ZXTheme defaultTheme].zx_tabBarItemThemeBlock(self);
        UIColor *selectedImageColor = tabBarItemTheme.selectedImageColor;
        if(selectedImageColor){
            image = [image renderColor:selectedImageColor];
        }
    }
    [self zx_setSelectedImage:image];
}

- (void)zx_setTitleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attributes forState:(UIControlState)state{
    if([ZXTheme defaultTheme].zx_tabBarItemThemeBlock){
        ZXTabBarItemTheme *tabBarItemTheme = [ZXTheme defaultTheme].zx_tabBarItemThemeBlock(self);
        NSMutableDictionary *titleTextAttributesMapper = tabBarItemTheme.titleTextAttributesMapper;
        UIImage *textAttributes = [self handleBtnContentWithState:state mapper:titleTextAttributesMapper];
        if(textAttributes){
            attributes = [textAttributes mutableCopy];
        }
    }
    [self zx_setTitleTextAttributes:attributes forState:state];
}

#pragma mark - UITabBarItemThemeInit
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
    if([ZXTheme defaultTheme].zx_tabBarItemThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    }
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
    [self setTitleTextAttributes:[self titleTextAttributesForState:UIControlStateNormal] forState:UIControlStateNormal];
    
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
