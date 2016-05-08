//
//  DataBaseSimple.m
//  UITestDemo
//
//  Created by sword on 14-8-15.
//  Copyright (c) 2014年 maozhi. All rights reserved.
//

#import "DataBaseSimple.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"


@implementation DataBaseSimple
{
    // 定义FMDB
    FMDatabaseQueue * _dbQueue;
}


+(DataBaseSimple *)shareInstance
{
    static DataBaseSimple * simple = nil;
    
    if (simple == nil) {
        simple = [[DataBaseSimple alloc] init];
    }
    
    return simple;
}


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        // 数据库创建 表格创建
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString * path = [documentPath stringByAppendingPathComponent:@"Documents/User.db"];
        NSLog(@"path is %@",path);
        
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        
        [_dbQueue inDatabase:^(FMDatabase *db) {
            if (![db executeUpdate:@"create table if not exists User (Number integer primary key autoincrement,Name text,Password text,Gender text)"]) {
                NSLog(@"create user table error!");
                return;
            }
            
            if (![db executeUpdate:@"create table if not exists FileInfo (sourceID integer primary key autoincrement,fileName text,sendTime text)"]) {
                
                NSLog(@"create fileInfo table error!");
                return;
            }
        }];
    }
    return self;
}

#pragma mark UserModel

- (void)insertUserIntoDB:(UserModel *)model{
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (![db executeUpdate:@"insert into User (Number,Name,Password,Gender) values (?,?,?,?)",[NSNumber numberWithInt:model.number],model.name,model.password,model.gender]) {
            NSLog(@"insert db error!");
        }
    }];

}

- (void)deleteUserFromDBWithNumber:(int)num{

    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (![db executeUpdate:@"delete from User where Number=?",[NSNumber numberWithInt:num]]) {
            NSLog(@"delete data error!");
        }
    }];
}

- (void)deleteAllUserFromDB{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (![db executeUpdate:@"delete from User"]) {
            NSLog(@"delete User error!");
        }
    }];

}

- (void)updateUserFromDBWithNumber:(int)num withModifyUserModel:(UserModel *)model{

    [_dbQueue inDatabase:^(FMDatabase *db) {
        if (![db executeUpdate:@"update User set Name=?,Password=?,Gender=? where Number=?",model.name,model.password,model.gender,[NSNumber numberWithInt:model.number]]) {
            NSLog(@"update error!");
        }
    }];

}

- (UserModel *)selectUserFromDBWithNumber:(int)num{

    __block UserModel * model = [[UserModel alloc] init];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:@"select * from User where Number=?",[NSNumber numberWithInt:num]];
        [set next];
        model.number = [set intForColumn:@"Number"];
        model.name = [set stringForColumn:@"Name"];
        model.password = [set stringForColumn:@"Password"];
        model.gender = [set stringForColumn:@"Gender"];
    }];
    return model;

}

- (NSMutableArray *)selectAllUserFromDB{

    __block NSMutableArray * arr = [NSMutableArray array];
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:@"select * from User"];
        while ([set next]) {
            UserModel * model = [[UserModel alloc] init];
            model.number = [set intForColumn:@"Number"];
            model.name = [set stringForColumn:@"Name"];
            model.password = [set stringForColumn:@"Password"];
            model.gender = [set stringForColumn:@"Gender"];
            [arr addObject:model];
        }
    }];
    return arr;

}

#pragma mark FileInfoModel

- (void)addFileInfoModel:(FileInfoModel *)fileInfo{

    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into FileInfo (sourceID, fileName, sendTime) values(?,?,?)",[NSNumber numberWithLong:fileInfo.sourceID],fileInfo.fileName,fileInfo.sendTime];
    }];

}

- (void)removeFileInfoBySouceId:(long )sourceId{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from FileInfo where sourceID = ?",[NSNumber numberWithLong:sourceId]];
    }];
}

- (void)removeAllFileInfos{

    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"drop table FileInfo"];
    }];

}

- (void)modifyFileInfoBySourceId:(long)sourceId newFileInfo:(FileInfoModel *)newFileInfoModel{

    [_dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update FileInfo set sourceID = ? , fileName = ? , sendTime = ? where sourceID = ?",newFileInfoModel.sourceID, newFileInfoModel.fileName, newFileInfoModel.sendTime];
    }];

}

- (FileInfoModel *)fetchFileInfoBySourceId:(long)sourceId{

    FileInfoModel *fileInfoModel;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:@"select * from FileInfo where sourceID = ?",[NSNumber numberWithLong:sourceId]];
        
        fileInfoModel.sourceID = [set longForColumn:@"sourceID"];
        fileInfoModel.sendTime = [set stringForColumn:@"sendTime"];
        fileInfoModel.fileName = [set stringForColumn:@"fileName"];
        
    }];
    
    return fileInfoModel;
}


- (NSArray *)fetchAllFileInfos{
    
    NSMutableArray *mArray;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:@"select * from FileInfo"];
        
        while ([set next]) {
            
            FileInfoModel *fileInfoModel = [[FileInfoModel alloc] init];
            fileInfoModel.sourceID = [set longForColumn:@"sourceID"];
            fileInfoModel.sendTime = [set stringForColumn:@"sendTime"];
            fileInfoModel.fileName = [set stringForColumn:@"fileName"];
            [mArray addObject:fileInfoModel];
        }
        
    }];

    
    return [mArray copy];
}

#pragma mark 银行转账，安全模式


- (void) dbTransaction
{

    // User (ID,Name,Money)
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL flag = YES;
        flag &= [db executeUpdate:@"update User set Money=Money-50 where Name=?",@"zhangsan"];
        flag &= [db executeUpdate:@"update User set Money=Money+50 where Name=?",@"lisi"];
        if (flag) {
            // 两个操作同时成功
            NSLog(@"转账成功");
        }else{
            // 两个操作同时失败 回滚
            *rollback = YES;
            NSLog(@"转账失败，资金已经退回银行账号");
        }
    }];


    FMDatabase *dataBase = nil;
    [dataBase beginTransaction];
    BOOL flag = YES;
    flag &= [dataBase executeUpdate:@"update User set Money=Money-50 where Name=?",@"zhangsan"];
    flag &= [dataBase executeUpdate:@"update User set Money=Money+50 where Name=?",@"lisi"];
    if (flag) {
        NSLog(@"转账成功");
        [dataBase commit];
    }else{
        NSLog(@"转账失败");
        [dataBase rollback];
    }

}



@end
