//
//  MTDealTools.h
//  MeiTuanHD
//
//  Created by DXY on 17/1/1.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTDealModel;

@interface MTDealTools : NSObject


//全局访问点
+ (instancetype)shared;


//收藏
- (void)insertDealModel:(MTDealModel *)dealModel;

//取消收藏
- (void)deleteDealModel:(MTDealModel *)dealModel;

@end
