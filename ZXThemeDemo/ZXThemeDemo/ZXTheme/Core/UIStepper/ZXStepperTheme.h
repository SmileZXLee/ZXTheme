//
//  ZXStepperTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXStepperTheme : NSObject
/**
 设置Stepper的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置Stepper背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
