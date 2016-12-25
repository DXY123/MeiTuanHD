//
//  MTDealCell.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/23.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTDealModel;

@interface MTDealCell : UICollectionViewCell

//提供属性供外界赋值
@property(nonatomic,strong) MTDealModel * dealModel;

@end
