//
//  MTMapViewController.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/5.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTMapViewController.h"
#import <MapKit/MapKit.h>
#import "MTBusinessModel.h"


@interface MTMapViewController () <MKMapViewDelegate,DPRequestDelegate>

//实例化地图
@property(nonatomic,strong) MKMapView * mapView;
//位置管理器
@property(nonatomic,strong) CLLocationManager * locationManager;
//保存数据数组
@property(nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation MTMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //开启定位
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
}


#pragma mark - 监听方法
- (void)backClick{
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - 设置视图
- (void)setUpUI{
    [self setUpNav];
    
    [self.view addSubview:self.mapView];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

#pragma mark - 设置导航
- (void)setUpNav{
    UIBarButtonItem * backItem = [UIBarButtonItem BarButtonItemWithImgName:@"icon_back" Target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItems = @[backItem];
    
    self.title = @"地图";
    
}


#pragma mark - MKMapViewDelegate
//监听位置改变
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    //请求数据
    DPAPI * api = [DPAPI new];
    //设置参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    //经纬度
    params[@"latitude"] = @(mapView.region.center.latitude);
    params[@"longitude"] = @(mapView.region.center.longitude);
    
    //发送请求,url在大众点评开发文档:搜索商户中
    [api requestWithURL:@"v1/business/find_businesses" params:params delegate:self];
    
}


#pragma mark - DPRequestDelegate
//请求成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    NSLog(@"请求成功%@",result);
    [self.dataArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTBusinessModel class] json:result[@"businesses"]]];
    
    NSLog(@"数组%@",self.dataArray);
    
}

//请求失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"请求失败%@",error);
}


#pragma mark - 懒加载
-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc]init];
        //设置用户跟踪
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        
        //设置代理
        _mapView.delegate = self;
        
    }
    return _mapView;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
    }
    return _locationManager;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
