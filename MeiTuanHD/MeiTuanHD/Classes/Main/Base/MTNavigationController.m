//
//  MTNavigationController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTNavigationController.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController

//在编译的时候就会走该方法
/*
+ (void)load{
    NSLog(@"load");
}
*/

//该方法只会走一次,无论创建多少次对象
+ (void)initialize{
//    NSLog(@"initialize");
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    
    //除了让图片做拉伸处理外,还可手写代码,已经抽取了分类
    UIImage * image = [UIImage imageResizableImageWithImageName:@"bg_navigationBar_normal"];
    
    //设置背景图片
    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
