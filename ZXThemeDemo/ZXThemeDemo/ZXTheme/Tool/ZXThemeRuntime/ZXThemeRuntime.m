//
//  ZXThemeRuntime.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXThemeRuntime.h"
#import "ZXTheme.h"
#import "ZXThemeTool.h"
#import <UIKit/UIKit.h>
#import <objc/message.h>

@implementation ZXThemeRuntime

+ (void)zx_exchangeClassMethodWithTargetCls:(Class)targetCls oldSel:(SEL)oldSel newSel:(SEL)newSel{
    Method newMethod = class_getClassMethod(targetCls, newSel);
    Method oldMethod = class_getClassMethod(targetCls, oldSel);
    BOOL hasMethod = class_addMethod(targetCls,oldSel,method_getImplementation(newMethod),method_getTypeEncoding(newMethod));
    if (hasMethod) {
        class_replaceMethod(targetCls,
                            newSel,
                            method_getImplementation(newMethod),
                            method_getTypeEncoding(newMethod));
    }else{
        method_exchangeImplementations(newMethod, oldMethod);
    }}

+ (void)zx_exchangeInstanceMethodWithTargetCls:(Class)targetCls oldSel:(SEL)oldSel newSel:(SEL)newSel{
    [self zx_exchangeInstanceMethodWithTargetOldCls:targetCls newCls:targetCls oldSel:oldSel newSel:newSel];
}

+ (void)zx_exchangeInstanceMethodWithTargetOldCls:(Class)oldCls newCls:(Class)newCls oldSel:(SEL)oldSel newSel:(SEL)newSel{
    Method newMethod = class_getInstanceMethod(newCls, newSel);
    Method oldMethod = class_getInstanceMethod(oldCls, oldSel);
    BOOL addedMethod = class_addMethod(oldCls,oldSel,method_getImplementation(newMethod),method_getTypeEncoding(newMethod));
    if(addedMethod){
        class_replaceMethod(newCls,
                            newSel,
                            method_getImplementation(oldMethod),
                            method_getTypeEncoding(oldMethod));
    }else{
        method_exchangeImplementations(newMethod, oldMethod);
    }
}

+ (void)zx_exchangeDataSourceMethodWithTargetOldCls:(Class)oldCls newCls:(Class)newCls oldSel:(SEL)oldSel newSel:(SEL)newSel{
    Method newMethod = class_getInstanceMethod(newCls, newSel);
    Method oldMethod = class_getInstanceMethod(oldCls, oldSel);
    BOOL addedMethod = class_addMethod(oldCls,newSel,method_getImplementation(newMethod),method_getTypeEncoding(newMethod));
    Method nextNewMethod = class_getInstanceMethod(oldCls, newSel);
    if(addedMethod){
        method_exchangeImplementations(nextNewMethod, oldMethod);
    }
}

+ (void)zx_addThemeHook:(Class)targetCls{
    NSString *themeClassStr = [NSString stringWithFormat:@"ZX%@Theme",[NSStringFromClass(targetCls) substringFromIndex:2]];
    Class themeClass = NSClassFromString(themeClassStr);
    if(themeClass){
        u_int methodCount;
        Method *instanceMethods  = class_copyMethodList(themeClass,&methodCount);
        for(NSUInteger i = 0;i < methodCount;i++){
            Method method = instanceMethods[i];
            SEL oldSel = method_getName(method);
            NSString *oldSelStr = NSStringFromSelector(oldSel);
            if([oldSelStr hasPrefix:@"set"]){
                NSString *newSelStr = [@"zx_" stringByAppendingString:oldSelStr];
                SEL newSel = NSSelectorFromString(newSelStr);
                Method newMethod = class_getInstanceMethod(targetCls, newSel);
                if(newMethod){
                    [self zx_exchangeInstanceMethodWithTargetCls:targetCls oldSel:oldSel newSel:newSel];
                }
            }
        }
    }
    [self zx_exchangeInstanceMethodWithTargetCls:targetCls oldSel:@selector(initWithCoder:) newSel:@selector(zx_initWithCoder:)];
    [self zx_exchangeInstanceMethodWithTargetCls:targetCls oldSel:@selector(initWithFrame:) newSel:@selector(zx_initWithFrame:)];
}

+ (void)addThemeTrigger:(id)target{
    NSString *baseClassStr = [ZXThemeTool zx_uiBaseClassStringWithCls:target];
    id (^themeBlock)(id owner);
    NSString *targetName = [baseClassStr substringFromIndex:2];
    targetName = [targetName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[targetName substringToIndex:1] lowercaseString]];
    NSString *themeBlockDec = [NSString stringWithFormat:@"zx_%@ThemeBlock",targetName];
    if([[ZXTheme defaultTheme] respondsToSelector:NSSelectorFromString(themeBlockDec)]){
        themeBlock = [[ZXTheme defaultTheme] valueForKey:themeBlockDec];
    }
    if(!themeBlock){
        return;
    }
    id theme = themeBlock(target);
    NSString *themeClassStr = [NSString stringWithFormat:@"ZX%@Theme",[baseClassStr substringFromIndex:2]];
    Class themeClass = NSClassFromString(themeClassStr);
    if(themeClass){
        u_int proCount;
        objc_property_t *properties  = class_copyPropertyList(themeClass,&proCount);
        for(NSUInteger i = 0;i < proCount;i++){
            objc_property_t pro = properties[i];
            const char *propertyNameChar = property_getName(pro);
            NSString *propertyName = [NSString stringWithUTF8String: propertyNameChar];
            NSString *proSetStr = [NSString stringWithFormat:@"set%@:",[propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]]];
            SEL proSetSel = NSSelectorFromString(proSetStr);
            id themeRes = [theme valueForKey:propertyName];
            if([target respondsToSelector:proSetSel] && [theme respondsToSelector:proSetSel] && themeRes){
                BOOL trigger = NO;
                if(themeRes){
                    if([themeRes isKindOfClass:[NSNumber class]]){
                        if([themeRes intValue] >= 0){
                            trigger = YES;
                        }
                    }else{
                        trigger = YES;
                    }
                }
                if(trigger){
                    [target performSelector:proSetSel withObject:[target valueForKey:propertyName] afterDelay:0 inModes:@[NSRunLoopCommonModes]];
                }
            }
        }
        
    }
}

#pragma mark - Useless

+ (void)zx_initWithCoder:(id)aCoder{
    
}
+ (void)zx_initWithFrame:(CGRect)rect{
    
}
@end
