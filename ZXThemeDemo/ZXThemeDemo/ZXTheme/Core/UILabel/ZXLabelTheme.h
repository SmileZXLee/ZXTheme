//
//  ZXLabelTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXLabelTheme : NSObject
/**
 设置文字颜色
 */
@property(strong, nonatomic) UIColor *textColor;
/**
 设置文字字体
 */
@property(strong, nonatomic) UIFont *font;
/**
 设置文字对齐方式
 */
@property(assign, nonatomic) NSTextAlignment textAlignment;
/**
 设置文字换行模式
 */
@property(assign, nonatomic) NSLineBreakMode lineBreakMode;
/**
 设置文字是否高亮
 */
@property(assign, nonatomic) BOOL highlighted;
/**
 设置文字高亮时候的颜色
 */
@property(strong, nonatomic) UIColor *highlightedTextColor;
/**
 设置文字是否根据宽度自动调整字体
 */
@property(assign, nonatomic) BOOL adjustsFontSizeToFitWidth;
/**
 设置文字最大行数
 */
@property(assign, nonatomic) long long numberOfLines;
/**
 设置文字背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END
