//
//  CoreDataSimple.m
//  ZJSDemoProjection
//
//  Created by robert on 16/5/8.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "CoreDataSimple.h"
#import "AppDelegate.h"
#import "DepartMent.h"
#import "Staff.h"
#import "Staff+CoreDataProperties.h"
#import "DepartMent+CoreDataProperties.h"


@interface CoreDataSimple ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation CoreDataSimple


+ (instancetype)shareInstance{

    static CoreDataSimple * _coreDataSimple;
    
    if (!_coreDataSimple) {
        _coreDataSimple = [[self alloc] init];
    }
    
    return _coreDataSimple;

}

- (instancetype)init{
    
    if (self = [super init]) {
        
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = app.managedObjectContext;
    }
    
    return self;
}

#pragma mark CoreData-DepartMent

- (void)addDepartMent:(DepartMent *)departMent{
    
    NSError *error;
    NSEntityDescription *description=[NSEntityDescription entityForName:@"DepartMent" inManagedObjectContext:self.managedObjectContext];
    DepartMent* obj=[[DepartMent alloc]initWithEntity:description insertIntoManagedObjectContext:nil];
    
    obj.departMentID = departMent.departMentID;
    obj.name = departMent.name;
    obj.superDepartmentID = departMent.superDepartmentID;
    obj.staffs = departMent.staffs;
    obj.manager = departMent.manager;
    
    [self.managedObjectContext insertObject:obj];
    [self.managedObjectContext save:&error];

}


- (void)removeDepartMentByDepartMentID:(NSString *)departMentID{

    DepartMent *departMent = [self fetchDepartMentByDepartMentID:departMentID];

    if (departMent) {
        
        [self.managedObjectContext deleteObject:departMent];
        
    }
    
    NSError *error;
    [self.managedObjectContext save:&error];

}


- (void)removeAllDepartments{
    
    NSArray *allDepartMent = [self fetchAllDepartMents];
    
    for (DepartMent *departMent in allDepartMent) {
        
        [self.managedObjectContext deleteObject:departMent];
    }
    
    NSError *error;
    [self.managedObjectContext save:&error];

}
- (void)modifyDepartMentByDepartMentID:(NSString *)departMentID newDepartMent:(DepartMent *)newDepartMent{

    DepartMent *departMent = [self fetchDepartMentByDepartMentID:departMentID];
    
    if (departMent) {
        departMent.departMentID = newDepartMent.departMentID;
        departMent.name = newDepartMent.name;
        departMent.superDepartmentID = newDepartMent.superDepartmentID;
        departMent.staffs = newDepartMent.staffs;
        departMent.manager = newDepartMent.manager;
    }
    
    NSError *error;
    [self.managedObjectContext save:&error];
    
}


- (DepartMent *)fetchDepartMentByDepartMentID:(NSString *)departMentID{//根据部门查询，按部门排序
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"DepartMent"
                                        inManagedObjectContext:self.managedObjectContext]];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"departMentID"
                                                             ascending:YES];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortDesc];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"departMentID", departMentID];
    
//    NSFetchedResultsController *entdeptController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
//                                                                                        managedObjectContext:self.managedObjectContext
//                                                                                          sectionNameKeyPath:nil
//                                                                                                   cacheName:@"DepartMent"];
//    NSError *error;
//    
//    if (![entdeptController performFetch:&error])
//        return nil;
//    
//    if (entdeptController.fetchedObjects.count > 0) {
//        return [entdeptController.fetchedObjects objectAtIndex:0];
//    }
//    
//    return nil;
    
    
    NSError *error;
    NSArray *fetchResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchResults.count == 0)
    {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
        return nil;
    }
    
    if (fetchResults.count > 0) {
        return (DepartMent *)[fetchResults objectAtIndex:0];
    }
    
    return nil;
    
}


- (NSArray *)fetchAllDepartMents{//查询所有的部门（按部门排序）
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"DepartMent"
                                        inManagedObjectContext:self.managedObjectContext]];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"departMentID"
                                                             ascending:YES];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortDesc];
    NSFetchedResultsController *entdeptController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                        managedObjectContext:self.managedObjectContext
                                                                                          sectionNameKeyPath:nil
                                                                                                   cacheName:@"DepartMent"];
    NSError *error;
    
    if (![entdeptController performFetch:&error])
        return nil;
    
    if (entdeptController.fetchedObjects.count > 0) {
        return entdeptController.fetchedObjects;
    }
    
    return nil;
    
}

@end
