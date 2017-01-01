//
//  MTDetailViewController.h
//  MeiTuanHD
//
//  Created by DXY on 16/12/29.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTDealModel;

@interface MTDetailViewController : UIViewController

//供外界赋值的模型
@property(nonatomic,strong) MTDealModel * dealModel;

@end
