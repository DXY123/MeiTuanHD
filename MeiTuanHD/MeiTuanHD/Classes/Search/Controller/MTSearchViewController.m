//
//  MTSearchViewController.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/1.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTSearchViewController.h"

@interface MTSearchViewController ()

//searchBar
@property(nonatomic,strong) UISearchBar * searchBar;

@end

@implementation MTSearchViewController

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
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_back" Target:self action:@selector(backClick)];
    
    self.navigationItem.titleView = self.searchBar;
    
}

#pragma mark - 监听方法
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - 懒加载
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        _searchBar.placeholder = @"请输入搜索内容";
    }
    return _searchBar;
}

@end
