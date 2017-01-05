//
//  MTMateTools.h
//  MeiTuanHD
//
//  Created by DXY on 17/1/6.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTBusinessModel;

@interface MTMateTools : NSObject

//全局访问点
+ (instancetype)shared;

//提供一个方法返回对应的图片
- (NSString *)getMapImageName:(MTBusinessModel *)businessModel;

@end
