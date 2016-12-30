//
//  MTDetailBottomView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/31.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailBottomView.h"

@interface MTDetailBottomView ()

//支持随时退款
@property(nonatomic,strong) UIButton * btnA;
//团购过期时间
@property(nonatomic,strong) UIButton * btnB;
//支持过期退款
@property(nonatomic,strong) UIButton * btnC;
//已售数量
@property(nonatomic,strong) UIButton * btnD;

@end

@implementation MTDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}


//设置视图
- (void)setUpUI{
    
    self.btnA = [self addChildButtons:@"支持随时退款"];
    self.btnB = [self addChildButtons:@"7天14小时31分钟"];
    self.btnC = [self addChildButtons:@"支持过期退款"];
    self.btnD = [self addChildButtons:@"已售 9999"];
    
    //约束
    [self.btnA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.equalTo(self).dividedBy(2);
        make.width.equalTo(self).dividedBy(2);
    }];
    
    [self.btnB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.size.equalTo(self.btnA);
    }];
    
    [self.btnC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.size.equalTo(self.btnA);
    }];
    
    [self.btnD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.size.equalTo(self.btnA);
    }];
    
}

//创建和添加按钮的公共方法
- (UIButton *)addChildButtons:(NSString *)title{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_order_unrefundable"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_order_refundable"] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    //让文字稍微往后靠一些
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    
    //添加
    [self addSubview:btn];
    
    return btn;
    
}

@end
