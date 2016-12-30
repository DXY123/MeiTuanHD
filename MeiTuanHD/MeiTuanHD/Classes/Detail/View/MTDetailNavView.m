//
//  MTDetailNavView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/30.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailNavView.h"


@interface MTDetailNavView ()

//背景图片
@property(nonatomic,strong) UIImageView * imgBg;
//标题
@property(nonatomic,strong) UILabel * labTitle;
//返回
@property(nonatomic,strong) UIButton * btnBack;

@end

@implementation MTDetailNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 监听事件
- (void)btnBackClick{
    //执行block
    if (self.detailNavViewBlock) {
        self.detailNavViewBlock();
    }
}


//设置视图
- (void)setUpUI{
    //添加控件
    [self addSubview:self.imgBg];
    [self addSubview:self.labTitle];
    [self addSubview:self.btnBack];
    
    [self.imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(20);
        make.size.equalTo(CGSizeMake(44, 44));
    }];
    
}

#pragma mark - 懒加载
//背景
-(UIImageView *)imgBg{
    if (!_imgBg) {
        _imgBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_navigationBar_normal"]];
    }
    return _imgBg;
}

//标题
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.font = [UIFont systemFontOfSize:19];
        _labTitle.textAlignment = NSTextAlignmentCenter;
        _labTitle.text = @"团购详情";
    }
    return _labTitle;
}

//返回按钮
- (UIButton *)btnBack{
    if (!_btnBack) {
        _btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_btnBack addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnBack setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_btnBack setImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    }
    return _btnBack;
}

@end
