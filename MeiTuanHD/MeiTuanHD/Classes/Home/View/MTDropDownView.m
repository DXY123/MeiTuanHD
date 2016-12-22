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
//地区模型
#import "MTDistrictModel.h"

@interface MTDropDownView ()<UITableViewDelegate,UITableViewDataSource>

//左侧tableView
@property(nonatomic,strong) UITableView * leftTableView;
//右侧tableView
@property(nonatomic,strong) UITableView * rightTableView;
//选中的分类模型
@property(nonatomic,strong) MTCategoryModel * selectCategoryModel;
//选中的地区模型
@property(nonatomic,strong) MTDistrictModel * selectDistrictModel;


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
    
    //如果categoryArray有值,就代表是分类下拉菜单
    if (self.categoryArray) {
        //分类菜单
        //如果是左侧列表
        if (self.leftTableView == tableView) {
            return self.categoryArray.count;
        }else{
            //右侧
            return self.selectCategoryModel.subcategories.count;
        }
    }else{
        //代表districtArray有值 代表地区下拉菜单
        if (self.leftTableView == tableView) {
            return self.districtArray.count;
        }else{
            //右侧
            return self.selectDistrictModel.subdistricts.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //如果category有值 表示分类下拉菜单
    if (self.categoryArray) {
        //左侧列表
        if (self.leftTableView == tableView) {
            static NSString * cellId = @"leftCellId";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                
                //设置背景View
                cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
                //设置选中背景View
                cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
                
            }
            
            //创建模型
            MTCategoryModel * categoryModel = self.categoryArray[indexPath.row];
            //赋值textLabel
            cell.textLabel.text = categoryModel.name;
            //设置image
            cell.imageView.image = [UIImage imageNamed:categoryModel.icon];
            //高亮的
            cell.imageView.highlightedImage = [UIImage imageNamed:categoryModel.highlighted_icon];
            
            //cell是否显示箭头
            if (categoryModel.subcategories.count > 0) {
                //表示有子分类数据 有箭头
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                //代表没有子分类数据,必须去掉箭头,因为cell重用问题
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
        }else{
            //右侧列表
            static NSString * cellId = @"rightCellId";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                
                //设置背景View
                cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
                //设置选中背景View
                cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
                
            }
            //赋值textLabel
            cell.textLabel.text = self.selectCategoryModel.subcategories[indexPath.row];
            return cell;
        }
    }else{
        //districtArray有值,表示地区下拉菜单
        //左侧列表
        if (self.leftTableView == tableView) {
            static NSString * cellId = @"leftCellId";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                
                //设置背景View
                cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
                //设置选中背景View
                cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
                
            }
            
            //创建模型
            MTDistrictModel * districtModel = self.districtArray[indexPath.row];
            //赋值textLabel
            cell.textLabel.text = districtModel.name;
            
            //cell是否显示箭头
            if (districtModel.subdistricts.count > 0) {
                //表示有子分类数据 有箭头
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                //代表没有子分类数据,必须去掉箭头,因为cell重用问题
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            return cell;
        }else{
            //右侧列表
            static NSString * cellId = @"rightCellId";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                
                //设置背景View
                cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
                //设置选中背景View
                cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
                
            }
            //赋值textLabel
            cell.textLabel.text = self.selectDistrictModel.subdistricts[indexPath.row];
            return cell;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //如果是分类的数组 也就是categArray有值
    if (self.categoryArray) {
        //选择的是左侧列表,才会保存当前选中的模型
        if (self.leftTableView == tableView) {
            //创建模型
            MTCategoryModel * categoryModel = self.categoryArray[indexPath.row];
            //赋值
            self.selectCategoryModel = categoryModel;
            //刷新右侧tableView
            [self.rightTableView reloadData];
        }
    }else{
        //如果是地区的数组,也就是districtArray有值
        //选择的是左侧列表
        if (self.leftTableView == tableView) {
            //创建模型
            MTDistrictModel * districtModel = self.districtArray[indexPath.row];
            //赋值
            self.selectDistrictModel = districtModel;
            //刷新右侧tableView
            [self.rightTableView reloadData];
        }
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
        
        //设置分割线样式
        _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        //设置分割线样式
        _rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rightTableView;
}

@end
