//
//  FileInfoModel.h
//  ZJSDemoProjection
//
//  Created by robert on 16/5/7.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileInfoModel : NSObject

@property(nonatomic, assign) long sourceID;
@property(nonatomic, copy) NSString *fileName;
@property(nonatomic, copy) NSString *sendTime;

@end
