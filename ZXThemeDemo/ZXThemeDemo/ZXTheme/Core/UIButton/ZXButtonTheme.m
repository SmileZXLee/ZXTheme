//
//  ZXButtonTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXButtonTheme.h"
@interface ZXButtonTheme()
@end
@implementation ZXButtonTheme
- (instancetype)init{
    if(self = [super init]){
        _titleColorMapper = [NSMutableDictionary dictionary];
        _titleShadowColorMapper = [NSMutableDictionary dictionary];
        _imageMapper = [NSMutableDictionary dictionary];
        _backgroundImageMapper = [NSMutableDictionary dictionary];
        _imageColorMapper = [NSMutableDictionary dictionary];
        _backgroundImageColorMapper = [NSMutableDictionary dictionary];
    }
    return self;
}
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state{
    [self.titleColorMapper setObject:color forKey:[NSNumber numberWithInt:state]];
}

- (void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state{
    [self.titleShadowColorMapper setObject:color forKey:[NSNumber numberWithInt:state]];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [self.imageMapper setObject:image forKey:[NSNumber numberWithInt:state]];
}

- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    [self.backgroundImageMapper setObject:image forKey:[NSNumber numberWithInt:state]];
}

- (void)setImageColor:(UIColor *)color forState:(UIControlState)state{
    [self.imageColorMapper setObject:color forKey:[NSNumber numberWithInt:state]];
}

- (void)setBackgroundImageColor:(UIColor *)color forState:(UIControlState)state{
    [self.backgroundImageColorMapper setObject:color forKey:[NSNumber numberWithInt:state]];
}
@end
