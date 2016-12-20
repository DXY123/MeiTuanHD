//
//  MTCityViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCityViewController.h"

@interface MTCityViewController ()

@end

@implementation MTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}


#pragma mark - 设置视图
- (void)setUpUI{
    [self setUpNav];
}

#pragma mark - 设置导航
- (void)setUpNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImgName:@"btn_navigation_close" Target:self action:@selector(backClick)];
    self.title = @"选择城市";
}

#pragma mark - 监听方法
//返回按钮点击
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
