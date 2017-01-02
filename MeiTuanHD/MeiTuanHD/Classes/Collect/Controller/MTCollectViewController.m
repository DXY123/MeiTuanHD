//
//  MTCollectViewController.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/2.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTCollectViewController.h"
//自定义的cell
#import "MTDealCell.h"
//首页数据模型
#import "MTDealModel.h"
//详情控制器
#import "MTDetailViewController.h"
//数据库工具类
#import "MTDealTools.h"


@interface MTCollectViewController ()

//保存首页数据数组
@property(nonatomic,strong) NSMutableArray * dataArray;
//没有团购数据
@property(nonatomic,strong) UIImageView * imgNoData;
//记录当前页码
@property(nonatomic,assign)NSInteger currentPage;
//返回
@property(nonatomic,strong) UIBarButtonItem * backItem;
//全选
@property(nonatomic,strong) UIBarButtonItem * selectAllItem;
//全不选
@property(nonatomic,strong) UIBarButtonItem * unselectAllItem;
//删除
@property(nonatomic,strong) UIBarButtonItem * deleteItem;

@end

@implementation MTCollectViewController

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
    
    self.collectionView.backgroundColor = HMColor(222, 222, 222);
    
    [self.view addSubview:self.imgNoData];
    
    //添加约束
    [self.imgNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    //设置默认页码
    self.currentPage = 1;
    
    [self setUpNav];
    
    [self setUpCollectionViewInfo];
    
    [self addRefresh];
    
    [self loadDealData];
}


#pragma mark - 监听方法
//返回
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

//全选
- (void)selectAllClick{
    NSLog(@"全选");
}

//全不选
- (void)unselectAllClick{
    NSLog(@"全不选");
}

//删除
- (void)deleteClick{
    NSLog(@"删除");
}

//右侧按钮点击
- (void)rightClick:(UIBarButtonItem *)item{
    if ([item.title isEqualToString:@"编辑"]) {
        item.title = @"完成";
        //左侧显示 返回 全选 全不选 删除
        self.navigationItem.leftBarButtonItems = @[self.backItem,self.selectAllItem,self.unselectAllItem,self.deleteItem];
    }else{
        item.title = @"编辑";
        //左侧只显示 返回
        self.navigationItem.leftBarButtonItems = @[self.backItem];
    }
}


#pragma mark - 设置导航
- (void)setUpNav{
    //设置左侧
    self.navigationItem.leftBarButtonItems = @[self.backItem];
    
    //设置右侧
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick:)];
    
    //标题
    self.title = @"收藏";
    
}


#pragma mark - 设置下拉刷新和上拉加载更多
- (void)addRefresh{
    //下拉刷新
//    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        //page = 1
//        self.currentPage = 1;
//        [self loadDealData];
//    }];
    
    
    //上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // page++
        self.currentPage++;
        [self loadDealData];
    }];
    
    
}


#pragma mark - 加载数据
- (void)loadDealData{
    [[MTDealTools shared] getCollectListWithPage:self.currentPage block:^(NSArray *modelArr) {
        [self.dataArray addObjectsFromArray:modelArr];
        
        [self.collectionView reloadData];
        //结束mj_footer动画
        [self.collectionView.mj_footer endRefreshing];
        
    }];
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

//返回
- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_back" Target:self action:@selector(backClick)];
    }
    return _backItem;
}

//全选
- (UIBarButtonItem *)selectAllItem{
    if (!_selectAllItem) {
        _selectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllClick)];;
    }
    return _selectAllItem;
}


//全不选
- (UIBarButtonItem *)unselectAllItem{
    if (!_unselectAllItem) {
        _unselectAllItem = [[UIBarButtonItem alloc] initWithTitle:@"全不选" style:UIBarButtonItemStylePlain target:self action:@selector(unselectAllClick)];;
    }
    return _unselectAllItem;
}

//删除
-(UIBarButtonItem *)deleteItem{
    if (!_deleteItem) {
        _deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteClick)];
        _deleteItem.enabled = false;
    }
    return _deleteItem;
}


@end
