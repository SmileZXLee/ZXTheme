//
//  NSObject+ZXCustomTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "NSObject+ZXCustomTheme.h"
#import "ZXThemeCustomTool.h"
@implementation NSObject (ZXCustomTheme)

+ (void)zx_handleThemeWithTargetSelector:(SEL)targetSel handleSelector:(SEL)handleSel{
    [ZXThemeCustomTool zx_handleThemeWithTargetClass:self handleClass:self targetSelector:targetSel handleSelector:handleSel];
}
@end
