//
//  UIView+ZXTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZXTheme)

/**
 获取view所属的控制器

 @return view所属的控制器
 */
- (UIViewController*)zx_getViewController;

/**
 判断当前view是否是目标view类的子类(包含子类递归)

 @param cls 目标view的类
 @return 当前view是否是目标view类的子类(包含子类递归)
 */
- (BOOL)zx_inViewClass:(Class)cls;
@end

NS_ASSUME_NONNULL_END
