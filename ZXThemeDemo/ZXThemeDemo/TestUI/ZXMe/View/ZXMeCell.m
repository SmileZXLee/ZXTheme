//
//  ZXMeCell.m
//  ZXThemeDemo
//
//  Created by 李兆祥 on 2019/6/5.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXMeCell.h"
#import "ZXMeModel.h"
@interface ZXMeCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;

@property (strong, nonatomic)ZXMeModel *meModel;
@end
@implementation ZXMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setMeModel:(ZXMeModel *)meModel{
    _meModel = meModel;
    self.myTitleLabel.text = meModel.title;
    self.iconImgV.image = [UIImage imageNamed:meModel.imageName];
    self.myTitleLabel.textColor = [UIColor redColor];
    //self.myTitleLabel.textAlignment = NSTextAlignmentRight;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
