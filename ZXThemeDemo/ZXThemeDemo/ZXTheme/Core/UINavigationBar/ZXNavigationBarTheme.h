//
//  ZXNavigationBarTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXNavigationBarTheme : NSObject
/**
 设置NavigationBar的tintColor
 */
@property(strong, nonatomic) UIColor *tintColor;
/**
 设置NavigationBar是否透明
 */
@property(assign, nonatomic) BOOL translucent;
/**
 设置NavigationBar的背景色
 */
@property(strong, nonatomic) UIColor *barTintColor;
/**
 设置NavigationBar的shadowImage
 */
@property(strong, nonatomic) UIImage *shadowImage;
/**
 设置NavigationBar的titleTextAttributes
 */
@property(strong, nonatomic) NSDictionary<NSAttributedStringKey, id> *titleTextAttributes;

@end

NS_ASSUME_NONNULL_END
