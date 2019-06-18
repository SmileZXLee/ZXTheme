//
//  ZXLabelTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/5/30.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "ZXLabelTheme.h"

@implementation ZXLabelTheme
- (instancetype)init{
    if(self = [super init]){
        self.textAlignment = -1;
        self.lineBreakMode = -1;
        self.highlighted = -1;
        self.adjustsFontSizeToFitWidth = -1;
        self.numberOfLines = -1;
    }
    return self;
}

@end
