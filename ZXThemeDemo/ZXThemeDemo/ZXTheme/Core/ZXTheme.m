//
//  ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXTheme.h"
@interface ZXTheme()

@end
@implementation ZXTheme
+ (instancetype)defaultTheme{
    static id s_instance_dj_singleton = nil ;
    if (s_instance_dj_singleton == nil) {
        s_instance_dj_singleton = [[self alloc] init];
    }
    return s_instance_dj_singleton;
}

- (void)zx_themeUpdate{
    [[NSNotificationCenter defaultCenter]postNotificationName:ZXThemeUpdateNotification object:nil];
}
@end
