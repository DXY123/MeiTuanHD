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


// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }

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

//重写set方法 - 新单
- (void)setPublish_date:(NSString *)publish_date{
    _publish_date = publish_date;
    self.isDealNew = [self dealPublishDate:publish_date];
}


#pragma mark - 处理是否是新单
- (BOOL)dealPublishDate:(NSString *)publish_date{
    
    //1 获取当前时间
    NSDate * currentDate = [NSDate date];
    //2 格式化
    NSDateFormatter * df = [NSDateFormatter new];
    //3 设置格式
    df.dateFormat = @"yyyy-MM-dd";
    //获取团购日期
    NSDate * dealDate = [df dateFromString:publish_date];
    
    //比较
    if ([currentDate compare:dealDate] == NSOrderedAscending) {
        //是新单
        return true;
    }
    return false;
    
    //可以合成一句
    //    return ([currentDate compare:dealDate] == NSOrderedAscending);
    
    
}

@end
