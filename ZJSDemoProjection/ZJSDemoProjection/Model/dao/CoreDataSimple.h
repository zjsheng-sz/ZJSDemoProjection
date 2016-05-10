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

- (void)addDepartMent:(DepartMent *)departMent;
- (void)removeDepartMentByDepartMentID:(NSString *)departMentID;
- (void)removeAllDepartments;
- (void)modifyDepartMentByDepartMentID:(NSString *)departMentID newDepartMent:(DepartMent *)newDepartMent;
- (DepartMent *)fetchDepartMentByDepartMentID:(NSString *)departMentID;
- (NSArray *)fetchAllDepartMents;

@end
