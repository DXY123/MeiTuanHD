//
//  MTCategoryViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCategoryViewController.h"

@interface MTCategoryViewController ()

@end

@implementation MTCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

#pragma mark - 设置视图
- (void)setUpUI{
    //设置内容大小
    self.preferredContentSize = CGSizeMake(350, 350);
}

@end
