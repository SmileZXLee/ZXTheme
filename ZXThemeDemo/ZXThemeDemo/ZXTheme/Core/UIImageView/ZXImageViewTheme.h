//
//  ZXImageViewTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXImageViewTheme : NSObject
/**
 设置ImageView的image
 */
@property(strong, nonatomic) UIImage *image;
/**
 设置ImageView的image颜色
 */
@property(strong, nonatomic) UIColor *imageColor;
/**
 设置ImageView的highlightedImage
 */
@property(strong, nonatomic) UIImage *highlightedImage;
/**
 设置ImageView的highlightedImage颜色
 */
@property(strong, nonatomic) UIColor *highlightedImageColor;
/**
 设置ImageView的动画image数组
 */
@property(strong, nonatomic) NSArray *animationImages;
/**
 设置ImageView的image数组的颜色
 */
@property(strong, nonatomic) UIColor *animationImagesColor;
/**
 设置ImageView的动画highlightedImage数组
 */
@property(strong, nonatomic) NSArray *highlightedAnimationImages;
/**
 设置ImageView的highlightedAnimationImages数组的颜色
 */
@property(strong, nonatomic) UIColor *highlightedAnimationImagesColor;
/**
 设置ImageView的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置ImageView背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
