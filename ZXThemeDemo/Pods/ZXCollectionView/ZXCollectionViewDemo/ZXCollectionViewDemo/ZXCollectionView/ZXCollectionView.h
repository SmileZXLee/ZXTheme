//
//  ZXCollectionView.h
//  ZXCollectionView
//
//  Created by 李兆祥 on 2019/4/8.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCollectionView

#import <UIKit/UIKit.h>
#import "ZXCVFastModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZXCollectionView : UICollectionView
#pragma mark - 数据设置
///设置所有数据数组
@property(nonatomic, strong) NSMutableArray * zxDatas;
///设置对应cell的类
@property (nonatomic, copy) Class(^zx_setCellClassAtIndexPath)(NSIndexPath *indexPath);
///设置section数量(非必须，若设置了，则内部自动设置section个数无效)
@property (nonatomic, copy) CGFloat (^zx_setNumberOfSectionsInCollectionView)(UICollectionView * collectionView);
///设置对应section中item的数量(非必须，若设置了，则内部自动设置对应section中item的数量无效)
@property (nonatomic, copy) CGFloat (^zx_setNumberOfItemsInSection)(NSUInteger section);
///设置HeaderView(非必须)
@property (nonatomic, copy) UICollectionReusableView * (^zx_setHeaderViewInSection)(NSInteger section);
///设置FooterView(非必须)
@property (nonatomic, copy) UICollectionReusableView *(^zx_setFooterViewInSection)(NSInteger section);
///设置HeaderView(包含声明View和设置高度,写了此方法则viewForHeaderInSection无效，若写了heightForHeaderInSection则自动高度无效)(非必须)
@property (nonatomic, copy) Class(^zx_setHeaderClassInSection)(NSInteger section);
///设置FooterView(包含声明View和设置高度,写了此方法则viewForFooterInSection无效若写了heightForFooterInSection则自动高度无效)(非必须)
@property (nonatomic, copy) Class(^zx_setFooterClassInSection)(NSInteger section);
#pragma mark - 布局设置
///设置cell的size
@property (nonatomic, copy) CGSize (^zx_setItemSizeAtIndexPath)(NSIndexPath * indexPath,id model,CGSize orgSize);
///设置cell之间行间隙
@property (nonatomic, copy) CGFloat (^zx_setMinLineSpacingInSection)(NSInteger section,CGFloat orgSpacing);
///设置cell之间列间隙
@property (nonatomic, copy) CGFloat (^zx_setMinInteritemSpacingInSection)(NSInteger section,CGFloat orgSpacing);
///设置cell上左下右边界缩进
@property (nonatomic, copy) UIEdgeInsets (^zx_setInsetInSection)(NSInteger section,UIEdgeInsets orgEdgeInsets);
///设置HeaderView的Size(非必须)
@property (nonatomic, copy) CGSize (^zx_setHeaderSizeInSection)(NSInteger section);
///设置FooterView的Size(非必须)
@property (nonatomic, copy) CGSize (^zx_setFooterSizeInSection)(NSInteger section);
///无数据是否显示HeaderView，默认为YES
@property(nonatomic, assign)BOOL zx_showHeaderWhenNoMsg;
///无数据是否显示FooterView，默认为YES
@property(nonatomic, assign)BOOL zx_showFooterWhenNoMsg;
#pragma mark - 数据获取
///获取对应行的cell和model
@property (nonatomic, copy) void (^zx_getCellAtIndexPath)(NSIndexPath *indexPath,id cell,id model);
///获取对应section的headerView secArr为对应section的model数组
@property (nonatomic, copy) void (^zx_getHeaderViewInSection)(NSInteger section,id headerView,id model);
///获取对应section的footerView secArr为对应section的model数组
@property (nonatomic, copy) void (^zx_getFooterViewInSection)(NSInteger section,id footerView,id model);
#pragma mark - 代理事件相关
///设置cell是否可以高亮
@property (nonatomic, copy) BOOL (^zx_shouldHighlightItemAtIndexPath)(NSIndexPath *indexPath);
///cell高亮时调用此方法
@property (nonatomic, copy) void (^zx_didHighlightItemAtIndexPath)(NSIndexPath *indexPath);
///cell高亮时调用此方法
@property (nonatomic, copy) void (^zx_didUnhighlightItemAtIndexPath)(NSIndexPath *indexPath);
///设置cell是否可以选中
@property (nonatomic, copy) BOOL (^zx_shouldSelectItemAtIndexPath)(NSIndexPath *indexPath);
///设置cell是否可以取消选中
@property (nonatomic, copy) BOOL (^zx_shouldDeselectItemAtIndexPath)(NSIndexPath *indexPath);
///选中cell时候调用此方法
@property (nonatomic, copy) void (^zx_didSelectItemAtIndexPath)(NSIndexPath *indexPath,id model,id cell);
///取消选中cell时候调用此方法
@property (nonatomic, copy) void (^zx_didDeselectItemAtIndexPath)(NSIndexPath *indexPath,id model,UICollectionViewCell *cell);
///将要显示cell的时候调用此方法
@property (nonatomic, copy) void (^zx_willDisplayCellAtIndexPath)(NSIndexPath *indexPath,UICollectionViewCell *cell,id model);
///已经显示cell的时候调用此方法
@property (nonatomic, copy) void (^zx_didDisplayCellAtIndexPath)(NSIndexPath *indexPath,UICollectionViewCell *cell,id model);
///将要显示headerView的时候调用此方法
@property (nonatomic, copy) void (^zx_willDisplayHeaderView)(NSIndexPath *indexPath,id model,UICollectionReusableView *headerView);
///已经显示headerView的时候调用此方法
@property (nonatomic, copy) void (^zx_didDisplayHeaderView)(NSIndexPath *indexPath,id model,UICollectionReusableView *headerView);
///将要显示footerView的时候调用此方法
@property (nonatomic, copy) void (^zx_willDisplayFooterView)(NSIndexPath *indexPath,id model,UICollectionReusableView *footerView);
///已经显示footerView的时候调用此方法
@property (nonatomic, copy) void (^zx_didDisplayFooterView)(NSIndexPath *indexPath,id model,UICollectionReusableView *footerView);
///设置是否展示长按cell菜单
@property (nonatomic, copy) BOOL (^zx_shouldShowMenuForItemAtIndexPath)(NSIndexPath *indexPath);
///设置要展示的菜单选项
@property (nonatomic, copy) BOOL (^zx_canPerformActionForItemAtIndexPath)(SEL action,NSIndexPath *indexPath,id sender);
///点击菜单按钮后调用此方法（只有copy、cut和paste三个方法可用）
@property (nonatomic, copy) void(^zx_performActionForItemAtIndexPath)(SEL action,NSIndexPath *indexPath,id sender);
@property (nonatomic, copy)UICollectionViewTransitionLayout *(^zx_transitionLayout)(UICollectionViewLayout *fromLayout,UICollectionViewLayout *toLayout);

///scrollView滚动事件
@property (nonatomic, copy) void (^zx_scrollViewDidScroll)(UIScrollView *scrollView);
///scrollView缩放事件
@property (nonatomic, copy) void (^zx_scrollViewDidZoom)(UIScrollView *scrollView);
///scrollView滚动到顶部事件
@property (nonatomic, copy) void (^zx_scrollViewDidScrollToTop)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^zx_scrollViewWillBeginDragging)(UIScrollView *scrollView);
///scrollView开始拖拽事件
@property (nonatomic, copy) void (^zx_scrollViewDidEndDragging)(UIScrollView *scrollView, BOOL willDecelerate);
#pragma mark - 快速构建
///计算itemW colCount：列数；margin：间距；attachMargin：是否计算上左右边距；superW：父控件宽度，若为0则默认为collectionView宽度
-(CGFloat)zx_getItemWWithCol:(NSUInteger)colCount margin:(CGFloat)margin attachMargin:(BOOL)attachMargin superW:(CGFloat)superW;
///计算itemH rowCount：行数；margin：间距；attachMargin：是否计算上左右边距；superH：父控件高度，若为0则默认为collectionView高度
-(CGFloat)zx_getItemHWithCol:(NSUInteger)rowCount margin:(CGFloat)margin attachMargin:(BOOL)attachMargin superH:(CGFloat)superH;
///快速构建ZXCollectionView
-(void)zx_fastWithModel:(nullable ZXCVFastModel *)fastModel;
#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
///tableView的DataSource 设置为当前控制器即可重写对应数据源方法
@property (nonatomic, weak, nullable) id <UICollectionViewDataSource> zxDataSource;
///tableView的Delegate 设置为当前控制器即可重写对应代理方法
@property (nonatomic, weak, nullable) id <UICollectionViewDelegate> zxDelegate;
@end

NS_ASSUME_NONNULL_END
