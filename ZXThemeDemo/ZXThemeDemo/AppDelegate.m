//
//  AppDelegate.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ZXTheme.h"
#import "ZXTabbarVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initDarkTheme];
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ZXTabbarVC *VC = [[ZXTabbarVC alloc]init];
    window.rootViewController = VC;
    self.window = window;
    [self.window makeKeyWindow];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addDarkThemeBtn];
    });
    return YES;
}


#pragma mark 添加Theme切换按钮
- (void)addDarkThemeBtn{
    UIButton *darkThemeBtn = [[UIButton alloc]init];
    darkThemeBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 60 - 10, [UIScreen mainScreen].bounds.size.height * (2 / 3.0), 60, 60);
    [darkThemeBtn addTarget:self action:@selector(darkThemeChange:) forControlEvents:UIControlEventTouchUpInside];
    darkThemeBtn.clipsToBounds = YES;
    darkThemeBtn.layer.cornerRadius = 30;
    darkThemeBtn.backgroundColor = [UIColor whiteColor];
    darkThemeBtn.layer.borderWidth = 1;
    darkThemeBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [darkThemeBtn setTitle:@"正常" forState:UIControlStateNormal];
    [darkThemeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.window addSubview:darkThemeBtn];
}

#pragma mark 切换Theme
- (void)darkThemeChange:(UIButton *)themeBtn{
    [ZXTheme defaultTheme].zx_darkTheme = ![ZXTheme defaultTheme].zx_isDarkTheme;
    [[ZXTheme defaultTheme] zx_themeUpdate];
    if([ZXTheme defaultTheme].zx_darkTheme){
        [themeBtn setTitle:@"暗黑" forState:UIControlStateNormal];
    }else{
        [themeBtn setTitle:@"正常" forState:UIControlStateNormal];
    }
    
}

#pragma mark - 设置主题
- (void)initDarkTheme{
    //设置TabBar主题
    [ZXTheme defaultTheme].zx_tabBarThemeBlock  = ^ZXTabBarTheme * _Nonnull(UITabBar * _Nonnull tabBar) {
        ZXTabBarTheme *tabBarTheme = [[ZXTabBarTheme alloc]init];
        tabBarTheme.translucent = NO;
        tabBarTheme.barTintColor = [self getTabbarTintColor];
        return tabBarTheme;
    };
    //设置NavigationBar主题
    [ZXTheme defaultTheme].zx_navigationBarThemeBlock = ^ZXNavigationBarTheme * _Nonnull(UINavigationBar * _Nonnull navigationBar) {
        ZXNavigationBarTheme *navigationBarTheme  = [[ZXNavigationBarTheme alloc]init];
        navigationBarTheme.translucent = NO;
        NSMutableDictionary *titleTextAttributes = [navigationBar.titleTextAttributes mutableCopy];
        if(!titleTextAttributes){
            titleTextAttributes = [NSMutableDictionary dictionary];
        }
        navigationBarTheme.barTintColor = [self getNavBarTintColor];
        [titleTextAttributes setValue:[self getNavBarTitleColor] forKey:NSForegroundColorAttributeName];
        navigationBarTheme.titleTextAttributes = titleTextAttributes;
        return navigationBarTheme;
    };
    //设置TableView主题
    [ZXTheme defaultTheme].zx_tableViewThemeBlock = ^ZXTableViewTheme * _Nonnull(UITableView * _Nonnull tableView) {
        ZXTableViewTheme *tableViewTheme = [[ZXTableViewTheme alloc]init];
        tableViewTheme.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableViewTheme.backgroundColor = [self getTableViewBacColor];
        tableViewTheme.viewForHeaderInSection = ^UIView * _Nonnull(UIView * _Nonnull headerView, NSUInteger section) {
            headerView.backgroundColor = [self getTableViewHeaderViewBacColor];
            for (UIView *view in headerView.subviews) {
                if([view isKindOfClass:[UILabel class]]){
                    ((UILabel *)view).textColor = [self getTableViewHeaderViewLabelTextColor];
                }
               
            }
            return headerView;
        };
        tableViewTheme.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
            cell.backgroundColor = [self getTableViewCellBacColor];
            for (UIView *view in cell.contentView.subviews) {
                if([view isKindOfClass:[UILabel class]]){
                    ((UILabel *)view).textColor = [self getTableViewCellLabelTextColor];
                }
                if([view isKindOfClass:[UIImageView class]]){
                    //图片渲染建议放在异步线程，然后再在主线程给imageView赋值
                    UIImage *orgImg = ((UIImageView *)view).image;
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        UIColor *renderColor = [self getTableViewCellImageViewRenderColor];
                        UIImage *renderedImg = [orgImg renderColor:renderColor];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            ((UIImageView *)view).image = renderedImg;
                        });
                    });
                }
            }
            return cell;
        };
        return tableViewTheme;
    };
    //设置CollectionView主题
    [ZXTheme defaultTheme].zx_collectionViewThemeBlock = ^ZXCollectionViewTheme * _Nonnull(UICollectionView * _Nonnull collectionView) {
        ZXCollectionViewTheme *collectionViewTheme = [[ZXCollectionViewTheme alloc]init];
        collectionViewTheme.backgroundColor = [self getCollectionViewBacColor];
        collectionViewTheme.cellForItemAtIndexPath = ^UICollectionViewCell * _Nonnull(UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
            cell.backgroundColor = [self getCollectionViewCellBacColor];
            for (UIView *view in cell.contentView.subviews) {
                if([view isKindOfClass:[UILabel class]]){
                    ((UILabel *)view).textColor = [self getCollectionViewCellLabelTextColor];
                }
            }
            return cell;
        };
        collectionViewTheme.viewForSupplementaryElement = ^UICollectionReusableView * _Nonnull(UICollectionReusableView * _Nonnull reusableView, NSString * _Nonnull kind, NSIndexPath * _Nonnull indexPath) {
            reusableView.backgroundColor = [self getCollectionViewHeaderViewBacColor];
            for (UIView *view in reusableView.subviews) {
                if([view isKindOfClass:[UILabel class]]){
                    ((UILabel *)view).textColor = [self getCollectionViewHeaderViewLabelTextColor];
                }
                
            }
            return reusableView;
        };
        return collectionViewTheme;
    };
    //设置View主题
    [ZXTheme defaultTheme].zx_viewThemeBlock = ^ZXViewTheme * _Nonnull(UIView * _Nonnull view) {
        ZXViewTheme *viewTheme = [[ZXViewTheme alloc]init];
        //如果是控制器View，则设置它的背景色
        if([view zx_isControllerView]){
            viewTheme.backgroundColor = [self getControllerBacViewColor];
        }
        return viewTheme;
    };
    //设置Button主题
    [ZXTheme defaultTheme].zx_buttonThemeBlock = ^ZXButtonTheme * _Nonnull(UIButton * _Nonnull button) {
        if([button.currentTitle isEqualToString:@"正常"] || [button.currentTitle isEqualToString:@"暗黑"]){
            ZXButtonTheme *buttonTheme = [[ZXButtonTheme alloc]init];
            if([ZXTheme defaultTheme].zx_isDarkTheme){
                buttonTheme.backgroundColor = ZXThemeDarkLevel2Color;
                [buttonTheme setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [buttonTheme setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
                button.layer.borderColor = [UIColor whiteColor].CGColor;
            }else{
                buttonTheme.backgroundColor = [UIColor whiteColor];
                [buttonTheme setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [buttonTheme setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
                button.layer.borderColor = [UIColor blackColor].CGColor;
            }
            return buttonTheme;
        }else{
            return nil;
        }
        
    };
    
}

#pragma mark - 获取Theme颜色
#pragma mark 获取Tabbar的背景色
- (UIColor *)getTabbarTintColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel2Color;
    }else{
        return [UIColor whiteColor];
    }
}

#pragma mark 获取NavBar的背景色
- (UIColor *)getNavBarTintColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel2Color;
    }else{
        return [UIColor whiteColor];
    }
}

#pragma mark 获取NavBar标题的颜色
- (UIColor *)getNavBarTitleColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeLightLevel2Color;
    }else{
        return [UIColor blackColor];
    }
}

#pragma mark 获取TableView背景色
- (UIColor *)getTableViewBacColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel1Color;
    }else{
        return [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    }
}

#pragma mark 获取TableViewCell背景色
- (UIColor *)getTableViewCellBacColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel2Color;
    }else{
        return [UIColor whiteColor];
    }
}

#pragma mark 获取TableViewCell中Label文字颜色
- (UIColor *)getTableViewCellLabelTextColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeLightLevel2Color;
    }else{
        return [UIColor blackColor];
    }
}

#pragma mark 获取TableViewCell中ImageView图片渲染颜色
- (UIColor *)getTableViewCellImageViewRenderColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeLightLevel2Color;
    }else{
        return [UIColor blackColor];
    }
}

#pragma mark 获取TableViewHeaderView背景色
- (UIColor *)getTableViewHeaderViewBacColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel2Color;
    }else{
        return [UIColor whiteColor];
    }
}

#pragma mark 获取TableViewHeaderView中label文字颜色
- (UIColor *)getTableViewHeaderViewLabelTextColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeLightLevel2Color;
    }else{
        return [UIColor blackColor];
    }
}


#pragma mark 获取CollectionView背景色
- (UIColor *)getCollectionViewBacColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel1Color;
    }else{
        return [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    }
}

#pragma mark 获取CollectionViewCell背景色
- (UIColor *)getCollectionViewCellBacColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel2Color;
    }else{
        return [UIColor whiteColor];
    }
}

#pragma mark 获取CollectionViewCell中Label文字颜色
- (UIColor *)getCollectionViewCellLabelTextColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeLightLevel2Color;
    }else{
        return [UIColor blackColor];
    }
}

#pragma mark 获取CollectionViewHeaderView&CollectionViewFooterView背景色
- (UIColor *)getCollectionViewHeaderViewBacColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel2Color;
    }else{
        return [UIColor whiteColor];
    }
}

#pragma mark 获取CollectionViewHeaderView&CollectionViewFooterView中label文字颜色
- (UIColor *)getCollectionViewHeaderViewLabelTextColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeLightLevel2Color;
    }else{
        return [UIColor blackColor];
    }
}

#pragma mark 获取控制器背景色
- (UIColor *)getControllerBacViewColor{
    if([ZXTheme defaultTheme].zx_isDarkTheme){
        return ZXThemeDarkLevel1Color;
    }else{
        return [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
