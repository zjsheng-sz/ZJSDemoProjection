//
//  IPIPhotoBrowserViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/5/18.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIPhotoBrowserViewController.h"
#import <MWPhotoBrowser.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Masonry.h>


@interface IPIPhotoBrowserViewController ()<MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSMutableArray *phones;
@property (nonatomic, strong) NSMutableArray *photoAssets;
@property (nonatomic, strong) NSMutableArray *videoAssets;
@property (nonatomic, strong) ALAssetsLibrary *ALAssetsLibrary;

@end

@implementation IPIPhotoBrowserViewController

- (ALAssetsLibrary *)ALAssetsLibrary{

    if (!_ALAssetsLibrary) {
        _ALAssetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _ALAssetsLibrary;
}

- (NSMutableArray *)phones{
    
    if (!_phones) {
        _phones = [[NSMutableArray alloc] init];
    }
    return _phones;
}

- (NSMutableArray *)photoAssets{
    
    if (!_photoAssets) {
        _photoAssets = [[NSMutableArray alloc] init];
    }
    
    return _photoAssets;
}

- (NSMutableArray *)videoAssets{
    
    if (!_videoAssets) {
        _videoAssets = [[NSMutableArray alloc] init];
    }
    return _videoAssets;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
    [self getImagesAndVideo];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 初始化视图

- (void)configView{

    UIButton *showPhotoButton = [[UIButton alloc] init];
    [self.view addSubview:showPhotoButton];
    
    UIButton *showVideoButton = [[UIButton alloc] init];
    [self.view addSubview:showVideoButton];
    
    showPhotoButton.frame = CGRectMake(100, 100, 120, 50);
    showVideoButton.frame = CGRectMake(100, 300, 120, 50);
    showPhotoButton.backgroundColor = [UIColor redColor];
    showVideoButton.backgroundColor = [UIColor greenColor];
    [showPhotoButton setTitle:@"photo" forState:UIControlStateNormal];
    [showVideoButton setTitle:@"video" forState:UIControlStateNormal];
    [showPhotoButton addTarget:self action:@selector(showPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [showVideoButton addTarget:self action:@selector(showVideoAction:) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark action
- (void)showPhotoAction:(UIButton *)button{
    
    [self.phones removeAllObjects];

//    NSMutableArray *copy = [self.photoAssets copy];
    
    for (ALAsset *asset in self.photoAssets) {
        MWPhoto *photo = [MWPhoto photoWithURL:asset.defaultRepresentation.url];
        [self.phones addObject:photo];
        
        if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo) {
            photo.videoURL = asset.defaultRepresentation.url;
        }
    }
    
    [self detailImage:0];

}

- (void)showVideoAction:(UIButton *)button{
    
    [self.phones removeAllObjects];

//    NSMutableArray *copy = [self.videoAssets copy];
    
    for (ALAsset *asset in self.videoAssets) {
        MWPhoto *photo = [MWPhoto photoWithURL:asset.defaultRepresentation.url];
        [self.phones addObject:photo];
        
        if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo) {
            photo.videoURL = asset.defaultRepresentation.url;
        }
    }
    
    [self detailImage:0];
}

- (void)detailImage:(NSInteger)index
{
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES;
    // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO;
    // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO;
    // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES;
    // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO;
    // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES;
    // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO;
    // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.autoPlayOnAppear = NO;
    // Auto-play first video
    // Customise selection images to change colours if required
    browser.customImageSelectedIconName = @"ImageSelected.png";
    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:index];
    
    [self.navigationController pushViewController:browser animated:YES];
    
    //    [self presentViewController:browser animated:YES completion:nil];
}

#pragma mark 获取照片

-(void)getImagesAndVideo
{
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *myerror){
        NSLog(@"相册访问失败 =%@", [myerror localizedDescription]);
        if ([myerror.localizedDescription rangeOfString:@"Global denied access"].location!=NSNotFound) {
            NSLog(@"无法访问相册.请在'设置->定位服务'设置为打开状态.");
        }else{
            NSLog(@"相册访问失败.");
        }
    };
    
    [self.videoAssets removeAllObjects];
    [self.photoAssets removeAllObjects];
    
    ALAssetsGroupEnumerationResultsBlock groupEnumerAtion = ^(ALAsset *result, NSUInteger index, BOOL *stop){
        if (result!=NULL) {
            
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                
                //                    NSURL * photoUrl =result.defaultRepresentation.url;//图片的url
                /*result.defaultRepresentation.fullScreenImage//图片的大图
                 result.thumbnail                             //图片的缩略图小图
                 //                    NSRange range1=[urlstr rangeOfString:@"id="];
                 //                    NSString *resultName=[urlstr substringFromIndex:range1.location+3];
                 //                    resultName=[resultName stringByReplacingOccurrencesOfString:@"&ext=" withString:@"."];//格式demo:123456.png
                 */
                //照片跟视频共用一个model
//                fileTransferTableViewCellModel * videoModel = [[fileTransferTableViewCellModel alloc]init];
//                videoModel.videoDate = [result valueForProperty:ALAssetPropertyDate];
//                videoModel.videoFileName = result.defaultRepresentation.filename;
//                videoModel.videoFileSize = result.defaultRepresentation.size;
//                videoModel.videoUrl = result.defaultRepresentation.url;
//                
//                [self.photoUrlStrArr addObject:videoModel];
//                [self.photoAssets addObject:result];
                
                NSURL *url = result.defaultRepresentation.url;
                
                [self.ALAssetsLibrary assetForURL:url
                                  resultBlock:^(ALAsset *asset) {
                                      if (asset) {
                                          @synchronized(self.photoAssets) {
                                              [self.photoAssets addObject:asset];
//                                              if (_assets.count == 1) {
//                                                  // Added first asset so reload data
//                                                  [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//                                              }
                                          }
                                      }
                                  }
                                 failureBlock:^(NSError *error){
                                     NSLog(@"operation was not successfull!");
                                 }];
                
                
            }
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                
//                fileTransferTableViewCellModel * videoModel = [[fileTransferTableViewCellModel alloc]init];
//                videoModel.videoDate = [result valueForProperty:ALAssetPropertyDate];
//                videoModel.videoFileName = result.defaultRepresentation.filename;
//                videoModel.videoFileSize = result.defaultRepresentation.size;
//                videoModel.videoUrl = result.defaultRepresentation.url;
//                
//                [self.videoUrlStrArr addObject:videoModel];
                
//                [self.videoAssets addObject:result];
                NSURL *url = result.defaultRepresentation.url;
                
                [self.ALAssetsLibrary assetForURL:url
                                      resultBlock:^(ALAsset *asset) {
                                          if (asset) {
                                              @synchronized(self.videoAssets) {
                                                  [self.videoAssets addObject:asset];
                                                  //                                              if (_assets.count == 1) {
                                                  //                                                  // Added first asset so reload data
                                                  //                                                  [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                                  //                                              }
                                              }
                                          }
                                      }
                                     failureBlock:^(NSError *error){
                                         NSLog(@"operation was not successfull!");
                                     }];
                
            }
        }
    };
    
    
    
    ALAssetsLibraryGroupsEnumerationResultsBlock
    libraryGroupsEnumeration = ^(ALAssetsGroup* group, BOOL* stop){
        
        if (group == nil)
        {
            
        }
        
        if (group!=nil) {
            NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
            NSLog(@"gg:%@",g);//gg:ALAssetsGroup - Name:Camera Roll, Type:Saved Photos, Assets count:71
            
            NSString *g1=[g substringFromIndex:16 ] ;
            NSArray *arr=[[NSArray alloc] init];
            arr=[g1 componentsSeparatedByString:@","];
            NSString *g2=[[arr objectAtIndex:0] substringFromIndex:5];
            if ([g2 isEqualToString:@"Camera Roll"]) {
                g2=@"相机胶卷";
            }
            NSString *groupName=g2;//组的name
            
            [group enumerateAssetsUsingBlock:groupEnumerAtion];
        }
        
    };
    
    [self.ALAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:libraryGroupsEnumeration
                         failureBlock:failureblock];
    //    });
    
}


#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    
    //    _phones = [[NSMutableArray alloc] init];
    //    for (int i = 0; i<self.photoUrlStrArr.count; i++) {
    //
    //        fileTransferTableViewCellModel *model = self.photoUrlStrArr[i];
    //        MWPhoto *photo1 = [MWPhoto photoWithURL:model.videoUrl];
    //
    ////        MWPhoto *photo1 = [MWPhoto photoWithImage:self.imgs[i]];
    //        [_phones addObject:photo1];
    //    }
    //    return _phones.count;
    
    return _phones.count;
}


- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    
    if (index < self.phones.count) {
        return [self.phones objectAtIndex:index];
    }
    
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
