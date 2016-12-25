//
//  MTDealModel.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/25.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDealModel.h"

@implementation MTDealModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}


@end
