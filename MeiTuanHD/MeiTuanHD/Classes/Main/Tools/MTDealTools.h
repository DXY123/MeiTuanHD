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

//判断是否收藏了某个团购
- (void)isCollectDealModel:(MTDealModel *)dealModel block:(void (^)(BOOL isCollect))block;

@end
