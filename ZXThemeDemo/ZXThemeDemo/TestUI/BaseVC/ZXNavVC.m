//
//  ZXNavVC.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/4.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXNavVC.h"
#import "ZXTheme.h"
@interface ZXNavVC ()

@end

@implementation ZXNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setNeedsStatusBarAppearanceUpdate) name:ZXThemeUpdateNotification object:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return [ZXTheme defaultTheme].zx_darkTheme ?UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}



@end
