//
//  MTDealCell.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/23.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDealCell.h"
#import "MTDealModel.h"
//删除线
#import "MTCenterLineLabel.h"

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
@property(nonatomic,strong) MTCenterLineLabel * labList;
//已售
@property(nonatomic,strong) UILabel * labNumber;
//新单
@property(nonatomic,strong) UIImageView * imgDealNew;
//遮盖按钮
@property(nonatomic,strong) UIButton * btnCover;
//对勾图片
@property(nonatomic,strong) UIImageView * imgChoosed;

@end

@implementation MTDealCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - dealModel赋值
- (void)setDealModel:(MTDealModel *)dealModel{
    _dealModel = dealModel;
    
    //logo设置图片
    [self.imgLogo sd_setImageWithURL:[NSURL URLWithString:dealModel.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    //设置title
    self.labTitle.text = dealModel.title;
    
    //设置描述
    self.labDesc.text = dealModel.desc;
    
    //现价
    self.labCurrent.text = dealModel.currentPriceStr;
    
    //原价
    self.labList.text = dealModel.listPriceStr;
    
    //已售
    self.labNumber.text = [NSString stringWithFormat:@"已售 %zd",dealModel.purchase_count];
    
    
    self.imgDealNew.hidden = !dealModel.isDealNew;
    
    //判断是否是收藏界面
    self.btnCover.hidden = !dealModel.editting;
    
    self.imgChoosed.hidden = !dealModel.isChoose;
    
}

//不能在这处理价格,否则cell重用机制会在每次加载cell的时候都重新调用这个方法计算

//处理是否是新单
//在dealModel中处理了


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
    [self.contentView addSubview:self.imgDealNew];
    [self.contentView addSubview:self.btnCover];
    [self.contentView addSubview:self.imgChoosed];
    
    
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
    
    [self.imgDealNew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
    }];
    
    [self.btnCover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.imgChoosed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
    }];
    
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
- (MTCenterLineLabel *)labList{
    if (!_labList) {
        _labList = [MTCenterLineLabel new];
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

//新单
- (UIImageView *)imgDealNew{
    if (!_imgDealNew) {
        _imgDealNew = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_deal_new"]];
    }
    return _imgDealNew;
}

//遮盖按钮
- (UIButton *)btnCover{
    if (!_btnCover) {
        _btnCover = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCover.backgroundColor = [UIColor whiteColor];
        _btnCover.alpha = 0.5;
    }
    return _btnCover;
}

//对勾图片
- (UIImageView *)imgChoosed{
    if (!_imgChoosed) {
        _imgChoosed = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_choosed"]];
    }
    return _imgChoosed;
}

@end
