//
//  MTHomeNavView.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHomeNavView : UIView

//监听当前view中的覆盖按钮点击事件block回调 01
@property(nonatomic,copy) void(^homeNavViewBlock)();

@end
