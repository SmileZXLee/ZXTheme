//
//  ZXTextFieldTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXTextFieldTheme : NSObject
/**
 设置TextField颜色
 */
@property(strong, nonatomic) UIColor *textColor;
/**
 设置TextField字体
 */
@property(strong, nonatomic) UIFont *font;
/**
 设置TextField对齐方式
 */
@property(assign, nonatomic) NSTextAlignment textAlignment;
/**
 设置TextField的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置TextField的placeholder颜色
 */
@property(strong, nonatomic) UIColor *placeholderColor;
/**
 设置TextField的背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
