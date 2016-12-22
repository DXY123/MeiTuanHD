//
//  MTCityViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTCityViewController.h"
//城市组模型
#import "MTCityGroupModel.h"
//查询城市结果控制器
#import "MTCitySearchResultViewController.h"

@interface MTCityViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
//searchBar
@property(nonatomic,strong) UISearchBar * searchBar;
//城市列表
@property(nonatomic,strong) UITableView * tableView;
//保存城市数组
@property(nonatomic,strong) NSMutableArray<MTCityGroupModel *> * dataArray;
//覆盖按钮
@property(nonatomic,strong) UIButton * btnCover;
//搜索城市结果集控制器
@property(nonatomic,strong) MTCitySearchResultViewController * citySearchResultVc;

@end

@implementation MTCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData{
    //路径
    NSString * file = [[NSBundle mainBundle] pathForResource:@"cityGroups.plist" ofType:nil];
    //加载plist
    NSArray * plistArray = [NSArray arrayWithContentsOfFile:file];

    //字典转模型 然后保存模型到城市数组中
    [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTCityGroupModel class] json:plistArray]];
    
    //刷新tableView
    [self.tableView reloadData];
}

#pragma mark - 设置视图
- (void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNav];
    
    //添加控件
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.btnCover];
    [self.view addSubview:self.citySearchResultVc.view];
    
    //添加约束
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(15);
        make.right.offset(-15);
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom).offset(15);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.btnCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom).offset(15);
    }];
    
    [self.citySearchResultVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchBar.mas_bottom).offset(15);
    }];
    
}

#pragma mark - 设置导航
- (void)setUpNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImgName:@"btn_navigation_close" Target:self action:@selector(backClick)];
    self.title = @"选择城市";
}

#pragma mark - 监听方法
//返回按钮点击
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

//覆盖按钮点击
- (void)btnCoverClick{
    //取消键盘的第一响应
    [self.searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource 代理方法
//有几组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
//每组几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //使用范型优化
//    MTCityGroupModel * cityGroupModel = self.dataArray[section];
//    return cityGroupModel.cities.count;
    return self.dataArray[section].cities.count;
}
//cell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    //得到模型
//    MTCityGroupModel * cityGroupModel = self.dataArray[indexPath.section];
//    
//    //titleLabel赋值
//    cell.textLabel.text = cityGroupModel.cities[indexPath.row];
    cell.textLabel.text = self.dataArray[indexPath.section].cities[indexPath.row];
    return cell;
}

//分组组头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    //得到模型
    //使用范型优化
//    MTCityGroupModel * cityGroupModel = self.dataArray[section];
//    return cityGroupModel.title;
    return self.dataArray[section].title;
}

//显示tableView右侧索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    //创建临时数组保存title
    NSMutableArray * tempArr = [NSMutableArray array];
    //遍历数组
    for (MTCityGroupModel * cityGroupModel in self.dataArray) {
        //保存title
        [tempArr addObject:cityGroupModel.title];
    }
    return tempArr.copy;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //发送通知
    [MTNotificationCenter postNotificationName:HMCityDidChangeNotifacation object:nil userInfo:@{HMSelectCityName: self.dataArray[indexPath.section].cities[indexPath.row]}];
    
    
    
}

#pragma mark - UISearchBarDelegate 代理方法
#pragma mark - searchbar开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"开始编辑");
    //01 隐藏导航栏
    [self.navigationController setNavigationBarHidden:true animated:true];
    //02 重新设置searchBar背景图片
    [self.searchBar setBackgroundImage:[UIImage imageResizableImageWithImageName:@"bg_login_textfield_hl"]];
    
    //03 显示取消按钮
    [self.searchBar setShowsCancelButton:true animated:true];
    _searchBar.tintColor = HMColor(21, 188, 173);
    
    //04 遍历searchBar子控件 拿到这个按钮 然后重新设置title
    //UInavigationButton 是系统私有 但可以肯定他一定继承UIButton
    NSLog(@"%@",self.searchBar.subviews[0].subviews);
    
    for (UIView * view in self.searchBar.subviews[0].subviews) {
        //如果判断class是UIButton
        if ([view isKindOfClass:[UIButton class]]) {
            //设置title
            //强转
            UIButton * btn = (UIButton *)view;
            //
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            
        }
    }
    //显示遮盖按钮
    self.btnCover.hidden = false;
    
}

#pragma mark - 结束编辑
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    // 01 显示导航栏
    [self.navigationController setNavigationBarHidden:false animated:true];
    // 02 重新设置searchbar背景图片
    [self.searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    
    // 03 关闭取消按钮
    [self.searchBar setShowsCancelButton:false animated:YES];
    // 04 隐藏遮盖按钮
    self.btnCover.hidden = true;
    // 05 清空searchBar上的文字
    self.searchBar.text = @"";
    //06 隐藏CitySearchResultVc
    self.citySearchResultVc.view.hidden = true;
}

#pragma mark - 监听取消按钮点击
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消键盘的第一响应
    [self.searchBar resignFirstResponder];
}

#pragma mark - 监听文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //判断searchBar text长度
    if (self.searchBar.text.length > 0) {
        //显示CitySearchResultVc
        self.citySearchResultVc.view.hidden = false;
        //需要给citysearchResult的属性赋值
        self.citySearchResultVc.searchText = self.searchBar.text;
        
    }else{
        //隐藏CitySearchResultVc
        self.citySearchResultVc.view.hidden = true;
    }
}



#pragma mark - 懒加载
//searchBar
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        //设置代理
        _searchBar.delegate = self;
        //设置默认文字
        _searchBar.placeholder = @"请输入城市名或拼音";
        [_searchBar setBackgroundImage:[UIImage imageNamed:@"bg_login_textfield"]];
    }
    return _searchBar;
}

//城市列表
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        //设置代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //索引颜色设置
        _tableView.sectionIndexColor = HMColor(21, 188, 173);
    }
    return _tableView;
}
//城市数组
- (NSMutableArray<MTCityGroupModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//覆盖按钮
-(UIButton *)btnCover{
    if (!_btnCover) {
        _btnCover = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCover.backgroundColor = [UIColor blackColor];
        //透明度
        _btnCover.alpha = 0.3;
        [_btnCover addTarget:self action:@selector(btnCoverClick) forControlEvents:UIControlEventTouchUpInside];
        //首次进入的时候覆盖按钮不显示,需要隐藏
        _btnCover.hidden = YES;
    }
    return _btnCover;
}

//搜索城市结果控制器
- (MTCitySearchResultViewController *)citySearchResultVc{
    if (!_citySearchResultVc) {
        _citySearchResultVc = [MTCitySearchResultViewController new];
        //把该控制器添加为CityVc的子控制器
        [self addChildViewController:_citySearchResultVc];
        //一开始隐藏当前控制器的view
        _citySearchResultVc.view.hidden = true;
    }
    return _citySearchResultVc;
}

@end
