//
//  MTDealCell.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/23.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDealCell.h"

@interface MTDealCell ()

//背景图片
@property(nonatomic,strong) UIImageView * imgBg;
//logo
@property(nonatomic,strong) UIImageView * imgLogo;
//标题
@property(nonatomic,strong) UILabel * labTitle;
//描述
@property(nonatomic,strong) UILabel * labDesc;
//现价
@property(nonatomic,strong) UILabel * labCurrent;
//原价
@property(nonatomic,strong) UILabel * labList;
//已售
@property(nonatomic,strong) UILabel * labNumber;

@end

@implementation MTDealCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 设置视图
- (void)setUpUI{
    //添加控件
    [self.contentView addSubview:self.imgBg];
    
    
    //添加约束
    [self.imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    
    
}

#pragma mark - 懒加载
- (UIImageView *)imgBg{
    if (!_imgBg) {
        _imgBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
    }
    return _imgBg;
}

@end
