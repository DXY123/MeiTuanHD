//
//  MTAnnotationModel.h
//  MeiTuanHD
//
//  Created by DXY on 17/1/5.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MTAnnotationModel : NSObject<MKAnnotation>

//位置
@property (nonatomic) CLLocationCoordinate2D coordinate;
//标题
@property (nonatomic, copy, nullable) NSString *title;
//子标题
@property (nonatomic, copy, nullable) NSString *subtitle;

@end
