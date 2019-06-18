//
//  UIImageView+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIImageView+ZXTheme.h"
#import "ZXThemeTool.h"
@implementation UIImageView (ZXTheme)
+ (void)load{
    [ZXThemeRuntime zx_addThemeHook:self];
}

#pragma mark - UIImageViewReset
- (void)zx_setImage:(UIImage *)set{
    if([ZXTheme defaultTheme].zx_imageViewThemeBlock){
        ZXImageViewTheme *theme = [ZXTheme defaultTheme].zx_imageViewThemeBlock(self);
        if(theme.imageColor && set && ![self shouldIgnoreTheme]){
            set = [set renderColor:theme.imageColor];
        }
    }
    [self zx_setImage:ZXThemeData(ZXThemeTypeImageView)];
}

- (void)zx_setHighlightedImage:(UIImage *)set{
    if([ZXTheme defaultTheme].zx_imageViewThemeBlock){
        ZXImageViewTheme *theme = [ZXTheme defaultTheme].zx_imageViewThemeBlock(self);
        if(theme.highlightedImageColor && set && ![self shouldIgnoreTheme]){
            set = [set renderColor:theme.highlightedImageColor];
        }
    }
    [self zx_setHighlightedImage:ZXThemeData(ZXThemeTypeImageView)];
}

- (void)zx_setAnimationImages:(NSArray *)set{
    if([ZXTheme defaultTheme].zx_imageViewThemeBlock){
        ZXImageViewTheme *theme = [ZXTheme defaultTheme].zx_imageViewThemeBlock(self);
        if(theme.animationImagesColor && set.count && ![self shouldIgnoreTheme]){
            NSMutableArray *setedArr = [NSMutableArray array];
            for (UIImage *img in set) {
                UIImage *resImg = [img renderColor:theme.animationImagesColor];
                [setedArr addObject:resImg];
            }
            set = [setedArr mutableCopy];
        }
    }
    [self zx_setAnimationImages:ZXThemeData(ZXThemeTypeImageView)];
}

- (void)zx_setHighlightedAnimationImages:(NSArray *)set{
    if([ZXTheme defaultTheme].zx_imageViewThemeBlock){
        ZXImageViewTheme *theme = [ZXTheme defaultTheme].zx_imageViewThemeBlock(self);
        if(theme.highlightedAnimationImagesColor && set.count && ![self shouldIgnoreTheme]){
            NSMutableArray *setedArr = [NSMutableArray array];
            for (UIImage *img in set) {
                UIImage *resImg = [img renderColor:theme.highlightedAnimationImagesColor];
                [setedArr addObject:resImg];
            }
            set = [setedArr mutableCopy];
        }
    }
    [self zx_setHighlightedAnimationImages:ZXThemeData(ZXThemeTypeImageView)];
}

- (void)zx_setTintColor:(UIColor *)set{
    if([self shouldIgnoreTheme]){
        [self zx_setTintColor:set];
        return;
    }
    [self zx_setTintColor:ZXThemeData(ZXThemeTypeImageView)];
}


- (void)zx_setBackgroundColor:(UIColor *)set{
    if([self shouldIgnoreTheme]){
        [self zx_setBackgroundColor:set];
        return;
    }
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeImageView)];
}
#pragma mark - UIImageViewThemeInit
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
    if([ZXTheme defaultTheme].zx_imageViewThemeBlock){
        [self triggerSetTheme];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    }
}

- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
}

#pragma mark - Judge
- (BOOL)zx_belongsToBtn{
    return [self.nextResponder isKindOfClass:NSClassFromString(@"UIButton")];
}


#pragma mark - Private
- (BOOL)shouldIgnoreTheme{
    return NO;
    //return self.zx_belongsToBtn;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
