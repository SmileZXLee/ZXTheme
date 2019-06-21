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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setDarkTheme];
    });
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ZXTabbarVC *VC = [[ZXTabbarVC alloc]init];
    window.rootViewController = VC;
    self.window = window;
    [self.window makeKeyWindow];
    return YES;
}
- (void)setDarkTheme{
    [ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
        ZXLabelTheme *theme = [[ZXLabelTheme alloc]init];
        label.layer.borderColor = [UIColor redColor].CGColor;
        label.layer.borderWidth = 1;
        return theme;
    };

    //设置TabBar透明度为不透明，背景色为深灰色0x1c1c1c
    [ZXTheme defaultTheme].zx_tabBarThemeBlock  = ^ZXTabBarTheme * _Nonnull(UITabBar * _Nonnull tabBar) {
        
        ZXTabBarTheme *tabBarTheme = [[ZXTabBarTheme alloc]init];
        tabBarTheme.translucent = NO;
        tabBarTheme.barTintColor = ZXThemeDarkLevel2Color;
        return tabBarTheme;
    };
    //设置NavigationBar透明度为不透明，背景色为深灰色0x1c1c1c，设置导航栏的标题颜色为0xffffff
    [ZXTheme defaultTheme].zx_navigationBarThemeBlock = ^ZXNavigationBarTheme * _Nonnull(UINavigationBar * _Nonnull navigationBar) {
        ZXNavigationBarTheme *navigationBarTheme  = [[ZXNavigationBarTheme alloc]init];
        navigationBarTheme.translucent = NO;
        navigationBarTheme.barTintColor = ZXThemeDarkLevel2Color;
        NSMutableDictionary *titleTextAttributes = [navigationBar.titleTextAttributes mutableCopy];
        if(!titleTextAttributes){
            titleTextAttributes = [NSMutableDictionary dictionary];
        }
        [titleTextAttributes setValue:ZXThemeLightLevel2Color forKey:NSForegroundColorAttributeName];
        navigationBarTheme.titleTextAttributes = titleTextAttributes;
        return navigationBarTheme;
    };
    
    [ZXTheme defaultTheme].zx_tableViewThemeBlock = ^ZXTableViewTheme * _Nonnull(UITableView * _Nonnull tableView) {
        ZXTableViewTheme *tableViewTheme = [[ZXTableViewTheme alloc]init];
        tableViewTheme.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableViewTheme.backgroundColor = ZXThemeDarkLevel1Color;
        tableViewTheme.viewForHeaderInSection = ^UIView * _Nonnull(UIView * _Nonnull headerView, NSUInteger section) {
            headerView.backgroundColor = ZXThemeDarkLevel2Color;
            return headerView;
        };
        tableViewTheme.cellForRowAtIndexPath = ^UITableViewCell * _Nonnull(UITableViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
            cell.backgroundColor = ZXThemeDarkLevel2Color;
            for (UIView *view in cell.contentView.subviews) {
                if([view isKindOfClass:[UILabel class]]){
                    ((UILabel *)view).textColor = ZXThemeLightLevel2Color;
                }
                if([view isKindOfClass:[UIImageView class]]){
                    ((UIImageView *)view).image = [((UIImageView *)view).image renderColor:ZXThemeLightLevel2Color];
                }
            }
            return cell;
        };
        return tableViewTheme;
    };
    [ZXTheme defaultTheme].zx_collectionViewThemeBlock = ^ZXCollectionViewTheme * _Nonnull(UICollectionView * _Nonnull collectionView) {
        ZXCollectionViewTheme *collectionViewTheme = [[ZXCollectionViewTheme alloc]init];
        collectionViewTheme.backgroundColor = ZXThemeDarkLevel1Color;
        collectionViewTheme.cellForItemAtIndexPath = ^UICollectionViewCell * _Nonnull(UICollectionViewCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
            cell.backgroundColor = ZXThemeDarkLevel2Color;
            for (UIView *view in cell.contentView.subviews) {
                if([view isKindOfClass:[UILabel class]]){
                    ((UILabel *)view).textColor = ZXThemeLightLevel2Color;
                }
            }
            return cell;
        };
        collectionViewTheme.viewForSupplementaryElement = ^UICollectionReusableView * _Nonnull(UICollectionReusableView * _Nonnull reusableView, NSString * _Nonnull kind, NSIndexPath * _Nonnull indexPath) {
            reusableView.backgroundColor = ZXThemeDarkLevel2Color;
            return reusableView;
        };
        return collectionViewTheme;
    };
    
    [ZXTheme defaultTheme].zx_viewThemeBlock = ^ZXViewTheme * _Nonnull(UIView * _Nonnull view) {
        ZXViewTheme *viewTheme = [[ZXViewTheme alloc]init];
        if([view.nextResponder isKindOfClass:[UIViewController class]]){
            viewTheme.backgroundColor = ZXThemeDarkLevel1Color;
        }
        return viewTheme;
    };
    [[ZXTheme defaultTheme] zx_themeUpdate];
}

-(void)setTheme{
    
    return;
    [ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
        ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
        labelTheme.textColor = [UIColor blueColor];
        labelTheme.textAlignment = NSTextAlignmentCenter;
        return labelTheme;
    };
    [ZXTheme defaultTheme].zx_tableViewThemeBlock = ^ZXTableViewTheme * _Nonnull(UITableView * _Nonnull tableView) {
        ZXTableViewTheme *tableViewTheme = [[ZXTableViewTheme alloc]init];
        tableViewTheme.viewForHeaderInSection = ^UIView * _Nonnull(UIView * _Nonnull headerView, NSUInteger section) {
            headerView.backgroundColor = [UIColor redColor];
            return headerView;
        };
        return tableViewTheme;
    };
    return;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[ZXTheme defaultTheme] zx_themeUpdate];
    });
    return;
    //[[ZXTheme defaultTheme] zx_themeUpdate];
    
    [ZXTheme defaultTheme].zx_tabBarThemeBlock = ^ZXTabBarTheme * _Nonnull(UITabBar * _Nonnull tabBar) {
        ZXTabBarTheme *tabBarTheme = [[ZXTabBarTheme alloc]init];
        tabBarTheme.translucent = NO;
        tabBarTheme.barTintColor = [UIColor greenColor];
        tabBarTheme.tintColor = [UIColor redColor];
        return tabBarTheme;
    };
    [ZXTheme defaultTheme].zx_tabBarItemThemeBlock = ^ZXTabBarItemTheme * _Nonnull(UITabBarItem * _Nonnull tabBarItem) {
        ZXTabBarItemTheme *tabBarItemTheme = [[ZXTabBarItemTheme alloc]init];
        tabBarItemTheme.selectedImageColor = [UIColor redColor];
        [tabBarItemTheme setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:11],NSFontAttributeName, [UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        return tabBarItemTheme;
    };
    [ZXTheme defaultTheme].zx_navigationBarThemeBlock = ^ZXNavigationBarTheme * _Nonnull(UINavigationBar * _Nonnull navigationBar) {
        ZXNavigationBarTheme *navigationBarTheme = [[ZXNavigationBarTheme alloc]init];
        navigationBarTheme.translucent = NO;
        navigationBarTheme.barTintColor = UIColorFromRGB(0x1c1c1c);
        navigationBarTheme.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
        return navigationBarTheme;
    };
    [ZXTheme defaultTheme].zx_viewThemeBlock = ^ZXViewTheme * _Nonnull(UIView * _Nonnull view) {
        ZXViewTheme *viewTheme = [[ZXViewTheme alloc]init];
        BOOL is = [view isKindOfClass:[UITableView class]];
        if(is){
           viewTheme.backgroundColor = [UIColor yellowColor];
        }
        
        return viewTheme;
    };
    
    [ZXTheme defaultTheme].zx_labelThemeBlock = ^ZXLabelTheme * _Nonnull(UILabel * _Nonnull label) {
        
        ZXLabelTheme *labelTheme = [[ZXLabelTheme alloc]init];
        labelTheme.textColor = [UIColor blueColor];
        if([label.text isEqualToString:@"取消"]){
            labelTheme.textColor = [UIColor redColor];
            labelTheme.backgroundColor = [UIColor redColor];
            
            NSLog(@"llll%@",[label zx_getViewController]);
        }
        labelTheme.textAlignment = NSTextAlignmentRight;
        return labelTheme;
    };
    
    [ZXTheme defaultTheme].zx_buttonThemeBlock = ^ZXButtonTheme * _Nonnull(UIButton * _Nonnull button) {
        ZXButtonTheme *buttonTheme = [[ZXButtonTheme alloc]init];
        [buttonTheme setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [buttonTheme setBackgroundImage:[UIImage imageNamed:@"kanjia"] forState:UIControlStateNormal];
        buttonTheme.backgroundColor = [UIColor yellowColor];
        return buttonTheme;
    };
    
    [ZXTheme defaultTheme].zx_segmentedControlThemeBlock = ^ZXSegmentedControlTheme * _Nonnull(UISegmentedControl * _Nonnull segmentedControl) {
        ZXSegmentedControlTheme *segmentedControlTheme = [[ZXSegmentedControlTheme alloc]init];
        segmentedControlTheme.tintColor = [UIColor redColor];
        return segmentedControlTheme;
    };
    
    [ZXTheme defaultTheme].zx_textFieldThemeBlock = ^ZXTextFieldTheme * _Nonnull(UITextField * _Nonnull textField) {
        ZXTextFieldTheme *textFieldTheme = [[ZXTextFieldTheme alloc]init];
        textFieldTheme.tintColor = [UIColor redColor];
        textFieldTheme.textColor = [UIColor blueColor];
        textFieldTheme.placeholderColor = [UIColor redColor];
        return textFieldTheme;
    };
    
    [ZXTheme defaultTheme].zx_sliderThemeBlock = ^ZXSliderTheme * _Nonnull(UISlider * _Nonnull slider) {
        ZXSliderTheme *sliderTheme = [[ZXSliderTheme alloc]init];
        //sliderTheme.minimumTrackTintColor = [UIColor redColor];
        sliderTheme.maximumTrackTintColor = [UIColor blueColor];
        sliderTheme.thumbTintColor = [UIColor yellowColor];
        return sliderTheme;
    };
    
    [ZXTheme defaultTheme].zx_switchThemeBlock = ^ZXSwitchTheme * _Nonnull(UISwitch * _Nonnull mySwitch) {
        ZXSwitchTheme *switchTheme = [[ZXSwitchTheme alloc]init];
        switchTheme.onTintColor = [UIColor redColor];
        switchTheme.tintColor = [UIColor redColor];
        return switchTheme;
    };
    [ZXTheme defaultTheme].zx_activityIndicatorViewThemeBlock = ^ZXActivityIndicatorViewTheme * _Nonnull(UIActivityIndicatorView * _Nonnull activityIndicatorView) {
        ZXActivityIndicatorViewTheme *activityIndicatorViewTheme = [[ZXActivityIndicatorViewTheme alloc]init];
        activityIndicatorViewTheme.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        return activityIndicatorViewTheme;
    };
    [ZXTheme defaultTheme].zx_progressViewThemeBlock = ^ZXProgressViewTheme * _Nonnull(UIProgressView * _Nonnull progressView) {
        ZXProgressViewTheme *progressViewTheme = [[ZXProgressViewTheme alloc]init];
        progressViewTheme.progressTintColor = [UIColor redColor];
        progressViewTheme.trackTintColor = [UIColor blueColor];
        return progressViewTheme;
    };
    [ZXTheme defaultTheme].zx_pageControlThemeBlock = ^ZXPageControlTheme * _Nonnull(UIPageControl * _Nonnull pageControl) {
        ZXPageControlTheme *pageControlTheme = [[ZXPageControlTheme alloc]init];
        pageControlTheme.pageIndicatorTintColor = [UIColor redColor];
        pageControlTheme.currentPageIndicatorTintColor = [UIColor blueColor];
        return pageControlTheme;
    };
    [ZXTheme defaultTheme].zx_stepperThemeBlock = ^ZXStepperTheme * _Nonnull(UIStepper * _Nonnull stepper) {
        ZXStepperTheme *stepperTheme = [[ZXStepperTheme alloc]init];
        stepperTheme.tintColor = [UIColor whiteColor];
        return stepperTheme;
    };
    [ZXTheme defaultTheme].zx_imageViewThemeBlock = ^ZXImageViewTheme * _Nonnull(UIImageView * _Nonnull imageView) {
        if(imageView.frame.size.width == 50){
            ZXImageViewTheme *imageViewTheme = [[ZXImageViewTheme alloc]init];
            imageViewTheme.imageColor = [UIColor redColor];
            imageViewTheme.backgroundColor = [UIColor yellowColor];
            return imageViewTheme;
        }else{
            return nil;
        }
    };
    [ZXTheme defaultTheme].zx_textViewThemeBlock = ^ZXTextViewTheme * _Nonnull(UITextView * _Nonnull textView) {
        ZXTextViewTheme *textViewTheme = [[ZXTextViewTheme alloc]init];
        textViewTheme.textColor = [UIColor redColor];
        textViewTheme.backgroundColor = [UIColor blueColor];
        return textViewTheme;
    };
    [ZXTheme defaultTheme].zx_viewThemeBlock = ^ZXViewTheme * _Nonnull(UIView * _Nonnull view) {
        ZXViewTheme *viewTheme=  [[ZXViewTheme alloc]init];
        viewTheme.backgroundColor = [UIColor purpleColor];
        return viewTheme;
    };
    
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
