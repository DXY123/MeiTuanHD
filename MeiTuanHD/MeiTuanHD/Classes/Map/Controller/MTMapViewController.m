//
//  MTMapViewController.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/5.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTMapViewController.h"
#import <MapKit/MapKit.h>

@interface MTMapViewController ()

//实例化地图
@property(nonatomic,strong) MKMapView * mapView;
//位置管理器
@property(nonatomic,strong) CLLocationManager * locationManager;

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


#pragma mark - 懒加载
-(MKMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MKMapView alloc]init];
        //设置用户跟踪
        _mapView.userTrackingMode = MKUserTrackingModeFollow;
        
    }
    return _mapView;
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
    }
    return _locationManager;
}

@end
