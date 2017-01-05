//
//  MTMapViewController.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/5.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTMapViewController.h"

@interface MTMapViewController ()

@end

@implementation MTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}


#pragma mark - 监听方法
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 设置视图
- (void)setUpUI{
    [self setUpNav];
}

#pragma mark - 设置导航
- (void)setUpNav{
    UIBarButtonItem * backItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_back" Target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItems = @[backItem];
    
    self.title = @"地图";
    
}

@end
