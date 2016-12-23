//
//  MTHomeNavView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/20.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTHomeNavView.h"

@interface MTHomeNavView ()

//竖线
@property(nonatomic,strong) UILabel * labLine;
//主标题
@property(nonatomic,strong) UILabel * labTitle;
//子标题
@property(nonatomic,strong) UILabel * labSubTitle;
//覆盖按钮
@property(nonatomic,strong) UIButton * btnCover;

@end

@implementation MTHomeNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - 供外界赋值的方法
//设置labTitle的text
- (void)setLabTitleText:(NSString *)text{
    self.labTitle.text = text;
}
//设置labSubTitle的text
- (void)setLabSubTitleText:(NSString *)text{
    //代表有子标题 防止上次没有子标题
    if (text .length > 0) {
        self.labTitle.height = 20;
    }else{
        self.labTitle.height = 40;
    }
    self.labSubTitle.text = text;
}
//设置覆盖按钮的image和高亮的image
- (void)setIcon:(NSString *)icon hlIcon:(NSString *)hlIcon{
    [self.btnCover setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [self.btnCover setImage:[UIImage imageNamed:hlIcon] forState:UIControlStateHighlighted];
}


#pragma mark - 设置视图
- (void)setUpUI{
    self.size = CGSizeMake(160, 40);
    self.backgroundColor = HMColor(222, 222, 222);
    
    
    //添加控件
    [self addSubview:self.labLine];
    [self addSubview:self.labTitle];
    [self addSubview:self.labSubTitle];
    [self addSubview:self.btnCover];
}

#pragma mark - 监听方法 

- (void)btnCoverClick{
    //03 执行
    if (self.homeNavViewBlock) {
        self.homeNavViewBlock();
    }
}


#pragma mark - 懒加载

//竖线
- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 1, self.height - 10)];
        _labLine.backgroundColor = [UIColor blackColor];
        //透明度
        _labLine.alpha = 0.3;
    }
    return _labLine;
}


//主标题
- (UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
        _labTitle.font = [UIFont systemFontOfSize:14];
        _labTitle.text = @"主标题";
        //设置对齐方式
        _labTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labTitle;
}

//子标题
- (UILabel *)labSubTitle{
    if (!_labSubTitle) {
        _labSubTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.width, 20)];
        _labSubTitle.font = [UIFont systemFontOfSize:17];
        _labSubTitle.text = @"子标题";
        //设置对齐方式
        _labSubTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _labSubTitle;
}

//覆盖按钮
- (UIButton *)btnCover {
    if (!_btnCover) {
        _btnCover = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCover.frame = CGRectMake(0, 0, self.width, self.height);
        [_btnCover setImage:[UIImage imageNamed:@"icon_district"] forState:UIControlStateNormal];
        [_btnCover setImage:[UIImage imageNamed:@"icon_district_highlighted"] forState:UIControlStateHighlighted];
        
        //设置对齐方式
        [_btnCover setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        //image调整一下edge,往右移动15
        [_btnCover setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
        
        //添加事件
        [_btnCover addTarget:self action:@selector(btnCoverClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnCover;
}

@end
