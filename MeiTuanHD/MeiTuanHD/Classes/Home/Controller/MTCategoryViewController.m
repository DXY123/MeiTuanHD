//
//  MTCategoryViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCategoryViewController.h"
//自定义下拉菜单view
#import "MTDropDownView.h"

@interface MTCategoryViewController ()
//下拉菜单
@property(nonatomic,strong) MTDropDownView * dropDownView;

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
    [self.view addSubview:self.dropDownView];
    
    //添加约束
    [self.dropDownView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - 懒加载
- (MTDropDownView *)dropDownView{
    if (!_dropDownView) {
        _dropDownView = [MTDropDownView new];
    }
    return _dropDownView;
}

@end
