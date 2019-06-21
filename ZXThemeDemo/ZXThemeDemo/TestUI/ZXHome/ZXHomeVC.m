//
//  ZXHomeVC.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/4.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXHomeVC.h"

@interface ZXHomeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ZXHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"首页";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = @"test";
    cell.textLabel.layer.borderColor = [UIColor blueColor].CGColor;
    cell.textLabel.layer.borderWidth = 2;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
