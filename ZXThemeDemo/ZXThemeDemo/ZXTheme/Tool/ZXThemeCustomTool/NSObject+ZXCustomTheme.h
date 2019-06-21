//
//  NSObject+ZXCustomTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZXCustomTheme)

/**
 自定义Theme监听

 @param targetSel 目标方法
 @param handleSel 拦截之后的处理方法
 */
+ (void)zx_handleThemeWithTargetSelector:(SEL)targetSel handleSelector:(SEL)handleSel;
@end

NS_ASSUME_NONNULL_END
