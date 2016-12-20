//
//  MTCitySearchResultViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCitySearchResultViewController.h"

@interface MTCitySearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>

//查询到结果列表
@property(nonatomic,strong) UITableView * tableView;


@end

@implementation MTCitySearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}


#pragma mark - 设置视图
- (void)setUpUI{
    //添加控件
    [self.view addSubview:self.tableView];
    
    
    //添加约束
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - UITableViewDataSource 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"北京";
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //多余的cell不再显示出来
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

@end
