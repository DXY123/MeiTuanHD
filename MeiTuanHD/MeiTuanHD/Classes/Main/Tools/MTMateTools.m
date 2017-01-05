//
//  MTMateTools.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/6.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTMateTools.h"
#import "MTCategoryModel.h"
#import "MTBusinessModel.h"

@interface MTMateTools ()

//保存plist文件的数组
@property(nonatomic,strong) NSMutableArray * categoryArray;


@end


@implementation MTMateTools

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static MTMateTools * instance;
    dispatch_once(&onceToken, ^{
        instance = [MTMateTools new];
    });
    
    return instance;
}


//提供一个方法返回对应的图片
- (NSString *)getMapImageName:(MTBusinessModel *)businessModel{
    //获取服务器返回的分类名称
    NSString * categoryName = [businessModel.categories firstObject];
    
    //遍历当前的分类数组
    for (MTCategoryModel * categoryModel in self.categoryArray) {
        if ([categoryModel.name isEqualToString:categoryName]) {
            return categoryModel.map_icon;
        }else if ([categoryModel.subcategories containsObject:categoryName]){
            //如果当前子数组包含传入的名称
            return categoryModel.map_icon;
            
        }
    }
    //如果没有找到对应图片
    return nil;
}


#pragma mark - 懒加载
- (NSMutableArray *)categoryArray{
    if (!_categoryArray) {
        _categoryArray = [NSMutableArray array];
        //获取路径
        NSString * file = [[NSBundle mainBundle] pathForResource:@"categories.plist" ofType:nil];
        //plist数组
        NSArray * plistArray = [NSArray arrayWithContentsOfFile:file];
        //转模型
        [_categoryArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[MTCategoryModel class] json:plistArray]];
    }
    return _categoryArray;
}

@end
