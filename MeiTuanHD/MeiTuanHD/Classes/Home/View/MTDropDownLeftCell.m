//
//  MTDropDownLeftCell.m
//  MeiTuanHD
//
//  Created by DXY on 16/12/22.
//  Copyright © 2016年 DXY. All rights reserved.
//

#import "MTDropDownLeftCell.h"

@implementation MTDropDownLeftCell

+ (instancetype)dropDownViewCellWithTableView:(UITableView *)tableView{
    static NSString * cellId = @"leftCellId";
    MTDropDownLeftCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MTDropDownLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        
        //设置背景View
        cell.backgroundView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        //设置选中背景View
        cell.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];        
    }
    return cell;
}

@end
