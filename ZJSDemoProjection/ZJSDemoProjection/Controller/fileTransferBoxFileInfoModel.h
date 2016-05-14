//
//  fileTransferBoxFileInfoModel.h
//  CloudAdressBookV2
//
//  Created by apple on 15-7-24.
//  Copyright (c) 2015年 wds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fileTransferBoxFileInfoModel : NSObject

@property(nonatomic,copy)NSNumber * fileSize;
@property(nonatomic,copy)NSDate * fileCreateDate;
@property(nonatomic,copy)NSString * fileName;

@property(nonatomic,copy)NSString * fileOwner;
@property(nonatomic,copy)NSDate * fileModDate;


@end
