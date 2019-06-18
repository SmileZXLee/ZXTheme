//
//  ZXCollectionViewConfig.h
//  ZXCollectionView
//
//  Created by 李兆祥 on 2019/4/8.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCollectionView

#ifndef ZXCollectionViewConfig_h
#define ZXCollectionViewConfig_h
#pragma mark - ZXCollectionView相关
///cell会自动赋值包含“model”的属性
static NSString *const DATAMODEL = @"model";
///model与cell的index属性，存储当前model与cell所属的indexPath
static NSString *const INDEX = @"indexPath";
///无数据是否显示headerView
static BOOL const SHOWHEADERWHENNOMSG = 1;
///无数据是否显示footerView
static BOOL const SHOWFOOTERWHENNOMSG = 1;

#pragma mark - ZXCVFastModel相关
///cell间距默认值
static CGFloat const FAST_MARGIN = 10;
///垂直滚动时cell列数默认值
static NSUInteger const FAST_COLCOUNT = 2;
///水平滚动时cell行数默认值
static NSUInteger const FAST_ROWCOUNT = 2;
///滚动方向默认值
static NSUInteger const FAST_SCROLL_DIR = 0;
///垂直滚动时手动设置的高度默认值
static CGFloat const FAST_ITEMH = 0;
///垂直滚动时手动设置的高度比例
static CGFloat const FAST_ITEMHMUL = 1;
///垂直滚动时手动设置的高度增加量默认值
static CGFloat const FAST_ITEMHCON = 0;
///水平滚动时手动设置的宽度默认值
static CGFloat const FAST_ITEMW = 0;
///水平滚动时手动设置的宽度比例默认值
static CGFloat const FAST_ITEMWMUL = 1;
///水平滚动时手动设置的宽度增加量默认值
static CGFloat const FAST_ITEMWCON = 0;
///margin是否对左右边缘也生效
static BOOL const FAST_ATTMARGIN = 1;
#endif /* ZXCollectionViewConfig_h */
