//
//  DepartMent.h
//  ZJSDemoProjection
//
//  Created by robert on 16/3/18.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Staff;

NS_ASSUME_NONNULL_BEGIN

@interface DepartMent : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (void)addDepartMent:(DepartMent *)departMent;
- (void)removeDepartMentByDepartMentID:(NSString *)departMentID;
- (void)removeAllDepartments;
- (void)modifyDepartMentByDepartMentID:(NSString *)departMentID newDepartMent:(DepartMent *)newDepartMent;
- (DepartMent *)fetchDepartMentByDepartMentID:(NSString *)departMentID;
- (NSArray *)fetchAllDepartMents;


@end

NS_ASSUME_NONNULL_END

#import "DepartMent+CoreDataProperties.h"
