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
//抽取的左侧cell
#import "MTDropDownLeftCell.h"
//抽取的右侧cell
#import "MTDropDownRightCell.h"

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
    
    //左侧列表
    if (self.leftTableView == tableView) {
        
        //实例化cell
        MTDropDownLeftCell * cell = [MTDropDownLeftCell dropDownViewCellWithTableView:tableView];
        
        //如果category有值
        if (self.categoryArray) {
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
        }else{
            //代表DistrictArray有值
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
        }
        
        return cell;
    }else{
        
        //实例化
        MTDropDownRightCell * cell = [MTDropDownRightCell dropDownViewCellWithTableView:tableView];
        
        //如果categoryArray有值
        if (self.categoryArray) {
            //赋值textLabel
            cell.textLabel.text = self.selectCategoryModel.subcategories[indexPath.row];
        }else{
            //districtArray有值
            //赋值textLabel
            cell.textLabel.text = self.selectDistrictModel.subdistricts[indexPath.row];
        }
        
        return cell;
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
            //如果左侧选中的cell 对应的模型中subcategories.count == 0 就代表没有子分类数据 我们就需要发送通知
            if (categoryModel.subcategories.count == 0) {
                //发送通知 把模型直接传递到HomeVc中
                [MTNotificationCenter postNotificationName:HMCategoryDidChangeNotifacation object:nil userInfo:@{HMSelectCategoryModel: self.selectCategoryModel}];
            }
        }else{
            //如果有子分类而且选中了右侧的cell
            [MTNotificationCenter postNotificationName:HMCategoryDidChangeNotifacation object:nil userInfo:@{HMSelectCategoryModel: self.selectCategoryModel,HMSelectCategorySubtitle: self.selectCategoryModel.subcategories[indexPath.row]}];
            
            
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
