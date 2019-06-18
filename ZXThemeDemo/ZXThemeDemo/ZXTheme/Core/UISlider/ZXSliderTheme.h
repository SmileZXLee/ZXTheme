//
//  ZXSliderTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXSliderTheme : NSObject
/**
 设置Slider左侧背景颜色
 */
@property(strong, nonatomic) UIColor *minimumTrackTintColor;
/**
 设置Slider右侧背景颜色
 */
@property(strong, nonatomic) UIColor *maximumTrackTintColor;
/**
 设置Slider滑块颜色
 */
@property(strong, nonatomic) UIColor *thumbTintColor;
/**
 设置Slider左侧图片
 */
@property(strong, nonatomic) UIImage *minimumValueImage;
/**
 设置Slider右侧图片
 */
@property(strong, nonatomic) UIImage *maximumValueImage;
/**
 设置Slider背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
