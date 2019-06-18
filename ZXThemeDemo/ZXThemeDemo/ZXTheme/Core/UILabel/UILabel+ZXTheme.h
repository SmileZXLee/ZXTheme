//
//  UILabel+ZXTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ZXTheme)
/**
 是否属于UIButton
 */
@property(assign, nonatomic,readonly) BOOL zx_belongsToBtn;

/**
 是否属于UITextField中的placeholder
 */
@property(assign, nonatomic,readonly) BOOL zx_belongsToTextFieldPlaceholder;
@end

NS_ASSUME_NONNULL_END
