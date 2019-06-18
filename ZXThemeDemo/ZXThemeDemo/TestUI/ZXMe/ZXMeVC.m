//
//  ZXMeVC.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/4.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXMeVC.h"
#import "ZXMeCell.h"
#import "ZXMeModel.h"
#import "ZXMeHeaderView.h"
@interface ZXMeVC ()
@property (weak, nonatomic) IBOutlet ZXTableView *tableView;

@end

@implementation ZXMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.tableView.zx_setCellClassAtIndexPath = ^Class(NSIndexPath *indexPath) {
        return [ZXMeCell class];
    };
    self.tableView.zx_setHeaderClassInSection = ^Class(NSInteger section) {
        return [ZXMeHeaderView class];
    };
    self.tableView.zx_setCellHAtIndexPath = ^CGFloat(NSIndexPath *indexPath) {
        return 50;
    };
    self.tableView.zx_setHeaderHInSection = ^CGFloat(NSInteger section) {
        return 150;
    };
    self.tableView.zxDatas = [self getMeArr];
}

- (NSMutableArray *)getMeArr{
    NSMutableArray *meArr = [NSMutableArray array];
    for (int i = 0;i < 40;i++){
        ZXMeModel *model = [[ZXMeModel alloc]init];
        model.imageName = @"testimage2";
        model.title = [NSString stringWithFormat:@"测试%d",i];
        [meArr addObject:model];
    }
    return meArr;
    
}



@end
