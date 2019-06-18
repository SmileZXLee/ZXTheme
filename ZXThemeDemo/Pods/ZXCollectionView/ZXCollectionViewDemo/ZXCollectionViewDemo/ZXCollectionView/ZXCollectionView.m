//
//  ZXCollectionView.m
//  ZXCollectionView
//
//  Created by 李兆祥 on 2019/4/8.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCollectionView

#import "ZXCollectionView.h"
#import "NSObject+ZXCVSafeValue.h"
#import "ZXCollectionViewConfig.h"
#import "ZXCVGetProName.h"
@interface ZXCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong)NSMutableArray *registedArr;
@end
@implementation ZXCollectionView
#pragma mark - Perference
#pragma mark 设置ZXCollectionView，此设置会应用到全部的ZXCollectionView中
-(void)setZXCollectionView{
    [self privateSetZXCollectionView];
}
#pragma mark ZXTableView的cell，此设置会应用到全部的ZXCollectionView的cell中
-(void)setCell{
    
}

#pragma mark - UICollectionViewDataSource
#pragma mark 设置有几个section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if([self.zxDataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]){
        return [self.zxDataSource numberOfSectionsInCollectionView:collectionView];
    }else{
        if(self.zx_setNumberOfSectionsInCollectionView){
            return self.zx_setNumberOfSectionsInCollectionView(collectionView);
        }else{
            return [self isMultiDatas] ? self.zxDatas.count : 1;
        }
    }
}
#pragma mark 设置对应section中有几个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if([self.zxDataSource respondsToSelector:@selector(numberOfRowsInSection:)]){
        return [self.zxDataSource collectionView:collectionView numberOfItemsInSection:section];
    }else{
        if(self.zx_setNumberOfItemsInSection){
            return self.zx_setNumberOfItemsInSection(section);
        }else{
            if([self isMultiDatas]){
                NSArray *sectionArr = [self.zxDatas objectAtIndex:section];
                return sectionArr.count;
            }else{
                return self.zxDatas.count;
            }
        }
    }
}
#pragma mark 设置cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDataSource respondsToSelector:@selector(cellForRowAtIndexPath:)]){
        return [self.zxDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        NSString *className  = nil;
        Class cellClass = nil;
        if(self.zx_setCellClassAtIndexPath){
            cellClass = self.zx_setCellClassAtIndexPath(indexPath);
            className = NSStringFromClass(cellClass);
        }else{
            return nil;
        }
        if(![self.registedArr containsObject:NSStringFromClass(cellClass)]){
            BOOL isExistNib = [self isExistNibWithClass:cellClass];
            if(!isExistNib){
                [self registerClass:cellClass forCellWithReuseIdentifier:className];
            }else{
                [self registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
            }
            [self.registedArr addObject:NSStringFromClass(cellClass)];
        }
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:className forIndexPath:indexPath];
        if(model){
            [model zx_safeSetValue:indexPath forKey:INDEX];
            [cell zx_safeSetValue:indexPath forKey:INDEX];
            NSArray *proNames = [ZXCVGetProName zx_getRecursionPropertyNames:cell];
            BOOL cellContainsModel = NO;
            for (NSString *proStr in proNames) {
                if([proStr.uppercaseString containsString:DATAMODEL.uppercaseString]){
                    [cell zx_safeSetValue:model forKey:proStr];
                    cellContainsModel = YES;
                    break;
                }
            }
        }
        !self.zx_getCellAtIndexPath ? : self.zx_getCellAtIndexPath(indexPath,cell,model);
    //可以在这里设置整个项目cell的属性，也可以在cellAtIndexPath的block中设置当前控制器tableview的cell属性
        [self setCell];
        return cell;
    }
}
#pragma mark 设置Header/Footer内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = nil;
        if([self.zxDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]){
            headerView = [self.zxDataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }else{
            Class headerCls;
            if(self.zx_setHeaderClassInSection){
                headerCls = self.zx_setHeaderClassInSection(indexPath.section);
                
            }else{
                if(self.zx_setHeaderViewInSection){
                    headerView = self.zx_setHeaderViewInSection(indexPath.section);
                    headerCls = [headerView class];
                    
                }
            }
            if(![self.registedArr containsObject:NSStringFromClass(headerCls)]){
                BOOL isExistNib = [self isExistNibWithClass:headerCls];
                if(!isExistNib){
                    [self registerClass:headerCls forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(headerCls)];
                }else{
                    [self registerNib:[UINib nibWithNibName:NSStringFromClass(headerCls) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(headerCls)];
                }
                [self.registedArr addObject:NSStringFromClass(headerCls)];
            }
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(headerCls) forIndexPath:indexPath];
        }
        !self.zx_getHeaderViewInSection ? : self.zx_getHeaderViewInSection(indexPath.section,headerView,[self getModelAtIndexPath:indexPath]);
        return headerView;
        
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {    UICollectionReusableView *footerView = nil;
        if([self.zxDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]){
            footerView = [self.zxDataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        }else{
            Class footerCls;
            if(self.zx_setFooterClassInSection){
                footerCls = self.zx_setFooterClassInSection(indexPath.section);
                
            }else{
                if(self.zx_setFooterViewInSection){
                    footerView = self.zx_setFooterViewInSection(indexPath.section);
                    footerCls = [footerView class];
                }
            }
            if(![self.registedArr containsObject:NSStringFromClass(footerCls)]){
                BOOL isExistNib = [self isExistNibWithClass:footerCls];
                if(!isExistNib){
                    [self registerClass:footerCls forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(footerCls)];
                }else{
                    [self registerNib:[UINib nibWithNibName:NSStringFromClass(footerCls) bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(footerCls)];
                }
                [self.registedArr addObject:NSStringFromClass(footerCls)];
            }
            footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(footerCls) forIndexPath:indexPath];
        }
        !self.zx_getFooterViewInSection ? : self.zx_getFooterViewInSection(indexPath.section,footerView,[self getModelAtIndexPath:indexPath]);
        return footerView;
    }
    
    return nil;
}
#pragma mark - UICollectionViewDelegate
#pragma mark 设置某个cell是否可以高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:shouldHighlightItemAtIndexPath:)]){
        return [self.delegate collectionView:collectionView shouldHighlightItemAtIndexPath:indexPath];
    }
    if(self.zx_shouldHighlightItemAtIndexPath){
        return self.zx_shouldHighlightItemAtIndexPath(indexPath);
    }
    return YES;
}
#pragma mark 某cell高亮时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:didHighlightItemAtIndexPath:)]){
        [self.delegate collectionView:collectionView didHighlightItemAtIndexPath:indexPath];
    }else{
        if(self.zx_didHighlightItemAtIndexPath){
            self.zx_didHighlightItemAtIndexPath(indexPath);
        }
    }
    
}
#pragma mark 某cell结束高亮时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:didUnhighlightItemAtIndexPath:)]){
        [self.delegate collectionView:collectionView didUnhighlightItemAtIndexPath:indexPath];
    }else{
        if(self.zx_didUnhighlightItemAtIndexPath){
            self.zx_didUnhighlightItemAtIndexPath(indexPath);
        }
    }
}

#pragma mark 设置某个cell是否可以选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.zx_didSelectItemAtIndexPath)return YES;
    if([self.zxDelegate respondsToSelector:@selector(collectionView:shouldSelectItemAtIndexPath:)]){
        return [self.delegate collectionView:collectionView shouldSelectItemAtIndexPath:indexPath];
    }
    if(self.zx_shouldSelectItemAtIndexPath){
        return self.zx_shouldSelectItemAtIndexPath(indexPath);
    }
    return YES;
}
#pragma mark 设置某个cell是否可以取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.zx_didDeselectItemAtIndexPath)return YES;
    if([self.zxDelegate respondsToSelector:@selector(collectionView:shouldDeselectItemAtIndexPath:)]){
        return [self.delegate collectionView:collectionView shouldDeselectItemAtIndexPath:indexPath];
    }
    if(self.zx_shouldDeselectItemAtIndexPath){
        return self.zx_shouldDeselectItemAtIndexPath(indexPath);
    }
    return YES;
}
#pragma mark 选中某个cell时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]){
        [self.zxDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        !self.zx_didSelectItemAtIndexPath ? : self.zx_didSelectItemAtIndexPath(indexPath,model,cell);
    }
}
#pragma mark 取消选中某个cell时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)]){
        [self.zxDelegate collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        !self.zx_didDeselectItemAtIndexPath ? : self.zx_didDeselectItemAtIndexPath(indexPath,model,cell);
    }
}

#pragma mark 将要显示某个cell时调用此方法
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    if([self.zxDelegate respondsToSelector:@selector(collectionView:willDisplayCell:forItemAtIndexPath:)]){
        [self.zxDelegate collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        !self.zx_willDisplayCellAtIndexPath ? : self.zx_willDisplayCellAtIndexPath(indexPath,model,cell);
    }
}
#pragma mark 已经显示某个cell时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:didEndDisplayingCell:forItemAtIndexPath:)]){
        [self.zxDelegate collectionView:collectionView didEndDisplayingCell:cell forItemAtIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        !self.zx_didDisplayCellAtIndexPath ? : self.zx_didDisplayCellAtIndexPath(indexPath,model,cell);
    }
}

#pragma mark 将要显示某个组头/组尾视图时调用此方法
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0){
    if([self.zxDelegate respondsToSelector:@selector(collectionView:willDisplaySupplementaryView:forElementKind:atIndexPath:)]){
        [self.zxDelegate collectionView:collectionView willDisplaySupplementaryView:view forElementKind:elementKind atIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        if([elementKind isEqualToString:UICollectionElementKindSectionHeader]){
            !self.zx_willDisplayHeaderView ? : self.zx_willDisplayHeaderView(indexPath,model,view);
        }else{
            !self.zx_willDisplayFooterView ? : self.zx_willDisplayFooterView(indexPath,model,view);
        }
    }
}
#pragma mark 已经显示某个组头/组尾视图时调用此方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:didEndDisplayingSupplementaryView:forElementOfKind:atIndexPath:)]){
        [self.zxDelegate collectionView:collectionView didEndDisplayingSupplementaryView:view forElementOfKind:elementKind atIndexPath:indexPath];
    }else{
        id model = [self getModelAtIndexPath:indexPath];
        if([elementKind isEqualToString:UICollectionElementKindSectionHeader]){
            !self.zx_didDisplayHeaderView ? : self.zx_didDisplayHeaderView(indexPath,model,view);
        }else{
            !self.zx_didDisplayFooterView ? : self.zx_didDisplayFooterView(indexPath,model,view);
        }
    }
}
#pragma mark 设置是否展示长按cell菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:shouldSelectItemAtIndexPath:)]){
        return [self.zxDelegate collectionView:collectionView shouldSelectItemAtIndexPath:indexPath];
    }
    if(self.zx_shouldShowMenuForItemAtIndexPath){
        return self.zx_shouldShowMenuForItemAtIndexPath(indexPath);
    }
    return NO;
}

#pragma mark 设置要展示的菜单选项
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:canPerformAction:forItemAtIndexPath:withSender:)]){
        return [self.zxDelegate collectionView:collectionView canPerformAction:action forItemAtIndexPath:indexPath withSender:sender];
    }
    if(self.zx_canPerformActionForItemAtIndexPath){
        return self.zx_canPerformActionForItemAtIndexPath(action,indexPath,sender);
    }
    return NO;
}
#pragma mark 点击菜单按钮后调用此方法（只有copy、cut和paste三个方法可用）
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:performAction:forItemAtIndexPath:withSender:)]){
        [self.zxDelegate collectionView:collectionView performAction:action forItemAtIndexPath:indexPath withSender:sender];
    }
    if(self.zx_performActionForItemAtIndexPath){
        self.zx_performActionForItemAtIndexPath(action,indexPath,sender);
    }
}

#pragma mark collectionView重新布局时调用此方法
- (nonnull UICollectionViewTransitionLayout *)collectionView:(UICollectionView *)collectionView transitionLayoutForOldLayout:(UICollectionViewLayout *)fromLayout newLayout:(UICollectionViewLayout *)toLayout{
    if([self.zxDelegate respondsToSelector:@selector(collectionView:transitionLayoutForOldLayout:newLayout:)]){
        return [self.zxDelegate collectionView:collectionView transitionLayoutForOldLayout:fromLayout newLayout:toLayout];
    }
    if(self.zx_transitionLayout){
        return self.zx_transitionLayout(fromLayout,toLayout);
    }
    return nil;
}
#pragma mark - Layout
#pragma mark 设置Header的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    NSArray *secArr = [self isMultiDatas] ? self.zxDatas[section] : self.zxDatas;
    if(!self.zx_showHeaderWhenNoMsg && !secArr.count){
        return CGSizeZero;
    }
    if([self.zxDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)] || self.zx_setHeaderClassInSection || self.zx_setHeaderViewInSection){
        if(self.zx_setHeaderClassInSection && !self.zx_setHeaderClassInSection(section)){
            return CGSizeZero;
        }
        if(self.zx_setHeaderSizeInSection){
            return self.zx_setHeaderSizeInSection(section);
        }
        UICollectionReusableView *headerView = headerView = [self getHeaderViewInSection:section];
        return headerView.frame.size;
    }
    return CGSizeZero;
    
}

#pragma mark 设置Footer的尺寸大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    NSArray *secArr = [self isMultiDatas] ? self.zxDatas[section] : self.zxDatas;
    if(!self.zx_showFooterWhenNoMsg && !secArr.count){
        return CGSizeZero;
    }
    if([self.zxDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)] || self.zx_setFooterClassInSection || self.zx_setFooterViewInSection){
        if(self.zx_setFooterClassInSection && !self.zx_setFooterClassInSection(section)){
            return CGSizeZero;
        }
        if(self.zx_setFooterSizeInSection){
            return self.zx_setFooterSizeInSection(section);
        }
        UICollectionReusableView *footerView = [self getFooterViewInSection:section];
        return footerView.frame.size;
    }
    return CGSizeZero;
}

#pragma mark 设置cell的尺寸大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self getModelAtIndexPath:indexPath];
    if(self.zx_setItemSizeAtIndexPath){
        CGSize orgSize = CGSizeZero;
        if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
            UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            orgSize = flowLayout.itemSize;
        }
        return self.zx_setItemSizeAtIndexPath(indexPath,model,orgSize);
    }
    if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        return flowLayout.itemSize;
    }
    return CGSizeZero;
}


#pragma mark 设置cell之间行间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if(self.zx_setMinLineSpacingInSection){
        CGFloat orgSpacing = 0;
        if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
            UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            orgSpacing = flowLayout.minimumLineSpacing;
        }
        return self.zx_setMinLineSpacingInSection(section,orgSpacing);
    }
    if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        return flowLayout.minimumLineSpacing;
    }
    return 0;
}

#pragma mark 设置cell之间列间隙
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(self.zx_setMinInteritemSpacingInSection){
        CGFloat orgSpacing = 0;
        if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
            UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            orgSpacing = flowLayout.minimumInteritemSpacing;
        }
        return self.zx_setMinInteritemSpacingInSection(section,orgSpacing);
    }
    if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        return flowLayout.minimumInteritemSpacing;
    }
    return 0;
}

#pragma mark 设置上左下右边界缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(self.zx_setInsetInSection){
        UIEdgeInsets orgEdgeInsets = UIEdgeInsetsZero;
        if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
            UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
            orgEdgeInsets = flowLayout.sectionInset;
        }
        return self.zx_setInsetInSection(section,orgEdgeInsets);
    }
    if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        return flowLayout.sectionInset;
    }
    return UIEdgeInsetsZero;
}
#pragma mark 计算itemW
-(CGFloat)zx_getItemWWithCol:(NSUInteger)colCount margin:(CGFloat)margin attachMargin:(BOOL)attachMargin superW:(CGFloat)superW{
    CGFloat marginOffset = attachMargin ? 1 : -1;
    CGFloat itemW = ((superW ? superW :self.frame.size.width) - (colCount + marginOffset) * margin) / colCount - 1;
    return itemW;
}
#pragma mark 计算itemH
-(CGFloat)zx_getItemHWithCol:(NSUInteger)rowCount margin:(CGFloat)margin attachMargin:(BOOL)attachMargin superH:(CGFloat)superH{
    CGFloat marginOffset = attachMargin ? 1 : -1;
    CGFloat itemH = ((superH ? superH :self.frame.size.height) - (rowCount + marginOffset) * margin) / rowCount - 1;
    return itemH;
}
#pragma mark 快速构建ZXCollectionView
-(void)zx_fastWithModel:(ZXCVFastModel *)fastModel{
    if(!fastModel){
        fastModel = [[ZXCVFastModel alloc]init];
    }
    if([self.collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
        UICollectionViewFlowLayout * flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        CGFloat marginOffset = fastModel.attachMargin ? 1 : -1;
        if(fastModel.scrollDirection == ZXScrollDirectionVertical){
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            CGFloat itemW = ((fastModel.superW ? fastModel.superW :self.frame.size.width) - (fastModel.colCount + marginOffset) * fastModel.margin) / fastModel.colCount - 1;
            CGFloat itemH = 0;
            if(fastModel.itemH > 0){
                itemH = fastModel.itemH;
            }else if(fastModel.itemHMultiply > 0){
                itemH = fastModel.itemHMultiply * itemW;
            }else if(fastModel.itemHConstant > 0){
                itemH = fastModel.itemHConstant + itemW;
            }else{
                itemH = itemW;
            }
            flowLayout.itemSize = CGSizeMake(itemW,itemH);
            flowLayout.minimumInteritemSpacing = fastModel.margin;
            flowLayout.minimumLineSpacing = fastModel.margin;
            flowLayout.sectionInset = UIEdgeInsetsMake(fastModel.margin, fastModel.attachMargin ? fastModel.margin : 0, fastModel.margin, fastModel.attachMargin ? fastModel.margin : 0);
        }else{
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            CGFloat itemH = ((fastModel.superH ? fastModel.superH : self.frame.size.height) - (fastModel.rowCount + marginOffset) * fastModel.margin) / fastModel.rowCount - 1;
            CGFloat itemW = 0;
            if(fastModel.itemW > 0){
                itemW = fastModel.itemW;
            }else if(fastModel.itemWMultiply > 0){
                itemW = fastModel.itemWMultiply * itemH;
            }else if(fastModel.itemWConstant > 0){
                itemW = fastModel.itemWConstant + itemH;
            }else{
                itemW = itemH;
            }
            flowLayout.itemSize = CGSizeMake(itemW,itemH);
            flowLayout.minimumInteritemSpacing = fastModel.margin;
            flowLayout.minimumLineSpacing = fastModel.margin;
            flowLayout.sectionInset = UIEdgeInsetsMake(fastModel.margin, fastModel.attachMargin ? fastModel.margin : 0, fastModel.margin, fastModel.attachMargin ? fastModel.margin : 0);
        }
        
    }
    
}
#pragma mark scrollView相关代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if([self.zxDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        return [self.zxDelegate scrollViewDidScroll:scrollView];
        
    }else{
        if(self.zx_scrollViewDidScroll){
            self.zx_scrollViewDidScroll(scrollView);
        }
    }
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if([self.zxDelegate respondsToSelector:@selector(scrollViewDidZoom:)]){
        return [self.zxDelegate scrollViewDidZoom:scrollView];
        
    }else{
        if(self.zx_scrollViewDidZoom){
            self.zx_scrollViewDidZoom(scrollView);
        }
    }
}
-(void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if([self.zxDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]){
        return [self.zxDelegate scrollViewDidScrollToTop:scrollView];
        
    }else{
        if(self.zx_scrollViewDidScrollToTop){
            self.zx_scrollViewDidScrollToTop(scrollView);
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if([self.zxDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        return [self.zxDelegate scrollViewWillBeginDragging:scrollView];
        
    }else{
        if(self.zx_scrollViewWillBeginDragging){
            self.zx_scrollViewWillBeginDragging(scrollView);
        }
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if([self.zxDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        return [self.zxDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        
    }else{
        if(self.zx_scrollViewDidEndDragging){
            self.zx_scrollViewDidEndDragging(scrollView,decelerate);
        }
    }
}
#pragma mark - Private
#pragma mark zxDatas set方法
-(void)setZxDatas:(NSMutableArray *)zxDatas{
    _zxDatas = zxDatas;
    [self reloadData];
}
#pragma mark 判断是否是多个section的情况
-(BOOL)isMultiDatas{
    return self.zxDatas.count && [[self.zxDatas objectAtIndex:0] isKindOfClass:[NSArray class]];
}
#pragma mark 获取对应indexPath的model
-(instancetype)getModelAtIndexPath:(NSIndexPath *)indexPath{
    id model = nil;;
    if([self isMultiDatas]){
        if(indexPath.section < self.zxDatas.count){
            NSArray *sectionArr = self.zxDatas[indexPath.section];
            if(indexPath.row < sectionArr.count){
                model = sectionArr[indexPath.row];
            }
        }
    }else{
        if(indexPath.row < self.zxDatas.count){
            model = self.zxDatas[indexPath.row];
        }
    }
    return model;
}
#pragma mark 根据section获取headerView
-(UICollectionReusableView *)getHeaderViewInSection:(NSUInteger)section{
    Class headerClass = self.zx_setHeaderClassInSection(section);
    UICollectionReusableView *headerView = nil;
    if([self isExistNibWithClass:headerClass]){
        headerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(headerClass) owner:nil options:nil]lastObject];
    }else{
        headerView = [[headerClass alloc]init];
    }
    return headerView;
}
#pragma mark 根据section获取footerView
-(UICollectionReusableView *)getFooterViewInSection:(NSUInteger)section{
    Class footerClass = self.zx_setFooterClassInSection(section);
    
    UICollectionReusableView *footerView = nil;
    if([self isExistNibWithClass:footerClass]){
        footerView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(footerClass) owner:nil options:nil]lastObject];
    }else{
        footerView = [[footerClass alloc]init];
    }
    return footerView;
}
#pragma mark 判断对应的class是否存在同名xib
-(BOOL)isExistNibWithClass:(Class)cls{
    return [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.nib",[[NSBundle mainBundle]resourcePath],NSStringFromClass(cls)]];
}

#pragma mark ZXTableView默认初始化设置
-(void)privateSetZXCollectionView{
    self.delegate = self;
    self.dataSource = self;
    self.zxDatas = [NSMutableArray array];
    self.zx_showHeaderWhenNoMsg = SHOWHEADERWHENNOMSG;
    self.zx_showFooterWhenNoMsg = SHOWFOOTERWHENNOMSG;
}

#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self setZXCollectionView];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if(self = [super initWithFrame:frame collectionViewLayout:layout]){
        [self setZXCollectionView];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setZXCollectionView];
}
#pragma mark - 懒加载
-(NSMutableArray *)registedArr{
    if(!_registedArr){
        _registedArr = [NSMutableArray array];
    }
    return _registedArr;
}
@end
