//
//  fileTransferTableViewCellModel.h
//  CloudAdressBookV2
//
//  Created by apple on 15-7-21.
//  Copyright (c) 2015年 wds. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  文件选择界面的cellModel,tableView/collectionView共用
 */
@interface fileTransferTableViewCellModel : NSObject

//照片跟视频共用一个model
@property(nonatomic,assign)int64_t videoFileSize;
@property(nonatomic,copy)NSURL * videoUrl;
@property(nonatomic,copy)NSDate * videoDate;
@property(nonatomic,copy)NSString * videoFileName;

@end
