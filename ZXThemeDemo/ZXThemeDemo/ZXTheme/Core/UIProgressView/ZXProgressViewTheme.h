//
//  ZXProgressViewTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXProgressViewTheme : NSObject
/**
 设置ProgressView已加载的进度条颜色
 */
@property(strong, nonatomic) UIColor *progressTintColor;
/**
 设置ProgressView未加载的进度条颜色
 */
@property(strong, nonatomic) UIColor *trackTintColor;
/**
 设置ProgressView已加载的进度条图片
 */
@property(strong, nonatomic) UIImage *progressImage;
/**
 设置ProgressView未加载的进度条图片
 */
@property(strong, nonatomic) UIColor *trackImage;

@end

NS_ASSUME_NONNULL_END
