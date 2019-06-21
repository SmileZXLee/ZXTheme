//
//  ZXThemeTool.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXThemeTool.h"
@implementation ZXThemeTool
+ (id)zx_getThemeWithPropertyStr:(NSString *)propertyStr themeInstance:(id)themeInstance orgSetData:(id)orgSetData themeType:(ZXThemeType)themeType{
    id (^themeBlock)(id owner);
    switch (themeType) {
        case ZXThemeTypeView:{
            themeBlock = [ZXTheme defaultTheme].zx_viewThemeBlock;
            break;
        }
        case ZXThemeTypeLabel:{
            themeBlock = [ZXTheme defaultTheme].zx_labelThemeBlock;
            break;
        }
        case ZXThemeTypeButton:{
            themeBlock = [ZXTheme defaultTheme].zx_buttonThemeBlock;
            break;
        }
        case ZXThemeTypeSegmentedControl:{
            themeBlock = [ZXTheme defaultTheme].zx_segmentedControlThemeBlock;
            break;
        }
        case ZXThemeTypeTextField:{
            themeBlock = [ZXTheme defaultTheme].zx_textFieldThemeBlock;
            break;
        }
        case ZXThemeTypeSlider:{
            themeBlock = [ZXTheme defaultTheme].zx_sliderThemeBlock;
            break;
        }
        case ZXThemeTypeSwitch:{
            themeBlock = [ZXTheme defaultTheme].zx_switchThemeBlock;
            break;
        }
        case ZXThemeTypeActivityIndicatorView:{
            themeBlock = [ZXTheme defaultTheme].zx_activityIndicatorViewThemeBlock;
            break;
        }
        case ZXThemeTypeProgressView:{
            themeBlock = [ZXTheme defaultTheme].zx_progressViewThemeBlock;
            break;
        }
        case ZXThemeTypePageControl:{
            themeBlock = [ZXTheme defaultTheme].zx_pageControlThemeBlock;
            break;
        }
        case ZXThemeTypeStepper:{
            themeBlock = [ZXTheme defaultTheme].zx_stepperThemeBlock;
            break;
        }
        case ZXThemeTypeImageView:{
            themeBlock = [ZXTheme defaultTheme].zx_imageViewThemeBlock;
            break;
        }
        case ZXThemeTypeTextView:{
            themeBlock = [ZXTheme defaultTheme].zx_textViewThemeBlock;
            break;
        }
        case ZXThemeTypeTabBar:{
            themeBlock = [ZXTheme defaultTheme].zx_tabBarThemeBlock;
            break;
        }
        case ZXThemeTypeTabBarItem:{
            themeBlock = [ZXTheme defaultTheme].zx_tabBarItemThemeBlock;
            break;
        }
        case ZXThemeTypeNavigationBar:{
            themeBlock = [ZXTheme defaultTheme].zx_navigationBarThemeBlock;
            break;
        }
        case ZXThemeTypeBarButtonItem:{
            themeBlock = [ZXTheme defaultTheme].zx_barButtonItemThemeBlock;
            break;
        }
        case ZXThemeTypeTableView:{
            themeBlock = [ZXTheme defaultTheme].zx_tableViewThemeBlock;
            break;
        }
        case ZXThemeTypeCollectionView:{
            themeBlock = [ZXTheme defaultTheme].zx_collectionViewThemeBlock;
            break;
        }
        default:
            break;
    }
    if(themeBlock){
        id themeValue = themeBlock(themeInstance);
        if(themeValue && [themeValue respondsToSelector:NSSelectorFromString(propertyStr)]){
            id themeRes = [self handleThemeDataWithThemeValue:themeValue propertyStr:propertyStr];
            if(themeRes){
                if([themeRes isKindOfClass:[NSNumber class]]){
                    if([themeRes intValue] >= 0){
                        return themeRes;
                    }
                }else{
                    return themeRes;
                }
            }
            
        }
    }
    return orgSetData;
}

#pragma mark - Private
+ (id)handleThemeDataWithThemeValue:(id)themeValue propertyStr:(NSString *)propertyStr{
    NSString *themeKey = [propertyStr substringWithRange:NSMakeRange(3, propertyStr.length - 3 - 1)];
    themeKey = [themeKey stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[themeKey substringToIndex:1] lowercaseString]];
    if([themeValue respondsToSelector:NSSelectorFromString(themeKey)]){
        return [themeValue valueForKey:themeKey];
    }else{
        return nil;
    }
    
}
@end
