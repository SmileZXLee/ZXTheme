//
//  UIAlertController+ZXCustomTheme.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/17.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIAlertController+ZXCustomTheme.h"
#import "ZXTheme.h"
@implementation UIAlertController (ZXCustomTheme)
+ (void)load{
    [self zx_handleThemeWithTargetSelector:@selector(addAction:) handleSelector:@selector(zx_addAction:)];
}
- (void)zx_addAction:(UIAlertAction *)action{
    [action setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [self zx_addAction:action];
}

@end
