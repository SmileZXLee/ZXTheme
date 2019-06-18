//
//  ZXFindCell.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/14.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXFindCell.h"
#import "ZXFindModel.h"
@interface ZXFindCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;
@property (strong, nonatomic)ZXFindModel *findModel;
@end
@implementation ZXFindCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setFindModel:(ZXFindModel *)findModel{
    _findModel = findModel;
    self.imageView.image = [UIImage imageNamed:findModel.imageName];
    self.decLabel.text = findModel.dec;
}
@end
