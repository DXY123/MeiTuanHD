//
//  MTDetailNavView.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/30.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDetailNavView : UIView

//block回调
@property(nonatomic,copy) void (^detailNavViewBlock)();

@end
