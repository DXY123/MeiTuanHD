//
//  MTDealModel.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/25.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDealModel.h"

@implementation MTDealModel

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"desc" : @"description"};
}


//重写set方法 - 原价
- (void)setCurrent_price:(CGFloat)current_price{
    _current_price = current_price;
    self.currentPriceStr = [self dealPriceStr:current_price];
}

//重写set方法 - 原价
- (void)setList_price:(CGFloat)list_price{
    _list_price = list_price;
    self.listPriceStr = [self dealPriceStr:list_price];
}

//价格数字处理
- (NSString *)dealPriceStr:(CGFloat)price{
    NSString * priceStr = [NSString stringWithFormat:@"￥ %.2f",price];
    
    //判断是否包含.00
    if ([priceStr containsString:@".00"]) {
        priceStr = [priceStr stringByReplacingOccurrencesOfString:@".00" withString:@""];
    }
    return priceStr;
    
}

@end
