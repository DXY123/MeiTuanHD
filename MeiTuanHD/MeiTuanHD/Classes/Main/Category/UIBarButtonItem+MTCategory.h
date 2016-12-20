//
//  UIBarButtonItem+MTCategory.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MTCategory)


//自定义导航上的按钮
+(UIBarButtonItem *)BarButtonItemWithImgName:(NSString *)imgName Target:(id)target action:(SEL)action;
    


@end
