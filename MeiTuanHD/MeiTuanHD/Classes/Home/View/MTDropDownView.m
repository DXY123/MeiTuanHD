//
//  MTDropDownView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDropDownView.h"
//分类模型
#import "MTCategoryModel.h"


@interface MTDropDownView ()<UITableViewDelegate,UITableViewDataSource>

//左侧tableView
@property(nonatomic,strong) UITableView * leftTableView;
//右侧tableView
@property(nonatomic,strong) UITableView * rightTableView;
//选中的分类模型
@property(nonatomic,strong) MTCategoryModel * selectCategoryModel;

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
    //如果是左侧列表
    if (self.leftTableView == tableView) {
        return self.categoryArray.count;
    }else{
        //右侧
        return self.selectCategoryModel.subcategories.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //左侧列表
    if (self.leftTableView == tableView) {
        static NSString * cellId = @"cellId";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        //创建模型
        MTCategoryModel * categoryModel = self.categoryArray[indexPath.row];
        //赋值textLabel
        cell.textLabel.text = categoryModel.name;
        return cell;
    }else{
        //右侧列表
        static NSString * cellId = @"cellId";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        //赋值textLabel
        cell.textLabel.text = self.selectCategoryModel.subcategories[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选择的是左侧列表,才会保存当前选中的模型
    if (self.leftTableView == tableView) {
        //创建模型
        MTCategoryModel * categoryModel = self.categoryArray[indexPath.row];
        //赋值
        self.selectCategoryModel = categoryModel;
        //刷新右侧tableView
        [self.rightTableView reloadData];
    }
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
