//
//  MTBaseViewController.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/1.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTBaseViewController.h"
//自定义的cell
#import "MTDealCell.h"
//首页数据模型
#import "MTDealModel.h"
//详情控制器
#import "MTDetailViewController.h"


@interface MTBaseViewController ()<DPRequestDelegate>

//保存首页数据数组
@property(nonatomic,strong) NSMutableArray * dataArray;
//没有团购数据
@property(nonatomic,strong) UIImageView * imgNoData;
//记录当前页码
@property(nonatomic,assign)NSInteger currentPage;


@end

@implementation MTBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        //设置itemSize
        layout.itemSize = CGSizeMake(305, 305);
        self = [self initWithCollectionViewLayout:layout];
    }
    return self;
}


#pragma mark - 监听屏幕旋转
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    
    //记录cell的列数
    NSInteger col = 0;
    
    //判断横竖屏
    if (size.width > size.height) {
        //横屏
        col = 3;
    }else{
        //竖屏
        col = 2;
    }
    //间距
    CGFloat inset = (size.width - col * 305) / (col + 1);
    
    //得到layout
    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    
    layout.minimumLineSpacing = inset;
    //    layout.minimumInteritemSpacing = inset;
    
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    
}


static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 手动调用屏幕旋转方法
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
    
    self.collectionView.backgroundColor = HMColor(222, 222, 222);
    
    [self.view addSubview:self.imgNoData];
    
    
    
    //添加约束
    [self.imgNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    //设置默认页码
    self.currentPage = 1;
    
    [self setUpCollectionViewInfo];
    
    [self addRefresh];

}


#pragma mark - 设置下拉刷新和上拉加载更多
- (void)addRefresh{
    //下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //page = 1
        self.currentPage = 1;
        [self loadDealData];
    }];
    
    
    //上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // page++
        self.currentPage++;
        [self loadDealData];
    }];
    
    
}


#pragma mark - 加载数据
- (void)loadDealData{
    
    //显示网络指示器
    [SVProgressHUD show];
    
    //实例化
    DPAPI * api = [DPAPI new];
    
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [self setParams:params];
    
    //页码
    params[@"page"] = @(self.currentPage);
    
    NSLog(@"请求参数:%@",params);
    
    //发送请求
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}


#pragma mark - DPRequestDelegate

//请求成功
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    //关闭网络指示器
    [SVProgressHUD dismiss];
    //    NSLog(@"请求成功:%@",result);
    
    //如果是下拉刷新 -> currentPage == 1 需要把数组中元素清空
    if (self.currentPage == 1) {
        [self.dataArray removeAllObjects];
    }
    
    //字典转模型保存数据
    [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTDealModel class] json:result[@"deals"]]];
    
    //刷新
    [self.collectionView reloadData];
    
    //是否显示无数据Logo
    self.imgNoData.hidden = !(self.dataArray.count == 0);
    
    //结束刷新
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
    //得到团购个数的总数
    NSInteger totalCount = [result[@"total_count"] integerValue];
    
    //如果团购的总数 == dataArray.count 代表服务器没有数据了 就不可以上拉加载更多
    if (totalCount == self.dataArray.count) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    }
    
    
}

//请求失败
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"请求失败:%@",error);
    
    //提示
    [SVProgressHUD showErrorWithStatus:@"请求失败"];
    
    //结束刷新
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    
}


#pragma mark - 设置collectionView相关
- (void)setUpCollectionViewInfo{
    [self.collectionView registerClass:[MTDealCell class] forCellWithReuseIdentifier:reuseIdentifier];
}


#pragma mark - UICollectionView DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTDealCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    //赋值
    cell.dealModel = self.dataArray[indexPath.item];
    return cell;
}

//选中cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //实例化
    MTDetailViewController * detailVc = [MTDetailViewController new];
    
    detailVc.dealModel = self.dataArray[indexPath.item];
    
    //模态弹出
    [self presentViewController:detailVc animated:true completion:nil];
}

#pragma mark - 懒加载

//数组
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//没有数据
- (UIImageView *)imgNoData{
    if (!_imgNoData) {
        _imgNoData = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        //隐藏
        _imgNoData.hidden = true;
    }
    return _imgNoData;
}


//设置参数方法

- (void)setParams:(NSMutableDictionary *)params{
    
}

@end
