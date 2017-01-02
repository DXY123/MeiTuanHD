//
//  MTDealTools.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/1.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTDealTools.h"
#import <FMDB.h>


@interface MTDealTools ()

@property(nonatomic,strong) FMDatabaseQueue * queue;

@end


@implementation MTDealTools


+ (instancetype)shared{
    static dispatch_once_t onceToken;
    static MTDealTools * instance;
    dispatch_once(&onceToken, ^{
        instance = [MTDealTools new];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTable];
    }
    return self;
}


#pragma mark - 创建表
- (void)createTable{
    
    //路径
    NSString * file = [[NSBundle mainBundle] pathForResource:@"db.sql" ofType:nil];
    
    //准备sql
    NSString * sql = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",sql);
    //执行sql
    [self.queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql withArgumentsInArray:nil]) {
            NSLog(@"创建表成功")
        }else{
            NSLog(@"创建表失败");
        }
    }];
}

- (FMDatabaseQueue *)queue{
    if (!_queue) {
        
        //路径
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject] stringByAppendingPathComponent:@"deal.db"];
        
        NSLog(@"路径:%@",path);
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return _queue;
}

@end
