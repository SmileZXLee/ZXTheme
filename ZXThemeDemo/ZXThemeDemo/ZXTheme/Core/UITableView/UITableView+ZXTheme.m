//
//  UITableView+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/12.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UITableView+ZXTheme.h"
#import "ZXThemeTool.h"
#import <objc/message.h>
static NSMutableArray *hookedTargetClassArr;
@implementation UITableView (ZXTheme)
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
    if(![hookedTargetClassArr containsObject:clsStr]){
        [ZXThemeRuntime zx_exchangeDataSourceMethodWithTargetOldCls:cls newCls:[self class] oldSel:@selector(tableView:cellForRowAtIndexPath:) newSel:@selector(zx_tableView:cellForRowAtIndexPath:)];
        [ZXThemeRuntime zx_exchangeDataSourceMethodWithTargetOldCls:cls newCls:[self class] oldSel:@selector(tableView:viewForHeaderInSection:) newSel:@selector(zx_tableView:viewForHeaderInSection:)];
        [ZXThemeRuntime zx_exchangeDataSourceMethodWithTargetOldCls:cls newCls:[self class] oldSel:@selector(tableView:viewForFooterInSection:) newSel:@selector(zx_tableView:viewForFooterInSection:)];
        [hookedTargetClassArr addObject:clsStr];
    }
    
    [self zx_setDataSource:set];
}

#pragma mark - UITableViewThemeReset
- (UITableViewCell *)zx_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self zx_tableView:tableView cellForRowAtIndexPath:indexPath];
    if([ZXTheme defaultTheme].zx_tableViewThemeBlock){
        ZXTableViewTheme *tableViewTheme = [ZXTheme defaultTheme].zx_tableViewThemeBlock(self);
        if(tableViewTheme.cellForRowAtIndexPath){
            cell = tableViewTheme.cellForRowAtIndexPath(cell,indexPath);
        }
    }
    return cell;
}

- (UIView *)zx_tableView:(UITableView *)tableView viewForHeaderInSection:(NSUInteger)section{
    UIView *headerView = [self zx_tableView:tableView viewForHeaderInSection:section];
    if([ZXTheme defaultTheme].zx_tableViewThemeBlock){
        ZXTableViewTheme *tableViewTheme = [ZXTheme defaultTheme].zx_tableViewThemeBlock(self);
        if(tableViewTheme.viewForHeaderInSection){
            headerView = tableViewTheme.viewForHeaderInSection(headerView,section);
        }
    }
    return headerView;
}

- (UIView *)zx_tableView:(UITableView *)tableView viewForFooterInSection:(NSUInteger)section{
    UIView *footerView = [self zx_tableView:tableView viewForFooterInSection:section];
    if([ZXTheme defaultTheme].zx_tableViewThemeBlock){
        ZXTableViewTheme *tableViewTheme = [ZXTheme defaultTheme].zx_tableViewThemeBlock(self);
        if(tableViewTheme.viewForFooterInSection){
            footerView = tableViewTheme.viewForFooterInSection(footerView,section);
        }
    }
    return footerView;
}

- (void)zx_setBackgroundColor:(UIColor *)set{
    [self zx_setBackgroundColor:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setBackgroundView:(UIView *)set{
    [self zx_setBackgroundView:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setSectionIndexColor:(UIColor *)set{
    [self zx_setSectionIndexColor:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setSectionIndexBackgroundColor:(UIColor *)set{
    [self zx_setSectionIndexBackgroundColor:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setSectionIndexTrackingBackgroundColor:(UIColor *)set{
    [self zx_setSectionIndexTrackingBackgroundColor:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setSeparatorStyle:(UITableViewCellSeparatorStyle)setValue{
    id set = [NSNumber numberWithInt:setValue];
    [self zx_setSeparatorStyle:[ZXThemeData(ZXThemeTypeTableView) intValue]];
}

- (void)zx_setSeparatorColor:(UIColor *)set{
    [self zx_setSeparatorColor:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setSeparatorEffect:(UIVisualEffect *)set{
    [self zx_setSeparatorEffect:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setTableHeaderView:(UIView *)set{
    [self zx_setTableHeaderView:ZXThemeData(ZXThemeTypeTableView)];
}

- (void)zx_setTableFooterView:(UIView *)set{
    [self zx_setTableFooterView:ZXThemeData(ZXThemeTypeTableView)];
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
    if([ZXTheme defaultTheme].zx_tableViewThemeBlock){
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
