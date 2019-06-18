//
//  UIImage+ZXTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZXTheme)

/**
 将UIImage渲染为指定颜色

 @param color 渲染颜色
 @return 渲染之后的UIImage
 */
- (UIImage*)renderColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
