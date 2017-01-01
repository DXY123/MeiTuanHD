//
//  MTRestrictionsModel.h
//  MeiTuanHD
//
//  Created by DXY on 17/1/1.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRestrictionsModel : NSObject

/** 是否需要预约，0：不是，1：是*/
@property (nonatomic, assign) int is_reservation_required;
/** 是否支持随时退款，0：不是，1：是*/
@property (nonatomic, assign) int is_refundable;


@end
