//
//  MTDistrictModel.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/22.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTDistrictModel : NSObject

/** 名字*/
@property (nonatomic, copy) NSString *name;

/** 子区域数据*/
@property (nonatomic, strong) NSArray *subdistricts;

@end
