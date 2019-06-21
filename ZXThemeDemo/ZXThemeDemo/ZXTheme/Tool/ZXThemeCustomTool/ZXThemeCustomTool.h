//
//  ZXThemeCustomTool.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/14.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXThemeCustomTool : NSObject
/**
 自定义Theme监听
 
 @param targetCls 目标类
 @param handleCls 处理类
 @param targetSel 目标方法
 @param handleSel 处理方法
 */
+ (void)zx_handleThemeWithTargetClass:(Class)targetCls handleClass:(Class)handleCls targetSelector:(SEL)targetSel handleSelector:(SEL)handleSel;
@end

NS_ASSUME_NONNULL_END
