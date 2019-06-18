//
//  ZXButtonTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXButtonTheme : NSObject
/**
 设置按钮tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 根据状态设置按钮文字颜色
 
 @param color 按钮文字颜色
 @param state 按钮状态
 */
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮文字颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *titleColorMapper;

/**
 根据状态设置按钮文字阴影颜色
 
 @param color 文字阴影颜色
 @param state 按钮状态
 */
- (void)setTitleShadowColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮文字阴影颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *titleShadowColorMapper;
/**
 根据状态设置按钮图片
 
 @param image 按钮图片
 @param state 按钮状态
 */
- (void)setImage:(UIImage *)image forState:(UIControlState)state;
/**
 按钮图片与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *imageMapper;
/**
 根据状态设置按钮背景图片
 
 @param image 按钮背景图片
 @param state 按钮状态
 */
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
/**
 按钮背景图片与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *backgroundImageMapper;
/**
 根据状态设置按钮图片颜色
 
 @param color 按钮图片颜色
 @param state 按钮状态
 */
- (void)setImageColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮图片颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *imageColorMapper;

/**
 根据状态设置按钮背景图片颜色
 
 @param color 按钮背景图片颜色
 @param state 按钮状态
 */
- (void)setBackgroundImageColor:(UIColor *)color forState:(UIControlState)state;
/**
 按钮背景图片颜色与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *backgroundImageColorMapper;

/**
 设置按钮背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END
