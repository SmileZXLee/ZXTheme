//
//  UIImage+ZXTheme.m
//  ZXTheme
//
//  Created by 李兆祥 on 2019/6/3.
//  Copyright © 2019 李兆祥. All rights reserved.
//

#import "UIImage+ZXTheme.h"

@implementation UIImage (ZXTheme)
- (UIImage *)grayImage{
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,
                                                  width,
                                                  height,
                                                  8,
                                                  0,
                                                  colorSpace,
                                                  bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,
                       CGRectMake(0, 0, width, height), self.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    CGContextRelease(context);
    return grayImage;
}

- (UIImage*)renderColor:(UIColor *)color{
    UIImage *grayImg = self;
    UIGraphicsBeginImageContextWithOptions(grayImg.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, grayImg.size.width, grayImg.size.height);
    UIRectFill(bounds);
    [grayImg drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [grayImg drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
