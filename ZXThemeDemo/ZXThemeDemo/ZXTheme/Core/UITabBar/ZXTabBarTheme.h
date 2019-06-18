//
//  ZXTabBarTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXTabBarTheme : NSObject
/**
 设置Tabbar的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置Tabbar是否透明
 */
@property(assign, nonatomic) BOOL translucent;
/**
 设置Tabbar的背景色
 */
@property(strong, nonatomic) UIColor *barTintColor;
/**
 设置Tabbar的背景图片
 */
@property(strong, nonatomic) UIImage *backgroundImage;
/**
 设置Tabbar的selectionIndicatorImage
 */
@property(strong, nonatomic) UIImage *selectionIndicatorImage;
/**
 设置Tabbar的shadowImage
 */
@property(strong, nonatomic) UIImage *shadowImage;
@end

NS_ASSUME_NONNULL_END
