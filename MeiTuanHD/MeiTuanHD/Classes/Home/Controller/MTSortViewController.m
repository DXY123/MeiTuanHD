//
//  MTSortViewController.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/22.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTSortViewController.h"
//排序模型
#import "MTSortModel.h"


@interface MTSortViewController ()

//保存模型数据的数组
@property(nonatomic,strong) NSMutableArray * sortArray;


@end

@implementation MTSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

#pragma mark - 加载数据
- (void)loadData{
    //路径
    NSString * file = [[NSBundle mainBundle] pathForResource:@"sorts.plist" ofType:nil];
    //plist数组
    NSArray * plistArray = [NSArray arrayWithContentsOfFile:file];
    //字典转模型
    [self.sortArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTSortModel class] json:plistArray]];
    
    [self setUpUI];
    
}


#pragma mark - 设置视图
- (void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    //循环创建7个按钮
    NSInteger count = self.sortArray.count;
    
    //frame
    CGFloat width = 100;
    CGFloat height = 30;
    CGFloat margin = 15;
    
    //创建按钮
    for (int i = 0; i < count; i++) {
        //初始化
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //取出sort模型数据
        MTSortModel * sortModel = self.sortArray[i];
        
        //设置标题
        [button setTitle:sortModel.label forState:UIControlStateNormal];
        
        //设置文字颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        //设置背景图片
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        
        //设置frame
        button.width = width;
        button.height = height;
        button.x = margin;
        button.y = margin + (button.height + margin) * i;
        
        //绑定tag --> 区分点击了哪一个按钮
        button.tag = i;
        
        //添加方法
        [button addTarget:self action:@selector(sortButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
    }
    
    //设置popover大小
    CGFloat contentWidth = 2 * margin + width;
    CGFloat contentHeight = (margin + height) * count + margin;
    self.preferredContentSize = CGSizeMake(contentWidth, contentHeight);
    
}

#pragma mark - 监听方法
- (void)sortButtonClick:(UIButton *)sender{
    
}

#pragma mark - 懒加载
- (NSMutableArray *)sortArray{
    if (!_sortArray) {
        _sortArray = [NSMutableArray array];
    }
    return _sortArray;
}


@end
