//
//  ZXTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZXThemeDefind.h"
#import "UIView+ZXTheme.h"
#import "UILabel+ZXTheme.h"
#import "NSObject+ZXCustomTheme.h"

#import "ZXViewTheme.h"
#import "ZXLabelTheme.h"
#import "ZXButtonTheme.h"
#import "ZXSegmentedControlTheme.h"
#import "ZXTextFieldTheme.h"
#import "ZXSliderTheme.h"
#import "ZXSwitchTheme.h"
#import "ZXActivityIndicatorViewTheme.h"
#import "ZXProgressViewTheme.h"
#import "ZXPageControlTheme.h"
#import "ZXStepperTheme.h"
#import "ZXImageViewTheme.h"
#import "UIImage+ZXTheme.h"
#import "ZXTextViewTheme.h"
#import "ZXTabBarTheme.h"
#import "ZXTabBarItemTheme.h"
#import "ZXNavigationBarTheme.h"
#import "ZXBarButtonItemTheme.h"
#import "ZXTableViewTheme.h"
#import "ZXCollectionViewTheme.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZXTheme : NSObject
+ (instancetype)defaultTheme;
/**
 是否是暗黑主题
 */
@property(assign, nonatomic, getter=zx_isDarkTheme)BOOL zx_darkTheme;
/**
 发送主题更新通知
 */
- (void)zx_themeUpdate;
/**
 设置UIView的主题
 */
@property(copy, nonatomic)ZXViewTheme *(^zx_viewThemeBlock)(UIView *view);
/**
 设置UILabel的主题
 */
@property(copy, nonatomic)ZXLabelTheme *(^zx_labelThemeBlock)(UILabel *label);
/**
 设置UIButton的主题
 */
@property(copy, nonatomic)ZXButtonTheme *(^zx_buttonThemeBlock)(UIButton *button);
/**
 设置UISegmentedControl的主题
 */
@property(copy, nonatomic)ZXSegmentedControlTheme *(^zx_segmentedControlThemeBlock)(UISegmentedControl *segmentedControl);
/**
 设置UITextField的主题
 */
@property(copy, nonatomic)ZXTextFieldTheme *(^zx_textFieldThemeBlock)(UITextField *textField);
/**
 设置UISlider的主题
 */
@property(copy, nonatomic)ZXSliderTheme *(^zx_sliderThemeBlock)(UISlider *slider);
/**
 设置UISwitch的主题
 */
@property(copy, nonatomic)ZXSwitchTheme *(^zx_switchThemeBlock)(UISwitch *mySwitch);
/**
 设置UIActivityIndicatorView的主题
 */
@property(copy, nonatomic)ZXActivityIndicatorViewTheme *(^zx_activityIndicatorViewThemeBlock)(UIActivityIndicatorView *activityIndicatorView);
/**
 设置UIProgressView的主题
 */
@property(copy, nonatomic)ZXProgressViewTheme *(^zx_progressViewThemeBlock)(UIProgressView *progressView);
/**
 设置UIPageControl的主题
 */
@property(copy, nonatomic)ZXPageControlTheme *(^zx_pageControlThemeBlock)(UIPageControl *pageControl);
/**
 设置UIStepper的主题
 */
@property(copy, nonatomic)ZXStepperTheme *(^zx_stepperThemeBlock)(UIStepper *stepper);
/**
 设置UIImageView的主题
 */
@property(copy, nonatomic)ZXImageViewTheme *(^zx_imageViewThemeBlock)(UIImageView *imageView);
/**
 设置UITextView的主题
 */
@property(copy, nonatomic)ZXTextViewTheme *(^zx_textViewThemeBlock)(UITextView *textView);
/**
 设置UITabBar的主题
 */
@property(copy, nonatomic)ZXTabBarTheme *(^zx_tabBarThemeBlock)(UITabBar *tabBar);
/**
 设置UITabBarItem的主题
 */
@property(copy, nonatomic)ZXTabBarItemTheme *(^zx_tabBarItemThemeBlock)(UITabBarItem *tabBarItem);
/**
 设置UINavigationBar的主题
 */
@property(copy, nonatomic)ZXNavigationBarTheme *(^zx_navigationBarThemeBlock)(UINavigationBar *navigationBar);
/**
 设置UIBarButtonItem的主题
 */
@property(copy, nonatomic)ZXBarButtonItemTheme *(^zx_barButtonItemThemeBlock)(UIBarButtonItem *barButtonItem);
/**
 设置UITableView的主题
 */
@property(copy, nonatomic)ZXTableViewTheme *(^zx_tableViewThemeBlock)(UITableView *tableView);
/**
 设置UICollectionView的主题
 */
@property(copy, nonatomic)ZXCollectionViewTheme *(^zx_collectionViewThemeBlock)(UICollectionView *collectionView);
@end

NS_ASSUME_NONNULL_END
