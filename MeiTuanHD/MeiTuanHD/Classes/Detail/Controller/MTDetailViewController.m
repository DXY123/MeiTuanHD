//
//  MTDetailViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/29.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailViewController.h"
#import "MTDetailNavView.h"


@interface MTDetailViewController ()
//自定义导航的view
@property(nonatomic,strong) MTDetailNavView * detailNavView;

@end

@implementation MTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

#pragma mark - 监听方法
//自定义navView的返回按钮点击事件
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 设置视图
- (void)setUpUI{
    self.view.backgroundColor = HMColor(222, 222, 222);
    //添加控件
    [self.view addSubview:self.detailNavView];
    
    [self.detailNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.equalTo(CGSizeMake(400, 64));
    }];
    
}


#pragma mark - 懒加载
- (MTDetailNavView *)detailNavView{
    if (!_detailNavView) {
        WeakSelf(MTDetailViewController);
        _detailNavView = [MTDetailNavView new];
        [_detailNavView setDetailNavViewBlock:^{
            [weakSelf backClick];
        }];
    }
    return _detailNavView;
}

@end
