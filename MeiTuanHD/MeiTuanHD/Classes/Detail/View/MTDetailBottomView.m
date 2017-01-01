//
//  MTDetailBottomView.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/31.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDetailBottomView.h"
#import "MTDealModel.h"
#import "MTRestrictionsModel.h"


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

//赋值
-(void)setDealModel:(MTDealModel *)dealModel{
    _dealModel = dealModel;
    //赋值
    // A 随时退款
    self.btnA.selected = dealModel.restrictions.is_refundable;
    // C 过期退款
    self.btnC.selected = dealModel.restrictions.is_reservation_required;
    // D 已售数量
    [self.btnD setTitle:[NSString stringWithFormat:@"已售 %zd",dealModel.purchase_count] forState:UIControlStateNormal];
    // B 过期时间
    [self.btnB setTitle:[self dealPurchaseDeadline:dealModel.purchase_deadline] forState:UIControlStateNormal];
    
}

//计算截止购买时间
- (NSString *)dealPurchaseDeadline:(NSString *)deadline{
    //获取当前时间
    NSDate * currentDate = [NSDate date];
    //时间格式化
    NSDateFormatter * df = [NSDateFormatter new];
    //设置格式
    df.dateFormat = @"yyyy-MM-dd";
    //需要把团购过期字符串转日期
    NSDate * dealDate = [df dateFromString:deadline];
    //时间比较组件
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    //时间比较
    NSDateComponents * cmp = [[NSCalendar currentCalendar] components:unit fromDate:currentDate toDate:dealDate options:0];
    
    NSLog(@"%ld天%ld小时%ld分钟",cmp.day,cmp.hour,cmp.minute);
    
    //如果天数>365 -> 一年之内都不会过期
    if (cmp.day > 365) {
        return @"一年之内都不会过期";
    }else if(cmp.day + cmp.hour + cmp.minute <= 0){
        //如果day天 小时 分钟均为0 , 就显示已经过期
        return @"已过期";
    }else{
        return [NSString stringWithFormat:@"%ld天%ld小时%ld分钟",cmp.day,cmp.hour,cmp.minute];
    }
    
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
    btn.userInteractionEnabled = false;
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
