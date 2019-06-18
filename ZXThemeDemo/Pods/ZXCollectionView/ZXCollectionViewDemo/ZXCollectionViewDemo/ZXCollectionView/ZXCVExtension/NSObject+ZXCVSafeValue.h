//
//  NSObject+ZXCVSafeValue.h
//  ZXCollectionView
//
//  Created by 李兆祥 on 2019/4/8.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCollectionView

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZXCVSafeValue)
-(id)zx_safeValueForKey:(NSString *)key;
-(void)zx_safeSetValue:(id)value forKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
