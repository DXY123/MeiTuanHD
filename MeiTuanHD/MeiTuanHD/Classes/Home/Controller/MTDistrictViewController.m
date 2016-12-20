//
//  MTDistrictViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDistrictViewController.h"
//城市选择控制器
#import "MTCityViewController.h"
//自定义导航栏
#import "MTNavigationController.h"

@interface MTDistrictViewController ()<UITableViewDelegate,UITableViewDataSource>
//顶部tableView
@property(nonatomic,strong) UITableView * headTableView;

@end

@implementation MTDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

#pragma mark - 设置视图
- (void)setUpUI{
    //设置内容大小
    self.preferredContentSize = CGSizeMake(350, 350+44);
    
    //添加控件
    [self.view addSubview:self.headTableView];
    
    
    //添加约束
    [self.headTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
    }
    
    //赋值textLabel
    cell.textLabel.text = @"切换城市";
    //设置image
    cell.imageView.image = [UIImage imageNamed:@"btn_changeCity"];
    //高亮的
    cell.imageView.highlightedImage = [UIImage imageNamed:@"btn_changeCity_selected"];
    //显示箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

//选中Cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //关闭地区的下拉菜单
    [self dismissViewControllerAnimated:true completion:nil];
    
    //实例化
    MTCityViewController * cityVc = [MTCityViewController new];
    //导航栏
    MTNavigationController * cityNav = [[MTNavigationController alloc] initWithRootViewController:cityVc];
    
    //设置呈现的样式
    cityNav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    //转场样式
    cityNav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    
    
    //模态弹出(使用Application的rootViewController,即HomeViewController弹出)
    /*
     
     因为你已经把父类关闭了.所以子类无法通过模态弹出
     
     解决办法:
        正常关闭当前的地区控制器,通过调用首页来弹出省份选择控制器
     [UIApplication sharedApplication].keyWindow.rootViewController == homeVc
     
     */
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:cityNav animated:true completion:nil];
    
}


#pragma mark - 懒加载
- (UITableView *)headTableView{
    if (!_headTableView) {
        _headTableView = [UITableView new];
        //设置代理
        _headTableView.dataSource = self;
        _headTableView.delegate = self;
        //不要cell之间分割线
        _headTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //不让其滚动
        _headTableView.bounces = false;
    }
    return _headTableView;
}

@end
