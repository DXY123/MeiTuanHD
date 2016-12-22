//
//  MTDropDownRightCell.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/22.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDropDownRightCell.h"

@implementation MTDropDownRightCell

+ (instancetype)dropDownViewCellWithTableView:(UITableView *)tableView{
    //右侧列表
    static NSString * cellId = @"rightCellId";
    MTDropDownRightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MTDropDownRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        //设置背景View
        cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        //设置选中背景View
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
        
    }
    return cell;
}

@end
