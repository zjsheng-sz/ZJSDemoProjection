//
//  fileTransferCollectionViewCell.h
//  CloudAdressBookV2
//
//  Created by apple on 15-7-21.
//  Copyright (c) 2015年 wds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fileTransferCustomSelectedView.h"
#import "fileTransferTableViewCellModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

//设备的宽度
#define IPHONE_WIDTH [[UIScreen mainScreen]bounds].size.width
//设备的高度
#define IPHONE_HEIGHT [[UIScreen mainScreen]bounds].size.height


/**
 *  文件选择界面collectionView的cell
 */
@interface fileTransferCollectionViewCell : UICollectionViewCell

//这三个已经转换好了，文件传输能用到
@property(nonatomic,assign)NSString  * FileSize;
@property(nonatomic,copy)NSString * fileDate;
@property(nonatomic,copy)NSString * FileName;

-(void)refrashData:(fileTransferTableViewCellModel *)Model;

@end
