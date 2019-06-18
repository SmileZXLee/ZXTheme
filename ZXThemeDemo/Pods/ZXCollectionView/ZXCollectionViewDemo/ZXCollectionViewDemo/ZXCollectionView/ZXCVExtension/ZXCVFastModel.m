//
//  ZXCVFastModel.m
//  ZXCollectionView
//
//  Created by 李兆祥 on 2019/4/8.
//  Copyright © 2019 李兆祥. All rights reserved.
//  https://github.com/SmileZXLee/ZXCollectionView

#import "ZXCVFastModel.h"
#import "ZXCollectionViewConfig.h"
@implementation ZXCVFastModel
-(instancetype)init{
    if(self = [super init]){
        if(self.colCount || self.rowCount)return self;
        self.margin = FAST_MARGIN;
        self.colCount = FAST_COLCOUNT;
        self.rowCount = FAST_ROWCOUNT;
        self.scrollDirection = FAST_SCROLL_DIR;
        self.itemH = FAST_ITEMH;
        self.itemHMultiply = FAST_ITEMHMUL;
        self.itemHConstant = FAST_ITEMHCON;
        self.itemW = FAST_ITEMW;
        self.itemWMultiply = FAST_ITEMWMUL;
        self.itemWConstant = FAST_ITEMWCON;
        self.attachMargin = FAST_ATTMARGIN;
    }
    return self;
}
-(void)setItemH:(CGFloat)itemH{
    _itemH = itemH;
    if(itemH > 0){
        _itemHMultiply = -1;
        _itemHConstant = -1;
    }
}
-(void)setItemHMultiply:(CGFloat)itemHMultiply{
    _itemHMultiply = itemHMultiply;
    if(itemHMultiply > 0 && !(itemHMultiply == FAST_ITEMHMUL)){
        _itemH = -1;
        _itemHConstant = -1;
    }
}
-(void)setItemHConstant:(CGFloat)itemHConstant{
    _itemHConstant = itemHConstant;
    if(itemHConstant > 0){
        _itemH = -1;
        _itemHMultiply = -1;
    }
}

-(void)setItemW:(CGFloat)itemW{
    _itemW = itemW;
    if(itemW > 0){
        _itemWMultiply = -1;
        _itemWConstant = -1;
    }
}
-(void)setItemWMultiply:(CGFloat)itemWMultiply{
    _itemWMultiply = itemWMultiply;
    if(itemWMultiply > 0){
        _itemW = -1;
        _itemWConstant = -1;
    }
}
-(void)setItemWConstant:(CGFloat)itemWConstant{
    _itemWConstant = itemWConstant;
    if(itemWConstant > 0 && !(itemWConstant == FAST_ITEMWMUL)){
        _itemW = -1;
        _itemWMultiply = -1;
    }
}

-(void)setColCount:(NSUInteger)colCount{
    colCount = !colCount ? 1 : colCount;
    _colCount = colCount;
}
-(void)setRowCount:(NSUInteger)rowCount{
    rowCount = !rowCount ? 1 : rowCount;
    _rowCount = rowCount;
}
@end
