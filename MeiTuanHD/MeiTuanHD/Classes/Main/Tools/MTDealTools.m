//
//  MTDealTools.m
//  MeiTuanHD
//
//  Created by DXY on 17/1/1.
//  Copyright © 2017年 DXY. All rights reserved.
//

#import "MTDealTools.h"
#import <FMDB.h>
#import "MTDealModel.h"

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


//收藏
- (void)insertDealModel:(MTDealModel *)dealModel{
    //准备sql
    NSString * sql = @"INSERT INTO t_collect (deal_model,deal_id) VALUES (?,?);";
    
    //由于数据库中deal_model字段只能存储二进制数据,所以要将我们的自定义模型进行归档
    //二进制
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dealModel];
    
    //执行sql
    [self.queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql withArgumentsInArray:@[data,dealModel.deal_id]]) {
            NSLog(@"收藏成功");
        }else{
            NSLog(@"收藏失败");
        }
    }];
    
    
}

/*
 
 CREATE TABLE IF NOT EXISTS "t_collect" (
 "id" INTEGER NOT NULL,
 "deal_model" blob NOT NULL,
 "deal_id" text NOT NULL,
 PRIMARY KEY("id")
 )

 
 */


//取消收藏
- (void)deleteDealModel:(MTDealModel *)dealModel{
    //准备sql
    NSString * sql = @"DELETE FROM t_collect WHERE deal_id = ?;";
    //执行sql
    [self.queue inDatabase:^(FMDatabase *db) {
        if ([db executeUpdate:sql withArgumentsInArray:@[dealModel.deal_id]]) {
            NSLog(@"取消收藏成功");
        }else{
            NSLog(@"取消收藏失败");
        }
    }];
    
}


@end
