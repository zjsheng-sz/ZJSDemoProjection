//
//  DepartMent+CoreDataProperties.h
//  ZJSDemoProjection
//
//  Created by robert on 16/3/18.
//  Copyright © 2016年 zjs. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DepartMent.h"

NS_ASSUME_NONNULL_BEGIN

@interface DepartMent (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *departMentID;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *superDepartmentID;
@property (nullable, nonatomic, retain) NSSet<Staff *> *staffs;
@property (nullable, nonatomic, retain) Staff *manager;

@end

@interface DepartMent (CoreDataGeneratedAccessors)

- (void)addStaffsObject:(Staff *)value;
- (void)removeStaffsObject:(Staff *)value;
- (void)addStaffs:(NSSet<Staff *> *)values;
- (void)removeStaffs:(NSSet<Staff *> *)values;

@end

NS_ASSUME_NONNULL_END
