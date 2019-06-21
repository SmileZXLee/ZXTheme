//
//  ZXThemeCustomTool.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/14.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXThemeCustomTool.h"
#import "ZXThemeRuntime.h"
@implementation ZXThemeCustomTool
+ (void)zx_handleThemeWithTargetClass:(Class)targetCls handleClass:(Class)handleCls targetSelector:(SEL)targetSel handleSelector:(SEL)handleSel{
    [ZXThemeRuntime zx_exchangeInstanceMethodWithTargetOldCls:targetCls newCls:handleCls oldSel:targetSel newSel:handleSel];
}

@end
