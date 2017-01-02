//
//  MTDetailCenterView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/30.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailCenterView.h"
#import "MTCenterLineLabel.h"
//自定义详情底部的View 为了更好设置约束,所以写在CenterView中
#import "MTDetailBottomView.h"
#import "MTDealModel.h"
#import "MTDealTools.h"

@interface MTDetailCenterView ()

//logo
@property(nonatomic,strong) UIImageView * imgLogo;
//标题
@property(nonatomic,strong) UILabel * labTitle;
//描述
@property(nonatomic,strong) UILabel * labDesc;
//现价
@property(nonatomic,strong) UILabel * labCurrent;
//原价
@property(nonatomic,strong) MTCenterLineLabel * labList;
//立即抢购
@property(nonatomic,strong) UIButton * btnBuy;
//收藏
@property(nonatomic,strong) UIButton * btnCollect;
//分享
@property(nonatomic,strong) UIButton * btnShare;
//自定义底部view
@property(nonatomic,strong) MTDetailBottomView * detailBottomView;

@end


@implementation MTDetailCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 赋值
-(void)setDealModel:(MTDealModel *)dealModel{
    _dealModel = dealModel;
    //赋值
    //图片
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:dealModel.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    //标题
    self.labTitle.text = dealModel.title;
    //描述
    self.labDesc.text = dealModel.desc;
    //现价
    self.labCurrent.text = dealModel.currentPriceStr;
    //原价
    self.labList.text = dealModel.listPriceStr;
    //底部视图赋值
    self.detailBottomView.dealModel = dealModel;
}

#pragma mark - 监听方法
- (void)btnCollectClick:(UIButton *)sender{
    //改变状态
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        //保存
        [[MTDealTools shared] insertDealModel:self.dealModel];
    }else{
        //删除
        [[MTDealTools shared] deleteDealModel:self.dealModel];
    }
    
}


#pragma mark - 设置视图
- (void)setUpUI{
    //背景颜色
    self.backgroundColor = [UIColor whiteColor];
    
    //添加控件
    [self addSubview:self.imgLogo];
    [self addSubview:self.labTitle];
    [self addSubview:self.labDesc];
    [self addSubview:self.labCurrent];
    [self addSubview:self.labList];
    [self addSubview:self.btnBuy];
    [self addSubview:self.btnCollect];
    [self addSubview:self.btnShare];
    [self addSubview:self.detailBottomView];
    
    [self.imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(185);
    }];
    
    [self.labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgLogo);
        make.left.offset(15);
        make.top.equalTo(self.imgLogo.mas_bottom).offset(10);
    }];
    
    [self.labDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.labTitle);
        make.top.equalTo(self.labTitle.mas_bottom).offset(15);
        
    }];
    
    [self.labCurrent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labDesc);
        make.top.equalTo(self.labDesc.mas_bottom).offset(20);
    }];
    
    [self.labList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labCurrent.mas_right).offset(20);
        make.bottom.equalTo(self.labCurrent);
    }];
    
    [self.btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labCurrent);
        make.top.equalTo(self.labCurrent.mas_bottom).offset(20);
        make.size.equalTo(CGSizeMake(120, 40));
    }];
    
    [self.btnCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnBuy.mas_right).offset(40);
        make.size.equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(self.btnBuy);
    }];
    
    [self.btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCollect.mas_right).offset(40);
        make.size.equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(self.btnBuy);
    }];
    
    [self.detailBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(self.btnBuy.mas_bottom).offset(30);
        make.height.equalTo(80);
    }];
    
    //设置默认值
    self.labTitle.text = @"biaoti";
    self.labDesc.text = @"miaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshumiaoshu";
    self.labCurrent.text = @"￥99";
    self.labList.text = @"￥199";
    
}

#pragma mark - 懒加载

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
        _labDesc.numberOfLines = 0;
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
- (MTCenterLineLabel *)labList{
    if (!_labList) {
        _labList = [MTCenterLineLabel new];
        _labList.font = [UIFont systemFontOfSize:14];
        _labList.textColor = [UIColor darkGrayColor];
    }
    return _labList;
}

//立即抢购
-(UIButton *)btnBuy{
    if (!_btnBuy) {
        _btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnBuy setBackgroundImage:[UIImage imageNamed:@"bg_deal_purchaseButton"] forState:UIControlStateNormal];
        [_btnBuy setBackgroundImage:[UIImage imageNamed:@"bg_deal_purchaseButton_highlighted"] forState:UIControlStateHighlighted];
        [_btnBuy setTitle:@"立即抢购" forState:UIControlStateNormal];
        _btnBuy.titleLabel.font = [UIFont systemFontOfSize:19];
        [_btnBuy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _btnBuy;
}

//收藏
- (UIButton *)btnCollect{
    if (!_btnCollect) {
        _btnCollect = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //点击方法
        [_btnCollect addTarget:self action:@selector(btnCollectClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnCollect setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
        [_btnCollect setImage:[UIImage imageNamed:@"icon_collect_highlighted"] forState:UIControlStateSelected];
    }
    return _btnCollect;
}

//分享
- (UIButton *)btnShare{
    if (!_btnShare) {
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnShare setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_btnShare setImage:[UIImage imageNamed:@"icon_share_highlighted"] forState:UIControlStateHighlighted];
    }
    return _btnShare;
}

- (MTDetailBottomView *)detailBottomView{
    if (!_detailBottomView) {
        _detailBottomView = [MTDetailBottomView new];
    }
    return _detailBottomView;
}

@end
