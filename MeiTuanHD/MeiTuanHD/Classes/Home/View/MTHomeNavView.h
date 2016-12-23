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

//设置labTitle的text
- (void)setLabTitleText:(NSString *)text;
//设置labSubTitle的text
- (void)setLabSubTitleText:(NSString *)text;
//设置覆盖按钮的image和高亮的image
- (void)setIcon:(NSString *)icon hlIcon:(NSString *)hlIcon;

@end
