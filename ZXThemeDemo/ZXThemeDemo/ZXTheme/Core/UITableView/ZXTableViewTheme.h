//
//  ZXTableViewTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/12.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXTableViewTheme : NSObject
/**
 设置TableView的backgroundColor
 */
@property(strong, nonatomic) UIColor *backgroundColor;
/**
 设置TableView的backgroundView
 */
@property(strong, nonatomic) UIView *backgroundView;
/**
 设置TableView的sectionIndexColor
 */
@property(strong, nonatomic) UIColor *sectionIndexColor;
/**
 设置TableView的sectionIndexBackgroundColor
 */
@property(strong, nonatomic) UIColor *sectionIndexBackgroundColor;
/**
 设置TableView的sectionIndexTrackingBackgroundColor
 */
@property(strong, nonatomic) UIColor *sectionIndexTrackingBackgroundColor;
/**
 设置TableView的separatorStyle
 */
@property(assign, nonatomic) UITableViewCellSeparatorStyle separatorStyle;
/**
 设置TableView的separatorColor
 */
@property(strong, nonatomic) UIColor *separatorColor;
/**
 设置TableView的separatorEffect
 */
@property(strong, nonatomic) UIVisualEffect *separatorEffect;
/**
 设置TableView的tableHeaderView
 */
@property(strong, nonatomic) UIView *tableHeaderView;
/**
 设置TableView的tableFooterView
 */
@property(strong, nonatomic) UIView *tableFooterView;
/**
 设置TableView的cell
 */
@property(copy, nonatomic) UITableViewCell *(^cellForRowAtIndexPath)(UITableViewCell *cell,NSIndexPath *indexPath);
/**
 设置TableView的headerView
 */
@property(copy, nonatomic) UIView *(^viewForHeaderInSection)(UIView *headerView,NSUInteger section);
/**
 设置TableView的footerView
 */
@property(copy, nonatomic) UIView *(^viewForFooterInSection)(UIView *footerView,NSUInteger section);
@end

NS_ASSUME_NONNULL_END
