//
//  ViewController.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ViewController.h"
#import "ZXTheme.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testLabel.textColor = [UIColor blueColor];
    UIButton *btn = [[UIButton alloc]init];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 100, 50, 50);
    [self.view addSubview:btn];
}

@end
