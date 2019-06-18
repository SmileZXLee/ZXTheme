//
//  ZXSwitchTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXSwitchTheme : NSObject
/**
 设置Switch的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置Switch的onTintColor
 */
@property(strong, nonatomic) UIColor *onTintColor;
/**
 设置Switch背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
