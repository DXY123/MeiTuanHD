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
//地区popover
#import "MTDistrictViewController.h"
//城市模型
#import "MTCityModel.h"
//分类模型
#import "MTCategoryModel.h"
//地区模型
#import "MTDistrictModel.h"
//排序popover控制器
#import "MTSortViewController.h"
//排序模型
#import "MTSortModel.h"
//自定义的cell
#import "MTDealCell.h"
//首页数据模型
#import "MTDealModel.h"

@interface MTHomeViewController ()<DPRequestDelegate>

//分类
@property(nonatomic,strong) MTHomeNavView * categoryNavView;
//地区
@property(nonatomic,strong) MTHomeNavView * districtNavView;
//排序
@property(nonatomic,strong) MTHomeNavView * sortNavView;
//选择的城市名
@property(nonatomic,copy) NSString * selectCityName;
//保存首页数据数组
@property(nonatomic,strong) NSMutableArray * dataArray;
//没有团购数据
@property(nonatomic,strong) UIImageView * imgNoData;

@end

@implementation MTHomeViewController

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
    //手动调用屏幕旋转方法
    [self viewWillTransitionToSize:[UIScreen mainScreen].bounds.size withTransitionCoordinator:self.transitionCoordinator];
    //设置默认城市
    self.selectCityName = @"北京";
    [self setUpUI];
    [self setUpCollectionViewInfo];
    
    [self setUpNotificationCenter];
    
    [self loadDealData];
    
}

#pragma mark - 加载数据
- (void)loadDealData{
    //实例化
    DPAPI * api = [DPAPI new];
    
    //请求参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    //城市参数(必传)
    params[@"city"] = self.selectCityName;
    
    NSLog(@"请求参数:%@",params);
    
    //发送请求
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}


#pragma mark - DPRequestDelegate

//请求成功
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
//    NSLog(@"请求成功:%@",result);
    
    //字典转模型保存数据
    [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTDealModel class] json:result[@"deals"]]];
    
    //刷新
    [self.collectionView reloadData];
    
    self.imgNoData.hidden = !(self.dataArray.count == 0);
    
//    NSLog(@"%@",self.dataArray);
    
}

//请求失败
-(void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"请求失败:%@",error);
    
}


#pragma mark - 注册通知中心
- (void)setUpNotificationCenter{
    //选择城市的通知注册
    [MTNotificationCenter addObserver:self selector:@selector(cityDidChangeNotification:) name:HMCityDidChangeNotifacation object:nil];
    //分类通知注册
    [MTNotificationCenter addObserver:self selector:@selector(categoryDidChangeNotification:) name:HMCategoryDidChangeNotifacation object:nil];
    //地区通知注册
    [MTNotificationCenter addObserver:self selector:@selector(districtDidChangeNotification:) name:HMDistrictDidChangeNotifacation object:nil];
    //排序通知注册
    [MTNotificationCenter addObserver:self selector:@selector(sortDidChangeNotification:) name:HMSortDidChangeNotifacation object:nil];
}



#pragma mark - 监听选择城市通知方法
- (void)cityDidChangeNotification:(NSNotification *)noti{
    self.selectCityName = noti.userInfo[HMSelectCityName];
    NSLog(@"选择的城市:%@",self.selectCityName);
    
    [self.districtNavView setLabTitleText:[NSString stringWithFormat:@"%@-全部",self.selectCityName]];
    [self.districtNavView setLabSubTitleText:@""];
    
    //关闭控制器
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 监听选择分类通知方法
- (void)categoryDidChangeNotification:(NSNotification *)noti{
    //分类模型
    MTCategoryModel * categoryModel = noti.userInfo[HMSelectCategoryModel];
    //分类分类的子标题
    NSString * selectCategorySubtitle = noti.userInfo[HMSelectCategorySubtitle];
    
    NSLog(@"模型name:%@",categoryModel.name);
    NSLog(@"子标题:%@",selectCategorySubtitle);
    
    //设置自定义视图显示的内容
    //title
    [self.categoryNavView setLabTitleText:categoryModel.name];
    //设置子标题
    [self.categoryNavView setLabSubTitleText:selectCategorySubtitle];
    //设置icon
    [self.categoryNavView setIcon:categoryModel.icon hlIcon:categoryModel.highlighted_icon];
    
    
    //关掉控制器
    [self dismissViewControllerAnimated:true completion:nil];
    
}

#pragma mark - 监听选择地区通知方法
- (void)districtDidChangeNotification:(NSNotification *)noti{
    //地区模型
    MTDistrictModel * districtModel = noti.userInfo[HMSelectDistrictModel];
    //子标题
    NSString * selectDistrictSubtitle = noti.userInfo[HMSelectDistrictSubtitle];
    
    NSLog(@"模型name:%@",districtModel.name);
    NSLog(@"子标题:%@",selectDistrictSubtitle);
    
    //设置地区自定义view属性
    //设置title
    [self.districtNavView setLabTitleText:[NSString stringWithFormat:@"%@-%@",self.selectCityName,districtModel.name]];
    //subtitle
    [self.districtNavView setLabSubTitleText:selectDistrictSubtitle];
    
    //关掉控制器
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 监听选择排序方式通知方法
- (void)sortDidChangeNotification:(NSNotification *)noti{
    //接收模型
    MTSortModel * sortModel = noti.userInfo[HMSelectSortModel];
    
    NSLog(@"名称:%@",sortModel.label);
    NSLog(@"数字:%@",sortModel.value);
    
    //设置排序自定义view属性
    //title
//    [self.sortNavView setLabTitleText:@"排序"]; //懒加载中设置
    [self.sortNavView setLabSubTitleText:sortModel.label];
    
    //关掉控制器
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark - 设置视图
- (void)setUpUI{
    self.collectionView.backgroundColor = HMColor(222, 222, 222);
    [self setUpRightNav];
    [self setUpLeftNav];
    
    [self.view addSubview:self.imgNoData];
    
    //添加约束
    [self.imgNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
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
    [self.collectionView registerClass:[MTDealCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
    MTDistrictViewController * districtVc = [MTDistrictViewController new];
    //设置呈现样式
    districtVc.modalPresentationStyle = UIModalPresentationPopover;
    //设置barButtonItem
    districtVc.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[2];
    
    
    //加载plist文件 cities.plist
    //第一次不加载,selectCityName有值则不为第一次
    if (self.selectCityName) {
        //创建临时可变数组
        NSMutableArray * tempArray = [NSMutableArray array];
        //路径
        NSString * file = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
        // 加载plist文件
        NSArray * plistArray = [NSArray arrayWithContentsOfFile:file];
        
        //转模型保存数据
        [tempArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTCityModel class] json:plistArray]];
        
        //遍历当前数组 得到子数组数据
        for (MTCityModel * model in tempArray) {
            //如果model中的name == selectCityName 我们就需要赋值
            if ([model.name isEqualToString:self.selectCityName]) {
                //赋值
                districtVc.districtArray = model.districts;
            }
        }
        
        
    }
    
    //模态弹出
    [self presentViewController:districtVc animated:YES completion:nil];
}


//排序
- (void)sortClick{
    NSLog(@"排序");
    //实例化
    MTSortViewController * sortVc = [MTSortViewController new];
    //设置呈现样式
    sortVc.modalPresentationStyle = UIModalPresentationPopover;
    //设置barButtonItem
    sortVc.popoverPresentationController.barButtonItem = self.navigationItem.leftBarButtonItems[3];
    //模态弹出
    [self presentViewController:sortVc animated:YES completion:nil];
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


#pragma mark - 懒加载
//分类
- (MTHomeNavView *)categoryNavView{
    if (!_categoryNavView) {
        WeakSelf(MTHomeViewController);
        _categoryNavView = [MTHomeNavView new];
        //设置属性
        [_categoryNavView setLabTitleText:@"全部分类"];
        [_categoryNavView setLabSubTitleText:@""];
        [_categoryNavView setIcon:@"icon_category_-1" hlIcon:@"icon_category_highlighted_-1"];
        
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
        WeakSelf(MTHomeViewController);
        _districtNavView = [MTHomeNavView new];
        
        //设置属性
        [_districtNavView setLabTitleText:[NSString stringWithFormat:@"%@-全部",self.selectCityName]];
        [_districtNavView setLabSubTitleText:@""];
        
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
        
        //设置属性
        [_sortNavView setLabTitleText:@"排序"];
        [_sortNavView setLabSubTitleText:@"默认排序"];
        [_sortNavView setIcon:@"icon_sort" hlIcon:@"icon_sort_highlighted"];
        
        
        [_sortNavView setHomeNavViewBlock:^{
            [weakSelf sortClick];
        }];
        
    }
    return _sortNavView;
}

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


- (void)dealloc{
    [MTNotificationCenter removeObserver:self];
}


@end
