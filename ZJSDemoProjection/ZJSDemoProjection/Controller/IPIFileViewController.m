//
//  IPIFileViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/4/21.
//  Copyright © 2016年 zjs. All rights reserved.
//



#import "IPIFileViewController.h"
#import <Masonry.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

const NSInteger READ_LENGTH = 1024; // 1M

@interface IPIFileViewController ()

@property(nonatomic, strong)NSFileManager *fileManager;

@property(nonatomic, strong)NSString *homePath;
@property(nonatomic, strong)NSString *documentPath;
@property(nonatomic, strong)NSString *libraryPath;
@property(nonatomic, strong)NSString *tmpPath;
@property(nonatomic, strong)NSString *cachesPath;

@property(nonatomic, strong)NSMutableArray *alubms;
@property(nonatomic, strong)UIImage *originImage;
@property(nonatomic, assign)BOOL usePhotoKit;


@end

@implementation IPIFileViewController

#pragma mark - setter and getter

- (NSMutableArray *)alubms{
    if (!_alubms) {
        _alubms = [[NSMutableArray alloc] init];
    }
    return _alubms;
}

- (NSString *)homePath{
    
    if (!_homePath) {
        _homePath = NSHomeDirectory();
    }
    return _homePath;

}

- (NSString *)documentPath{
    
    if (!_documentPath) {
        _documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
    }
    return _documentPath;
}

- (NSString *)tmpPath{

    if (!_tmpPath) {
        _tmpPath = NSTemporaryDirectory();
    }
    return _tmpPath;
}

- (NSString *)cachesPath{

    if (!_cachesPath) {
        _cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    return _cachesPath;
}

- (NSString *)libraryPath{

    if (!_libraryPath) {
        _libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    return _libraryPath;
}


#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self fileTest];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - 布局

/**
 *  3列4行的item,item大小相等,item之间的间隔为10,与边缘的间距为20,为了熟练Masonry自动布局
 */
- (void)configView{
    
    CGFloat gap = 10.0;
    CGFloat margin = 20.0;
    NSInteger xNum = 3;
    NSInteger yNum = 4;
    
    CGFloat width = (self.view.bounds.size.width - 2 * margin - (xNum-1)*gap)/3.0;
    CGFloat height = (self.view.bounds.size.height -64 - 2 * margin - (yNum-1)*gap)/4.0;
    
    for (int i = 0; i < yNum; i ++) {//4行
        for (int j = 0; j < xNum; j ++) {//3列
            //
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            [self.view addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               
                CGFloat left = margin + j * width + j * gap;
                CGFloat top = margin + i * height + i * gap;
                
                make.width.equalTo([NSNumber numberWithFloat:width]);
                make.height.equalTo([NSNumber numberWithFloat:height]);
                make.left.equalTo([NSNumber numberWithFloat:left]);
                make.top.equalTo([NSNumber numberWithFloat:top]);
                
            }];
            
        }
    }
    
}

/**
 *  Masonry 自动布局
 */
- (void)configViews{
    
    //添加按钮
    UIButton *addFileButton = [[UIButton alloc] init];
    [self.view addSubview:addFileButton];
    addFileButton.backgroundColor = [UIColor redColor];
    [addFileButton setTitle:@"add" forState:UIControlStateNormal];
    
    //读取按钮
    UIButton *readFileButton = [[UIButton alloc] init];
    [self.view addSubview:readFileButton];
    readFileButton.backgroundColor = [UIColor redColor];
    [readFileButton setTitle:@"read" forState:UIControlStateNormal];

    //删除按钮
    UIButton *deleteFileButton = [[UIButton alloc] init];
    [self.view addSubview:deleteFileButton];
    deleteFileButton.backgroundColor = [UIColor redColor];
    [deleteFileButton setTitle:@"delete" forState:UIControlStateNormal];

    
    [readFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        
    }];
    
    [deleteFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(readFileButton).offset(100);
        make.centerX.equalTo(@[readFileButton,addFileButton]);
        make.size.equalTo(@[readFileButton,addFileButton]);
        
    }];
    
    [addFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(readFileButton).offset(-100);

    }];
    
}

#pragma mark fileManager 操作

- (void)fileTest{

    _fileManager = [NSFileManager defaultManager];
    

    
//    //1、从项目中获得图片文件, 写入到沙盒, 再从沙盒中取出显示
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"jpg"];
//    NSData *imageData = [NSData dataWithContentsOfFile:path];
//    NSString *imageFilePath = [self.documentPath stringByAppendingPathComponent:@"dog.jpg"];
//    [self createFileWithPath:imageFilePath];
//    [imageData writeToFile:imageFilePath atomically:YES];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageFilePath]];
//    [self.view addSubview:imgView];
//    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view).centerOffset(CGPointMake(0, 0));
//        
//    }];
    
    
        //1、从项目中获得图片文件, 写入到沙盒, 再从沙盒中取出显示
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"jpg"];
        NSData *imageData = [self fileHandleReadFromFilePath:path];
        NSString *imageFilePath = [self.documentPath stringByAppendingPathComponent:@"dog.jpg"];
        [self createFileWithPath:imageFilePath];
        [imageData writeToFile:imageFilePath atomically:YES];
    
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:imageFilePath]];
        [self.view addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view).centerOffset(CGPointMake(0, 0));
            
        }];

    
}

//创建文件夹
- (BOOL)createDirectoryWithPath:(NSString *)directoryPath{
    
    BOOL isDirectory;
    BOOL isExistDirPath = [_fileManager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (isExistDirPath && isDirectory) {//存在文件夹
        NSLog(@"存在文件夹，不用创建");
        return NO;
    }
    
    BOOL isCreateDir = [_fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (isCreateDir) {
        NSLog(@"文件夹创建成功");
        return YES;
        
    }else{
        NSLog(@"文件夹创建失败");
        
        return NO;
    }
    
}
//创建文件
- (BOOL)createFileWithPath:(NSString *)filePath{
    
    BOOL isDirectory;
    BOOL isExistFilePath = [_fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    if (isExistFilePath && !isDirectory) {//存在文件
        NSLog(@"存在文件，不用创建");
        return NO;
    }
    
    BOOL isCreateDir = [_fileManager createFileAtPath:filePath contents:nil attributes:nil];
    
    if (isCreateDir) {
        NSLog(@"文件创建成功");
        return YES;
        
    }else{
        NSLog(@"文件创建失败");
        
        return NO;
    }
    
}

//删除文件夹

- (BOOL)deleItemWithPath:(NSString *)path{

    if ([_fileManager fileExistsAtPath:path]) {
        
        BOOL result = [_fileManager removeItemAtPath:path error:nil];
        
        if (result) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return NO;
}

//string, array, dictionary, data 直接写入文件
-(BOOL)writeFileWithFilePath:(NSString *)filePath Content:(NSString *)content{
    
    //字典，数组，字符串一样
    BOOL res=[content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
        return YES;
    }else{
        NSLog(@"文件写入失败");
        return NO;
    }
    
}

//读文件
-(NSString *)readWithFilePath:(NSString *)filePath {
    
    NSString *content=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return content;
}

//获取属性
- (void)getAttributeWithPath:(NSString *)path{

    NSDictionary * attributeDic = [_fileManager attributesOfItemAtPath:path error:nil];
    NSLog(@"attributeDic = %@",attributeDic);
    /*
     NSFileCreationDate = "2016-03-27 11:57:45 +0000";
     NSFileExtensionHidden = 0;
     NSFileGroupOwnerAccountID = 20;
     NSFileGroupOwnerAccountName = staff;
     NSFileModificationDate = "2016-04-21 13:40:38 +0000";
     NSFileOwnerAccountID = 501;
     NSFilePosixPermissions = 493;
     NSFileReferenceCount = 7;
     NSFileSize = 238;
     NSFileSystemFileNumber = 91905958;
     NSFileSystemNumber = 16777220;
     NSFileType = NSFileTypeDirectory;
     */
    
    /*
    NSFileCreationDate = "2016-04-22 17:12:57 +0000";
    NSFileExtendedAttributes =     {
        "com.apple.TextEncoding" = <7574662d 383b3133 34323137 393834>;
    };
    NSFileExtensionHidden = 0;
    NSFileGroupOwnerAccountID = 20;
    NSFileGroupOwnerAccountName = staff;
    NSFileModificationDate = "2016-04-22 17:12:57 +0000";
    NSFileOwnerAccountID = 501;
    NSFilePosixPermissions = 420;
    NSFileReferenceCount = 1;
    NSFileSize = 6;
    NSFileSystemFileNumber = 92948881;
    NSFileSystemNumber = 16777220;
    NSFileType = NSFileTypeRegular;
    */
}

#pragma mark - fileHandle 操作

- (void)fileHandleWriteToFilePath:(NSString *)filePath{

    NSFileHandle *writehandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    [writehandle seekToEndOfFile];
    
    NSString *appendingString = @"精彩纷呈的世界";
    for (int i = 0; i < 10 ; i ++) {
        [writehandle writeData:[appendingString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [writehandle closeFile];
    
}


- (NSData *)fileHandleReadFromFilePath:(NSString *)filePath{
    
    NSMutableData *mData = [[NSMutableData alloc] init];

    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    
    NSDictionary * fileAttribute = [_fileManager attributesOfItemAtPath:filePath error:nil];

    CGFloat fileSize = [[fileAttribute objectForKey:NSFileSize] floatValue];
    
    CGFloat readLength = 0.0;
    
    while (readLength < fileSize) {
        
        NSData *data = [readHandle readDataOfLength:READ_LENGTH];
        //send

        [mData appendData:data];
        
        readLength += READ_LENGTH;
    }
    
    return mData;
}

#pragma mark - 获取系统相册
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)photoMethod{

    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    
    PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:nil];
    //注意类型
    for (PHAssetCollection *sub in smartAlbumsFetchResult1)
    {
        //遍历到数组中
        [self.alubms addObject:sub];
    }
    
//    PHFetchResult *group = [PHAsset fetchAssetsInAssetCollection:[self.alubms objectAtIndex:indexPath.row] options:nil];
}

- (void)a{
    
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 列出所有用户创建的相册
    PHFetchResult *topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    
    NSLog(@"smartAlbums.count = %d, topLevelUserCollections.count = %d, assetsFetchResults.count = %d",(int)smartAlbums.count, (int)topLevelUserCollections.count,(int)assetsFetchResults.count);
}

- (void)bWithFetchResult:(PHFetchResult *)fetchResult fetchOptions:(PHFetchOptions *)fetchOptions{
    
    
    // 列出所有相册智能相册
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 这时 smartAlbums 中保存的应该是各个智能相册对应的 PHAssetCollection
    for (NSInteger i = 0; i < fetchResult.count; i++) {
        // 获取一个相册（PHAssetCollection）
        PHCollection *collection = fetchResult[i];
        if ([collection isKindOfClass:[PHAssetCollection class]]) {
            PHAssetCollection *assetCollection = (PHAssetCollection *)collection;
            // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
            PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:fetchOptions];
        }else {
                NSAssert(NO, @"Fetch collection not PHCollection: %@", collection);
        }
    }
        
        // 获取所有资源的集合，并按资源的创建时间排序
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
        // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
        for (NSInteger i = 0; i < fetchResult.count; i++) {
            // 获取一个资源（PHAsset）
            PHAsset *asset = fetchResult[i];
        }
        
}

/*
- (UIImage *)originImage {
    if (_originImage) {
        return _originImage;
    }
    __block UIImage *resultImage;
    if (_usePhotoKit) {
        PHImageRequestOptions *phImageRequestOptions = [[PHImageRequestOptions alloc] init];
        phImageRequestOptions.synchronous = YES;
        [[[QMUIAssetsManager sharedInstance] phCachingImageManager] requestImageForAsset:_phAsset
                                                                              targetSize:PHImageManagerMaximumSize
                                                                             contentMode:PHImageContentModeDefault
                                                                                 options:phImageRequestOptions
                                                                           resultHandler:^(UIImage *result, NSDictionary *info) {
                                                                               resultImage = result;
                                                                           }];
    } else {
        CGImageRef fullResolutionImageRef = [_alAssetRepresentation fullResolutionImage];
        // 通过 fullResolutionImage 获取到的的高清图实际上并不带上在照片应用中使用“编辑”处理的效果，需要额外在 AlAssetRepresentation 中获取这些信息
        NSString *adjustment = [[_alAssetRepresentation metadata] objectForKey:@"AdjustmentXMP"];
        if (adjustment) {
            // 如果有在照片应用中使用“编辑”效果，则需要获取这些编辑后的滤镜，手工叠加到原图中
            NSData *xmpData = [adjustment dataUsingEncoding:NSUTF8StringEncoding];
            CIImage *tempImage = [CIImage imageWithCGImage:fullResolutionImageRef];
            
            NSError *error;
            NSArray *filterArray = [CIFilter filterArrayFromSerializedXMP:xmpData
                                                         inputImageExtent:tempImage.extent
                                                                    error:&error];
            CIContext *context = [CIContext contextWithOptions:nil];
            if (filterArray && !error) {
                for (CIFilter *filter in filterArray) {
                    [filter setValue:tempImage forKey:kCIInputImageKey];
                    tempImage = [filter outputImage];
                }
                fullResolutionImageRef = [context createCGImage:tempImage fromRect:[tempImage extent]];
            }
        }
        // 生成最终返回的 UIImage，同时把图片的 orientation 也补充上去
        resultImage = [UIImage imageWithCGImage:fullResolutionImageRef scale:[_alAssetRepresentation scale] orientation:(UIImageOrientation)[_alAssetRepresentation orientation]];
    }
    _originImage = resultImage;
    return resultImage;
}

- (NSInteger)requestOriginImageWithCompletion:(void (^)(UIImage *, NSDictionary *))completion withProgressHandler:(PHAssetImageProgressHandler)phProgressHandler {
    if (_usePhotoKit) {
        if (_originImage) {
            // 如果已经有缓存的图片则直接拿缓存的图片
            if (completion) {
                completion(_originImage, nil);
            }
            return 0;
        } else {
            PHImageRequestOptions *imageRequestOptions = [[PHImageRequestOptions alloc] init];
            imageRequestOptions.networkAccessAllowed = YES; // 允许访问网络
            imageRequestOptions.progressHandler = phProgressHandler;
            return [[[QMUIAssetsManager sharedInstance] phCachingImageManager] requestImageForAsset:_phAsset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:imageRequestOptions resultHandler:^(UIImage *result, NSDictionary *info) {
                // 排除取消，错误，低清图三种情况，即已经获取到了高清图时，把这张高清图缓存到 _originImage 中
                BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
                if (downloadFinined) {
                    _originImage = result;
                }
                if (completion) {
                    completion(result, info);
                }
            }];
        }
    } else {
        if (completion) {
            completion([self originImage], nil);
        }
        return 0;
    }
}
*/

@end
