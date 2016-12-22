//
//  MTCityModel.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/21.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCityModel.h"
#import "MTDistrictModel.h"


@implementation MTCityModel

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
// @"HMDistrictModel" --> Class Name
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"districts" : [MTDistrictModel class]};
}

@end
