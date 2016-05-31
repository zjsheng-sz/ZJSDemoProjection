//
//  CoreDataSimple.h
//  ZJSDemoProjection
//
//  Created by robert on 16/5/8.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DepartMent+CoreDataProperties.h"
#import "Staff+CoreDataProperties.h"

@interface CoreDataSimple : NSObject

+(instancetype)shareInstance;



/**
 *  增加部门
 *
 *  @param departMent 部门
 */
- (void)addDepartMent:(DepartMent *)departMent;

/**
 *  根据id移除部门
 *
 *  @param departMentID 部门id
 */
- (void)removeDepartMentByDepartMentID:(NSString *)departMentID;

/**
 *  移除所有部门
 */
- (void)removeAllDepartments;

/**
 *  修改部门
 *
 *  @param departMentID  被修改的部门id
 *  @param newDepartMent 修改后的部门
 */
- (void)modifyDepartMentByDepartMentID:(NSString *)departMentID newDepartMent:(DepartMent *)newDepartMent;

/**
 *  根据id获取部门
 *
 *  @param departMentID 部门id
 *
 *  @return 部门
 */
- (DepartMent *)fetchDepartMentByDepartMentID:(NSString *)departMentID;

/**
 *  获取所有部门
 *
 *  @return 部门数组
 */
- (NSArray *)fetchAllDepartMents;



@end
