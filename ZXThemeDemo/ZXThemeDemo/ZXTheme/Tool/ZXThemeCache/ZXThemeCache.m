//
//  ZXThemeCache.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/18.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXThemeCache.h"

@implementation ZXThemeCache
+ (instancetype)defaultCache{
    static id s_instance_dj_singleton = nil ;
    if (s_instance_dj_singleton == nil) {
        s_instance_dj_singleton = [[self alloc] init];
    }
    return s_instance_dj_singleton;
}

- (NSMutableDictionary *)themeCacheDic{
    if(!_themeCacheDic){
        _themeCacheDic = [NSMutableDictionary dictionary];
    }
    return _themeCacheDic;
}
@end
