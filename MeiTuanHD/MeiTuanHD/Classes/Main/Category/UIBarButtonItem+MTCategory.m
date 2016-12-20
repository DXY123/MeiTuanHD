//
//  UIBarButtonItem+MTCategory.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "UIBarButtonItem+MTCategory.h"

@implementation UIBarButtonItem (MTCategory)

+(UIBarButtonItem *)BarButtonItemWithImgName:(NSString *)imgName Target:(id)target action:(SEL)action{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imgName]] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}


@end
