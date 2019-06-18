//
//  ZXActivityIndicatorViewTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/31.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZXActivityIndicatorViewTheme : NSObject


/**
 设置ActivityIndicatorView样式
 */
@property(assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/**
 设置ActivityIndicatorView背景颜色
 */
@property(strong, nonatomic) UIColor *backgroundColor;
@end

NS_ASSUME_NONNULL_END
