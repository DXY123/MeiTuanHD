//
//  MTCityViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCityViewController.h"

@interface MTCityViewController ()
//searchBar
@property(nonatomic,strong) UISearchBar * searchBar;
//城市列表
@property(nonatomic,strong) UITableView * tableView;


@end

@implementation MTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}


#pragma mark - 设置视图
- (void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    //添加控件
    [self.view addSubview:self.searchBar];
    
    //添加约束
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.offset(-15);
        
    }];
    
    
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


#pragma mark - 懒加载
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        //设置默认文字
        _searchBar.placeholder = @"请输入城市名或拼音";
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    }
    return _searchBar;
}


@end
