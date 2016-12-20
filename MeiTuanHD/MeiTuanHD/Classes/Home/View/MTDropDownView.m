//
//  MTDropDownView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDropDownView.h"

@interface MTDropDownView ()<UITableViewDelegate,UITableViewDataSource>

//左侧tableView
@property(nonatomic,strong) UITableView * leftTableView;
//右侧tableView
@property(nonatomic,strong) UITableView * rightTableView;
@end

@implementation MTDropDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 设置视图
- (void)setUpUI{
    //添加控件
    [self addSubview:self.leftTableView];
    [self addSubview:self.rightTableView];
    //添加约束
    //.dividedBy(n) n分之一
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self).dividedBy(2);  //除以2
    }];
    
    [self.rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.leftTableView.mas_right);
        make.width.equalTo(self.leftTableView);
    }];
    
    
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];;
    }
    cell.textLabel.text = @"哈哈";
    return cell;
}


#pragma mark - 懒加载控件
//左侧列表
- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [UITableView new];
        //设置代理
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = [UIColor orangeColor];
    }
    return _leftTableView;
}
//右侧列表
- (UITableView *)rightTableView{
    if (!_rightTableView) {
        _rightTableView = [UITableView new];
        //设置代理
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = [UIColor redColor];
    }
    return _rightTableView;
}

@end
