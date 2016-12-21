//
//  MTCitySearchResultViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCitySearchResultViewController.h"
//城市模型
#import "MTCityModel.h"


@interface MTCitySearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>

//查询到结果列表
@property(nonatomic,strong) UITableView * tableView;
//保存cities Plist文件的数据数组
@property(nonatomic,strong) NSMutableArray * dataArray;
//保存查询到的结果集
@property(nonatomic,strong) NSMutableArray * resultArray;


@end

@implementation MTCitySearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}


#pragma mark - 加载数据
- (void)loadData{
    //路径
    NSString * file = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
    //得到plist数组
    NSArray * plistArr = [NSArray arrayWithContentsOfFile:file];
    
    //字典转模型 保存数据
    [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTCityModel class] json:plistArr]];
    NSLog(@"数据:%@",self.dataArray);
    
}

#pragma mark - 重写set方法监听文字改变
- (void)setSearchText:(NSString *)searchText{
    // 01 copy
    _searchText = [searchText copy];
    //02 全部转成小写再查询
    searchText = [searchText lowercaseString];
    //2.5 每次有文字改变 都需要清空resultArray
    [self.resultArray removeAllObjects];
    //03 遍历保存城市模型的数组
    for (MTCityModel * model in self.dataArray) {
        //如果输入的内容属于模型属性的一部分,就要保存模型的name
        if ([model.name containsString:searchText] || [model.pinYin containsString:searchText] || [model.pinYinHead containsString:searchText]) {
            //添加name
            [self.resultArray addObject:model.name];
        }
    }
    //04 刷新UITableView
    [self.tableView reloadData];
    
    
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
    return self.resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.resultArray[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"查询到%ld个结果",self.resultArray.count];
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


//保存plist文件数据
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


//保存查询结果城市集合
-(NSMutableArray *)resultArray{
    if (!_resultArray) {
        _resultArray = [NSMutableArray array];
    }
    return _resultArray;
}

@end
