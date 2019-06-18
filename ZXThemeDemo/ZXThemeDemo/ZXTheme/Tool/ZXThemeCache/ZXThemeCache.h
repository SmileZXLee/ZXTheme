//
//  ZXThemeCache.h
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/18.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXThemeCache : NSObject
+ (instancetype)defaultCache;
@property(strong, nonatomic)NSMutableDictionary *themeCacheDic;
@end

NS_ASSUME_NONNULL_END
