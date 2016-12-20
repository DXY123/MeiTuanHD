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
//分类模型
#import "MTCategoryModel.h"

@interface MTCategoryViewController ()
//下拉菜单
@property(nonatomic,strong) MTDropDownView * dropDownView;
//保存分类模型数据
@property(nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation MTCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData{
    //路径
    NSString * file = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
    //加载plist文件数组
    NSArray * plistArray = [NSArray arrayWithContentsOfFile:file];
    //保存数据
    [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTCategoryModel class] json:plistArray]];
    //给下拉菜单赋值
    self.dropDownView.categoryArray = self.dataArray.copy;
    
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

- (NSMutableArray *)dataArray{
    if(!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
