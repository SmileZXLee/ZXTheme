//
//  ZXFindVC.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/4.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXFindVC.h"
#import "ZXFindHeaderView.h"
#import "ZXFindCell.h"
#import "ZXFindModel.h"
@interface ZXFindVC ()

@end

@implementation ZXFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    ZXCollectionView *collectionView = [[ZXCollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    collectionView.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    [self.view addSubview:collectionView];
    collectionView.zx_setCellClassAtIndexPath = ^Class _Nonnull(NSIndexPath * _Nullable indexPath) {
        return [ZXFindCell class];
    };
    collectionView.zx_setHeaderClassInSection = ^Class _Nonnull(NSInteger section) {
        return [ZXFindHeaderView class];
    };
    ZXCVFastModel *fastModel = [[ZXCVFastModel alloc]init];
    fastModel.colCount = 2;
    fastModel.itemHConstant = 30;
    fastModel.superW = [UIScreen mainScreen].bounds.size.width;
    [collectionView zx_fastWithModel:fastModel];
    collectionView.zxDatas = [self getData];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"弹窗测试" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSMutableArray *)getData{
    NSMutableArray *dataArr = [NSMutableArray array];
    for(NSUInteger i = 0;i < 30;i++){
        ZXFindModel *model = [[ZXFindModel alloc]init];
        model.dec = [NSString stringWithFormat:@"城市%lu",i];
        model.imageName = @"testimage3";
        [dataArr addObject:model];
    }
    return dataArr;
}

    




@end
