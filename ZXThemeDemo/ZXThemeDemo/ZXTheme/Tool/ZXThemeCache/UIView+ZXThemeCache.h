//
//  UIView+ZXThemeCache.h
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/18.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZXThemeCache)
- (void)zx_saveThemeCache;
- (id)zx_readThemeCache;
@end

NS_ASSUME_NONNULL_END
