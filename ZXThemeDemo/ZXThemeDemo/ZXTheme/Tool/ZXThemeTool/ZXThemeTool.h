//
//  ZXThemeTool.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆  祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXThemeRuntime.h"
#import "ZXTheme.h"
#import "ZXThemeDefind.h"
NS_ASSUME_NONNULL_BEGIN
typedef enum {
    ZXThemeTypeView = 0x00,    // UIView
    ZXThemeTypeLabel = 0x01,    // UILabel
    ZXThemeTypeButton = 0x02,    // UIButton
    ZXThemeTypeSegmentedControl = 0x03,    // UISegmentedControl
    ZXThemeTypeTextField = 0x04,    // UITextField
    ZXThemeTypeSlider = 0x05,    // UISlider
    ZXThemeTypeSwitch = 0x06,    // UISwitch
    ZXThemeTypeActivityIndicatorView = 0x07,    // UIActivityIndicatorView
    ZXThemeTypeProgressView = 0x08,    // UIProgressView
    ZXThemeTypePageControl = 0x09,    // UIPageControl
    ZXThemeTypeStepper = 0x10,    // UIStepper
    ZXThemeTypeImageView = 0x11,    // UIImageView
    ZXThemeTypeTextView = 0x12,    // UITextView
    ZXThemeTypeTabBar = 0x13,    // UITabBar
    ZXThemeTypeTabBarItem = 0x14,    // UITabBarItem
    ZXThemeTypeNavigationBar = 0x15,    // UINavigationBar
    ZXThemeTypeBarButtonItem = 0x16,    // UIBarButtonItem
    ZXThemeTypeTableView = 0x17,    // UITableView
    ZXThemeTypeCollectionView = 0x18,    // UICollectionView
}ZXThemeType;
@interface ZXThemeTool : NSObject
+ (id)zx_getThemeWithPropertyStr:(NSString *)propertyStr themeInstance:(id)themeInstance orgSetData:(id)orgSetData themeType:(ZXThemeType)themeType;
@end

NS_ASSUME_NONNULL_END

