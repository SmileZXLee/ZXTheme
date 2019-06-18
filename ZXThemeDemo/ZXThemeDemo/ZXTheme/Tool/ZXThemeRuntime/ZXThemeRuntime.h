//
//  ZXThemeRuntime.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef id(^themeBlock) (id owner);
@interface ZXThemeRuntime : NSObject

/**
 交换类方法
 
 @param targetCls 方法所属的class
 @param oldSel 旧方法
 @param newSel 新方法
 */
+ (void)zx_exchangeClassMethodWithTargetCls:(Class)targetCls oldSel:(SEL)oldSel newSel:(SEL)newSel;
/**
 交换实例方法
 
 @param targetCls 方法所属的class
 @param oldSel 旧方法
 @param newSel 新方法
 */
+ (void)zx_exchangeInstanceMethodWithTargetCls:(Class)targetCls oldSel:(SEL)oldSel newSel:(SEL)newSel;


/**
 交换实例方法

 @param oldCls 旧方法所属的class
 @param newCls 新方法所属的class
 @param oldSel 旧方法
 @param newSel 新方法
 */
+ (void)zx_exchangeInstanceMethodWithTargetOldCls:(Class)oldCls newCls:(Class)newCls oldSel:(SEL)oldSel newSel:(SEL)newSel;


/**
 交换带有数据源的类的实例方法

 @param oldCls 旧方法所属的class
 @param newCls 新方法所属的class
 @param oldSel 旧方法
 @param newSel 新方法
 */
+ (void)zx_exchangeDataSourceMethodWithTargetOldCls:(Class)oldCls newCls:(Class)newCls oldSel:(SEL)oldSel newSel:(SEL)newSel;

/**
 交换指定class中的set方法，注意，指定class必须有对应的Theme，例如UILabel的Theme是ZXLabelTheme
 
 @param targetCls 指定的class
 */
+ (void)zx_addThemeHook:(Class)targetCls;


/**
 触发指定对象的set方法
 
 @param target 指定对象
 */
+ (void)addThemeTrigger:(id)target;
@end

NS_ASSUME_NONNULL_END
