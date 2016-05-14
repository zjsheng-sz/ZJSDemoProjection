//
//  fileTransferCollectionViewCell.m
//  CloudAdressBookV2
//
//  Created by apple on 15-7-21.
//  Copyright (c) 2015年 wds. All rights reserved.
//

#import "fileTransferCollectionViewCell.h"

@implementation fileTransferCollectionViewCell


-(void)refrashData:(fileTransferTableViewCellModel *)Model
{
    
    //根据图片的url反取图片
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    NSURL * url = Model.videoUrl;
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset)  {
        UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
        self.backgroundView = [[UIImageView alloc]initWithImage:image];
        
    }failureBlock:^(NSError *error) {
        NSLog(@"error=%@",error);
    }
     ];
    self.FileName = Model.videoFileName;
    
    self.fileDate =[self timerWithDate:Model.videoDate];
    
    self.FileSize = [self MBwithB:Model.videoFileSize];
}

-(NSString *)MBwithB:(int64_t)b
{
    //b转换MB
    NSString * MB = nil;
    float b1 = (float)b;
    if ((b1 < 1024)) {
        MB = [NSString stringWithFormat:@"%.2f B",b1];
        return MB;
    }
    else
    {
        if (b1/1024 < 1024) {
            MB = [NSString stringWithFormat:@"%.2f K",b1/1024];
            return MB;
        }
        else
        {
            MB = [NSString stringWithFormat:@"%.2f M",(float)b/1024/1024];
            return MB;
        }
    }
    
}

- (NSString *)timerWithDate:(NSDate *)date
{
    NSString * time = nil;
    //将时间转换为正常的时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate * localeDate = [date  dateByAddingTimeInterval: interval];
    time = [NSString stringWithFormat:@"%@",localeDate];//demo:2014-11-14 10:12:32 +0000
    time = [time substringToIndex:19];//demo:2014-11-14 10:12:32
    return time;
}

@end
