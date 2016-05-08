//
//  Staff+CoreDataProperties.h
//  ZJSDemoProjection
//
//  Created by robert on 16/3/18.
//  Copyright © 2016年 zjs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Staff.h"

NS_ASSUME_NONNULL_BEGIN

@interface Staff (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *departMentID;
@property (nullable, nonatomic, retain) NSString *staffID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phoneNum;
@property (nullable, nonatomic, retain) DepartMent *inDepartMent;

@end

NS_ASSUME_NONNULL_END
