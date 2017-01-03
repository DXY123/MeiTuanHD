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
            [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
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


//判断是否收藏了某个团购
- (void)isCollectDealModel:(MTDealModel *)dealModel block:(void (^)(BOOL isCollect))block{
    //准备sql
    NSString * sql = @"SELECT * FROM t_collect WHERE deal_id = ?;";
    
    //执行sql
    [self.queue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:sql withArgumentsInArray:@[dealModel.deal_id]];
        
        //执行next
        [set next];
        
        //得到列数,如果查询到了结果,就是3列(id,deal_id,deal_model三个字段),如果没查询到就是0列
        NSInteger col = [set columnCount];
        
        //执行
        block(col > 0);
        
        
    }];
    
}


//获取美团团购列表数据
- (void)getCollectListWithPage:(NSInteger)page block:(void (^)(NSArray * modelArr))block{
    //默认返回的条数
    NSInteger length = 20;
    //位置
    NSInteger location = (page - 1) * length;
    //准备sql
    // LIMIT ?,? = location,length
    NSString * sql = @"SELECT * FROM t_collect ORDER BY id DESC LIMIT ?,?;";
    //执行sql
    [self.queue inDatabase:^(FMDatabase *db) {
        //创建一个临时数组
        NSMutableArray * tempArr = [NSMutableArray array];
        
        FMResultSet * set = [db executeQuery:sql withArgumentsInArray:@[@(location),@(length)]];
        
        while ([set next]) {
            //取数据
            //二进制数据的模型
            NSData * data = [set dataForColumn:@"deal_model"];
            //二进制数据解档
            MTDealModel * dealModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            [tempArr addObject:dealModel];
            
        }
        //执行block
        block([tempArr copy]);
        
    }];
    
}

//获取美团团购总条数
- (void)getCollectListTotalCountBlock:(void (^)(NSInteger totalCount))block{
    //准备sql
    NSString * sql = @"SELECT COUNT(*) FROM t_collect;";
    //执行sql
    [self.queue inDatabase:^(FMDatabase *db) {
        //查询数据库的结果集intForQuery 获取结果集合个数
        NSInteger totalCount = [db intForQuery:sql];
        
        //执行block
        block(totalCount);
        
    }];
}


@end
