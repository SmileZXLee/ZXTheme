//
//  ZXCollectionViewTheme.h
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/13.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZXCollectionViewTheme : NSObject
/**
 设置CollectionView的backgroundColor
 */
@property(strong, nonatomic) UIColor *backgroundColor;
/**
 设置CollectionView的backgroundView
 */
@property(strong, nonatomic) UIView *backgroundView;
/**
 设置CollectionView的cell
 */
@property(copy, nonatomic) UICollectionViewCell *(^cellForItemAtIndexPath)(UICollectionViewCell *cell,NSIndexPath *indexPath);
/**
 设置CollectionView的headerView和FfooterView
 */
@property(copy, nonatomic) UICollectionReusableView *(^viewForSupplementaryElement)(UICollectionReusableView *reusableView,NSString *kind,NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
