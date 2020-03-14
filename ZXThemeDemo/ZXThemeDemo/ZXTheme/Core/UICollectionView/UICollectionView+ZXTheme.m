//
//  UICollectionView+ZXTheme.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/13.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UICollectionView+ZXTheme.h"
#import "ZXThemeTool.h"
static NSMutableArray *hookedTargetClassArr;
@implementation UICollectionView (ZXTheme)
+ (void)load{
    hookedTargetClassArr = [NSMutableArray array];
    [ZXThemeRuntime zx_addThemeHook:self];
    [ZXThemeRuntime zx_exchangeInstanceMethodWithTargetCls:self oldSel:@selector(setDataSource:) newSel:@selector(zx_setDataSource:)];
}

- (void)zx_setDataSource:(id)set{
    if(!set){
        return;
    }
    Class cls = [set class];
    NSString *clsStr = NSStringFromClass(cls);
    if([clsStr hasPrefix:@"_UI"]){
        [self zx_setDataSource:set];
        return;
    }
    if(![hookedTargetClassArr containsObject:clsStr]){
        [ZXThemeRuntime zx_exchangeDataSourceMethodWithTargetOldCls:cls newCls:[self class] oldSel:@selector(collectionView:cellForItemAtIndexPath:) newSel:@selector(zx_collectionView:cellForItemAtIndexPath:)];
        [ZXThemeRuntime zx_exchangeDataSourceMethodWithTargetOldCls:cls newCls:[self class] oldSel:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:) newSel:@selector(zx_collectionView:viewForSupplementaryElementOfKind:atIndexPath:)];
        [hookedTargetClassArr addObject:clsStr];
    }
    [self zx_setDataSource:set];
}

#pragma mark - UICollectionViewReset
- (UICollectionViewCell *)zx_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self zx_collectionView:collectionView cellForItemAtIndexPath:indexPath];
    if([ZXTheme defaultTheme].zx_collectionViewThemeBlock){
        ZXCollectionViewTheme *collectionViewTheme = [ZXTheme defaultTheme].zx_collectionViewThemeBlock(self);
        if(collectionViewTheme.cellForItemAtIndexPath){
            cell = collectionViewTheme.cellForItemAtIndexPath(cell,indexPath);
        }
    }
    return cell;
}

- (UICollectionReusableView *)zx_collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = [self zx_collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    if([ZXTheme defaultTheme].zx_collectionViewThemeBlock){
        ZXCollectionViewTheme *collectionViewTheme = [ZXTheme defaultTheme].zx_collectionViewThemeBlock(self);
        if(collectionViewTheme.viewForSupplementaryElement){
            reusableView = collectionViewTheme.viewForSupplementaryElement(reusableView,kind,indexPath);
        }
    }
    return reusableView;
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeCollectionView)];
}

- (void)zx_setBackgroundView:(UIView *)set{
    [self zx_setBackgroundView:ZXThemeData(ZXThemeTypeCollectionView)];
}

#pragma mark - UINavigationBarThemeInit
- (instancetype)zx_initWithCoder:(NSCoder *)aDecoder{
    id selfIns = [self zx_initWithCoder:aDecoder];
    [self zx_initAction];
    return selfIns;
}

- (instancetype)zx_initWithFrame:(CGRect)rect{
    id selfIns = [self zx_initWithFrame:rect];
    [self zx_initAction];
    return selfIns;
}

- (void)zx_initAction{
    if([ZXTheme defaultTheme].zx_collectionViewThemeBlock){
        [self triggerSetTheme];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(triggerSetTheme) name:ZXThemeUpdateNotification object:nil];
    
}
- (void)triggerSetTheme{
    [ZXThemeRuntime addThemeTrigger:self];
    [self reloadData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
