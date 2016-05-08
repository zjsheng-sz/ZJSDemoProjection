//
//  UserModel.h
//  UITestDemo
//
//  Created by 毛志 on 14-8-11.
//  Copyright (c) 2014年 maozhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,assign) int number;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,copy) NSString * gender;

@end
