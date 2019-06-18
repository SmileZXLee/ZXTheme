//
//  ZXCVFastModel.h
//  ZXCollectionView
//
//  Created by 李兆祥 on 2019/4/8.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCollectionView

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    ZXScrollDirectionVertical = 0x0, //垂直滚动
    ZXScrollDirectionHorizontal = 0x1 //水平滚动
}ZXScrollDirection;

NS_ASSUME_NONNULL_BEGIN

@interface ZXCVFastModel : NSObject
/// cell间距，默认为10
@property(nonatomic, assign)CGFloat margin;
/// 垂直滚动时cell列数，默认为2
@property(nonatomic, assign)NSUInteger colCount;
/// 水平滚动时cell行数，默认为2
@property(nonatomic, assign)NSUInteger rowCount;
/// 滚动方向，默认为垂直滚动
@property(nonatomic, assign)ZXScrollDirection scrollDirection;
/// 垂直滚动时手动设置的高度，若设置则其余高度设置失效
@property(nonatomic, assign)CGFloat itemH;
/// 垂直滚动时手动设置的宽度比例itemH = itemW * itemHMultiply，若设置则其余高度设置失效
@property(nonatomic, assign)CGFloat itemHMultiply;
/// 垂直滚动时手动设置的宽度比例itemH = itemHW + itemHConstant，若设置则其余高度设置失效
@property(nonatomic, assign)CGFloat itemHConstant;
/// 水平滚动时手动设置的宽度，若设置则其余宽度设置失效
@property(nonatomic, assign)CGFloat itemW;
/// 水平滚动时手动设置的宽度比例itemW = itemH * itemWMultiply，若设置则其余宽度设置失效
@property(nonatomic, assign)CGFloat itemWMultiply;
/// 水平滚动时手动设置的宽度比例itemW = itemH + itemWConstant，若设置则其余宽度设置失效
@property(nonatomic, assign)CGFloat itemWConstant;
/// margin是否对左右边缘也生效，默认为YES
@property(nonatomic, assign)BOOL attachMargin;
/// 垂直滚动时cell容器的宽度，默认为ZXCollectionView宽度
@property(nonatomic, assign)CGFloat superW;
/// 水平滚动时cell容器的高度，默认为ZXCollectionView高度
@property(nonatomic, assign)CGFloat superH;
@end

NS_ASSUME_NONNULL_END
