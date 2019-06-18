//
//  ZXTabbarVC.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/4.
//  Copyright © 2019 李兆祥. All rights reserved.
//
#define TabBarTextSize 11.0
#import "ZXTabbarVC.h"
#import "ZXHomeVC.h"
#import "ZXFindVC.h"
#import "ZXMeVC.h"
#import "ZXNavVC.h"
@implementation ZXTabbarVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [UITabBar appearance].translucent = NO;
    [[UINavigationBar appearance] setTranslucent:NO];
//    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
//    [[UINavigationBar appearance] setTranslucent:NO];
//    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
//    [UITabBar appearance].translucent = NO;
//    [UITabBar appearance].barTintColor = [UIColor redColor];
    [self initTabBar];
}

-(void)initTabBar{
    ZXHomeVC *VC1 = [[ZXHomeVC alloc]init];
    ZXFindVC *VC2 = [[ZXFindVC alloc]init];
    ZXMeVC *VC3 = [[ZXMeVC alloc]init];
    NSMutableArray *navVcArr = [NSMutableArray array];
    NSArray *vcArr = @[VC1,VC2,VC3];
    NSArray *viewDataArr = @[
                             @{@"title":@"首页",@"imageName":@"ico-home2",@"sel_imageName":@"ico-home"},
                             @{@"title":@"发现",@"imageName":@"ico_find2",@"sel_imageName":@"ico_find"},
                             @{@"title":@"我的",@"imageName":@"ico_my2",@"sel_imageName":@"ico_my"},
                             ];
    NSUInteger index = 0;
    for (NSDictionary *viewDataDic in viewDataArr) {
        UIViewController *VC = vcArr[index];
        [self addChildVc:VC title:viewDataDic[@"title"] imageName:viewDataDic[@"imageName"] selectedImageName:viewDataDic[@"sel_imageName"]];
        ZXNavVC *navVC = [[ZXNavVC alloc]initWithRootViewController:VC];
        [navVcArr addObject:navVC];
        index++;
    }
    
    self.viewControllers = [navVcArr mutableCopy];
    
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageN selectedImageName:(NSString *)selectedImageN {
    childVc.tabBarItem.image = [[UIImage imageNamed:imageN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.title = title;
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageN] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:TabBarTextSize],NSFontAttributeName, AppLightColor,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:TabBarTextSize],NSFontAttributeName, AppMainColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
@end
