//
//  ZXTabBarItemTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXTabBarItemTheme : NSObject
/**
 设置TabBarItem的image
 */
@property(strong, nonatomic) UIImage *image;
/**
 设置TabBarItem的image颜色
 */
@property(strong, nonatomic) UIColor *imageColor;
/**
 设置TabBarItem的selectedImage
 */
@property(strong, nonatomic) UIImage *selectedImage;
/**
 设置TabBarItem的selectedImage颜色
 */
@property(strong, nonatomic) UIColor *selectedImageColor;

/**
 根据状态设置TabBarItem文字属性
 
 @param attributes 文字阴影颜色
 @param state 按钮状态
 */
- (void)setTitleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attributes forState:(UIControlState)state;
/**
 TabBarItem文字属性与状态映射的字典
 */
@property(strong, nonatomic,readonly) NSMutableDictionary *titleTextAttributesMapper;
@end

NS_ASSUME_NONNULL_END
