//
//  MTDetailViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/29.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailViewController.h"
//自定义导航
#import "MTDetailNavView.h"
//详情中间的View
#import "MTDetailCenterView.h"

#import "MTDealModel.h"

@interface MTDetailViewController ()<DPRequestDelegate>

//自定义导航的view
@property(nonatomic,strong) MTDetailNavView * detailNavView;
//详情中间的View
@property(nonatomic,strong) MTDetailCenterView * detailCenterView;

@end

@implementation MTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData{
    //实例化
    DPAPI * api = [DPAPI new];
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    params[@"deal_id"] = self.dealModel.deal_id;
    
    //发送请求
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    
}

#pragma mark - DPRequestDelegate
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSLog(@"请求成功:%@",result);
    self.dealModel = [MTDealModel yy_modelWithJSON:[result[@"deals"] firstObject]];
    
    //赋值
    self.detailCenterView.dealModel = self.dealModel;
    
}

//请求失败
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"请求失败:%@",error);
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
    [self.view addSubview:self.detailCenterView];
    
    [self.detailNavView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.equalTo(CGSizeMake(400, 64));
    }];
    
    [self.detailCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.detailNavView);
        make.top.equalTo(self.detailNavView.mas_bottom);
        make.bottom.equalTo(self.view);
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

- (MTDetailCenterView *)detailCenterView{
    if (!_detailCenterView) {
        _detailCenterView = [MTDetailCenterView new];
    }
    return _detailCenterView;
}

@end