//
//  DataBaseSimple.h
//  UITestDemo
//
//  Created by sword on 14-8-15.
//  Copyright (c) 2014年 maozhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "FileInfoModel.h"

@interface DataBaseSimple : NSObject

+(DataBaseSimple *)shareInstance;

#pragma mark UserModel
-(void)insertUserIntoDB:(UserModel *)model;
-(void)deleteUserFromDBWithNumber:(int)num;
-(void)deleteAllUserFromDB;
-(void)updateUserFromDBWithNumber:(int)num withModifyUserModel:(UserModel *)model;
-(UserModel *)selectUserFromDBWithNumber:(int)num;
-(NSMutableArray *)selectAllUserFromDB;

#pragma mark FileInfoModel

- (void)addFileInfoModel:(FileInfoModel *)fileInfo;
- (void)removeFileInfoBySouceId:(long )sourceId;
- (void)removeAllFileInfos;
- (void)modifyFileInfoBySourceId:(long)sourceId newFileInfo:(FileInfoModel *)newFileInfoModel;
- (FileInfoModel *)fetchFileInfoBySourceId:(long)sourceId;
- (NSArray *)fetchAllFileInfos;

@end
