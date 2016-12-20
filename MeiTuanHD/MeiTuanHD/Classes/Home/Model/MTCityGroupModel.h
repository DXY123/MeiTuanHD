//
//  MTCityGroupModel.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityGroupModel : NSObject

/** 标题*/
@property (nonatomic, copy) NSString *title;

/** 城市数据*/
@property (nonatomic, strong) NSArray *cities;

@end
