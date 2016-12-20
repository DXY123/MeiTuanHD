//
//  UIImage+MTCategory.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "UIImage+MTCategory.h"

@implementation UIImage (MTCategory)

/*
 
 typedef NS_ENUM(NSInteger, UIImageResizingMode) {
    UIImageResizingModeTile,  平铺
    UIImageResizingModeStretch,  拉伸
 };
 
 */


+ (UIImage *)imageResizableImageWithImageName:(NSString *)imgName{
    
    UIImage * image = [UIImage imageNamed:imgName];
    
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    //方式2
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
}

@end
