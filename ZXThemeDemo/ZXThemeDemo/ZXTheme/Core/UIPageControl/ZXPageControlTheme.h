//
//  ZXPageControlTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXPageControlTheme : NSObject
/**
 设置PageControl其他页的颜色
 */
@property(strong, nonatomic) UIColor *pageIndicatorTintColor;
/**
 设置PageControl当前页的颜色
 */
@property(strong, nonatomic) UIColor *currentPageIndicatorTintColor;

@end

NS_ASSUME_NONNULL_END
