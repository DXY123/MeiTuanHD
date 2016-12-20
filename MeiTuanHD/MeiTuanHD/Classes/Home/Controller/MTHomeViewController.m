//
//  MTHomeViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/17.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTHomeViewController.h"
//自定义导航View
#import "MTHomeNavView.h"
//分类popover
#import "MTCategoryViewController.h"

@interface MTHomeViewController ()

//分类
@property(nonatomic,strong) MTHomeNavView * categoryNavView;
//地区
@property(nonatomic,strong) MTHomeNavView * districtNavView;
//排序
@property(nonatomic,strong) MTHomeNavView * sortNavView;

@end

@implementation MTHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        self = [self initWithCollectionViewLayout:layout];
    }
    return self;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self setUpCollectionViewInfo];
}



#pragma mark - 设置视图
- (void)setUpUI{
    self.collectionView.backgroundColor = HMColor(222, 222, 222);
    [self setUpRightNav];
    [self setUpLeftNav];
}

#pragma mark - 设置左侧导航
- (void)setUpLeftNav{
    //美团Logo
    UIBarButtonItem * logoItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_meituan_logo" Target:self action:nil];
    //取消用户交互
    logoItem.customView.userInteractionEnabled = false;
    
    //分类
    UIBarButtonItem * categoryItem = [[UIBarButtonItem alloc]initWithCustomView:self.categoryNavView];
    
    //地区
    UIBarButtonItem * districtItem = [[UIBarButtonItem alloc]initWithCustomView:self.districtNavView];
    
    //排序
    UIBarButtonItem * sortItem = [[UIBarButtonItem alloc]initWithCustomView:self.sortNavView];
    
    
    self.navigationItem.leftBarButtonItems = @[logoItem,categoryItem,districtItem,sortItem];
}


#pragma mark - 设置右侧导航
- (void)setUpRightNav{
    //地图
    UIBarButtonItem * mapItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_map" Target:self action:@selector(mapClick)];
    //设置宽度
    mapItem.customView.width = 60;
    //搜索
    UIBarButtonItem * searchItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_search" Target:self action:@selector(searchClick)];
    //设置宽度
    searchItem.customView.width = 60;
    
    
    self.navigationItem.rightBarButtonItems = @[mapItem,searchItem];
}

#pragma mark - 监听方法
- (void)mapClick{
    NSLog(@"地图点击");
}

- (void)searchClick{
    NSLog(@"搜索点击");
}

#pragma mark - 设置collectionView相关
- (void)setUpCollectionViewInfo{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}


#pragma mark - 监听事件
//分类
- (void)categoryClick{
    NSLog(@"分类");
    //实例化
    MTCategoryViewController * categoryVc = [MTCategoryViewController new];
    //设置呈现样式
    categoryVc.modalPresentationStyle = UIModalPresentationPopover;
    //设置barButtonItem
    categoryVc.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[1];
    //模态弹出
    [self presentViewController:categoryVc animated:YES completion:nil];
}

//地区
- (void)districtClick{
    NSLog(@"地区");
}


//排序
- (void)sortClick{
    NSLog(@"排序");
}

#pragma mark - 懒加载
//分类
- (MTHomeNavView *)categoryNavView{
    if (!_categoryNavView) {
        _categoryNavView = [MTHomeNavView new];
        
        WeakSelf(MTHomeViewController);
        
        //02 实例化
        [_categoryNavView setHomeNavViewBlock:^{
            //04 接收回调
            [weakSelf categoryClick];
        }];
        
        
    }
    return _categoryNavView;
}

//地区
-(MTHomeNavView *)districtNavView{
    if (!_districtNavView) {
        _districtNavView = [MTHomeNavView new];
        WeakSelf(MTHomeViewController);
        
        [_districtNavView setHomeNavViewBlock:^{
            [weakSelf districtClick];
        }];
        
    }
    return _districtNavView;
}


//排序
-(MTHomeNavView *)sortNavView{
    if (!_sortNavView) {
        _sortNavView = [MTHomeNavView new];
        WeakSelf(MTHomeViewController);
        
        [_sortNavView setHomeNavViewBlock:^{
            [weakSelf sortClick];
        }];
        
    }
    return _sortNavView;
}


@end
