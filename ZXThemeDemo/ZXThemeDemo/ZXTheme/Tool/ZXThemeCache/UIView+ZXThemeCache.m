//
//  UIView+ZXThemeCache.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/18.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIView+ZXThemeCache.h"
#import "ZXThemeCache.h"
#import <objc/message.h>
#import "ZXTheme.h"
@implementation UIView (ZXThemeCache)
- (void)zx_saveThemeCache{
    Class cls = [self class];
    NSString *p = [NSString stringWithFormat:@"%p",self];
    id resTheme = nil;
    if([cls isKindOfClass:[UILabel class]]){
        resTheme = [[ZXLabelTheme alloc]init];
    }
    u_int proCount;
    objc_property_t *properties  = class_copyPropertyList(cls,&proCount);
    for(NSUInteger i = 0;i < proCount;i++){
        objc_property_t pro = properties[i];
        const char *propertyNameChar = property_getName(pro);
        NSString *propertyName = [NSString stringWithUTF8String: propertyNameChar];
        NSString *proSetStr = [NSString stringWithFormat:@"set%@:",[propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]]];
        SEL proSetSel = NSSelectorFromString(proSetStr);
        if([resTheme respondsToSelector:proSetSel] && [self respondsToSelector:NSSelectorFromString(propertyName)]){
            [resTheme setValue:[self valueForKey:propertyName] forKey:propertyName];
        }
        
    }
    if(resTheme && p.length){
        [[ZXThemeCache defaultCache].themeCacheDic setValue:resTheme forKey:p];
    }
    
}

- (id)zx_readThemeCache{
    NSString *p = [NSString stringWithFormat:@"%p",self];
    if([[ZXThemeCache defaultCache].themeCacheDic.allKeys containsObject:p]){
        return [[ZXThemeCache defaultCache].themeCacheDic valueForKey:p];
    }
    return nil;
}

@end
