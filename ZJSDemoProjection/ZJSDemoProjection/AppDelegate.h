//
//  AppDelegate.h
//  ZJSDemoProjection
//
//  Created by ipi on 16/3/14.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    //百度地图
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

