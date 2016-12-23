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
    [self.contentView addSubview:self.imgLogo];
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labDesc];
    [self.contentView addSubview:self.labCurrent];
    [self.contentView addSubview:self.labList];
    [self.contentView addSubview:self.labNumber];
    
    
    //添加约束
    [self.imgBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(5);
        make.right.offset(-5);
        make.height.offset(180);
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.equalTo(self.imgLogo.mas_bottom).offset(10);
        make.right.offset(-10);
    }];
    
    [self.labDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.labTitle);
        make.top.equalTo(self.labTitle.mas_bottom).offset(10);
    }];
    
    [self.labCurrent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labDesc);
        make.top.equalTo(self.labDesc.mas_bottom).offset(15);
    }];
    
    [self.labList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labCurrent.mas_right).offset(15);
        make.bottom.equalTo(self.labCurrent);
    }];
    
    [self.labNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.labCurrent);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    //设置默认值
    self.labTitle.text = @"标题";
    self.labDesc.text = @"bibibibibibibbibibibibibibibibbibibibibibibibibibbibibibibibibibibibbibibibibibibibibibbibibibibibibibibibbibibibibibibibibibbibibibibibibibibibibib";
    self.labCurrent.text = @"￥ 99.00";
    self.labList.text = @"￥ 199.00";
    self.labNumber.text = @"已售 19999";
    
    
}

#pragma mark - 懒加载
//背景图片
- (UIImageView *)imgBg{
    if (!_imgBg) {
        _imgBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dealcell"]];
    }
    return _imgBg;
}


//logo
- (UIImageView *)imgLogo{
    if (!_imgLogo) {
        _imgLogo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"placeholder_deal"]];
    }
    return _imgLogo;
}

//标题
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [UILabel new];
        _labTitle.font = [UIFont systemFontOfSize:17];
    }
    return _labTitle;
}

//描述
-(UILabel *)labDesc{
    if (!_labDesc) {
        _labDesc = [UILabel new];
        _labDesc.font = [UIFont systemFontOfSize:14];
        _labDesc.textColor = [UIColor darkGrayColor];
        _labDesc.numberOfLines = 2;
    }
    return _labDesc;
}

//现价
-(UILabel *)labCurrent{
    if (!_labCurrent) {
        _labCurrent = [UILabel new];
        _labCurrent.font = [UIFont systemFontOfSize:17];
        _labCurrent.textColor = [UIColor redColor];
        
    }
    return _labCurrent;
}

//原价
- (UILabel *)labList{
    if (!_labList) {
        _labList = [UILabel new];
        _labList.font = [UIFont systemFontOfSize:14];
        _labList.textColor = [UIColor darkGrayColor];
    }
    return _labList;
}

//已售
- (UILabel *)labNumber{
    if (!_labNumber) {
        _labNumber = [UILabel new];
        _labNumber.font = [UIFont systemFontOfSize:14];
        _labNumber.textColor = [UIColor darkGrayColor];
        //对齐方式
        _labNumber.textAlignment = NSTextAlignmentRight;
    }
    return _labNumber;
}

@end
