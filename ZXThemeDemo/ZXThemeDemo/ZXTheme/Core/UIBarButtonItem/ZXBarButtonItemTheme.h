//
//  ZXBarButtonItemTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/14.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXBarButtonItemTheme : NSObject
/**
 设置BarButtonItem的style
 */
@property(assign, nonatomic) UIBarButtonItemStyle style;
/**
 设置BarButtonItem的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置BarButtonItem的customView
 */
@property(strong, nonatomic) UIView *customView;
@end

NS_ASSUME_NONNULL_END
