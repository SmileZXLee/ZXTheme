//
//  ZXTextViewTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXTextViewTheme : NSObject
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
 设置背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
