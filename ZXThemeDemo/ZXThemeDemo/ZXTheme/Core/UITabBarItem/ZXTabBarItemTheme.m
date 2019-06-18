//
//  ZXTabBarItemTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXTabBarItemTheme.h"

@implementation ZXTabBarItemTheme
- (instancetype)init{
    if(self = [super init]){
        _titleTextAttributesMapper = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setTitleTextAttributes:(nullable NSDictionary<NSAttributedStringKey,id> *)attributes forState:(UIControlState)state{
    [self.titleTextAttributesMapper setObject:attributes forKey:[NSNumber numberWithInt:state]];
}
@end
