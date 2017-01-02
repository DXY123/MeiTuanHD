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


/*
 
 为什么要创建单例类来把FMDB封装起来.为什么做网络封装.
 1.改框架
 2.如果不再使用FMDB之后,可能会需要修改很多地方.通过一个封装,把项目和框架做了一个项目隔离,避免框架对项目产生过多的项目污染.
 
 */


//全局访问点
+ (instancetype)shared;


//收藏
- (void)insertDealModel:(MTDealModel *)dealModel;

//取消收藏
- (void)deleteDealModel:(MTDealModel *)dealModel;

//判断是否收藏了某个团购
- (void)isCollectDealModel:(MTDealModel *)dealModel block:(void (^)(BOOL isCollect))block;

//获取美团团购列表数据
- (void)getCollectListWithPage:(NSInteger)page block:(void (^)(NSArray * modelArr))block;


@end
