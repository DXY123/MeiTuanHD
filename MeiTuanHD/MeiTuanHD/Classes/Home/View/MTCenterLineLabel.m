//
//  MTCenterLineLabel.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/26.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCenterLineLabel.h"

@implementation MTCenterLineLabel


// label 的文字也是画上去的

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    /*
    //方式一 上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //绘制起点
    CGContextMoveToPoint(ref, 0, rect.size.height * 0.5);
    //绘制终点
    CGContextAddLineToPoint(ref, rect.size.width, rect.size.height * 0.5);
    //完成绘制
    CGContextStrokePath(ref);
    */
    //方式二 画矩形
    UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
    
}


@end
