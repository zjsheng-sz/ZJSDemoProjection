//
//  IPIShareIktViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/5/3.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIShareIktViewController.h"
#import <Masonry.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuickLook/QuickLook.h>

@interface IPIShareIktViewController ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,retain)UIDocumentInteractionController *docController;
@property (nonatomic, strong) NSMutableArray *photoAssets;
@property (nonatomic, strong) NSMutableArray *videoAssets;
@end

@implementation IPIShareIktViewController

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

- (void)configView{

    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
}

- (void)buttonAction{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];
    [self showMenuWithPath:path];
    
}


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
                NSLog(@"*** photo result.defaultRepresentation.url = %@",result.defaultRepresentation.url);
//                [self.photoUrlStrArr addObject:videoModel];
                [self.photoAssets addObject:result];
                
            }
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
                
//                fileTransferTableViewCellModel * videoModel = [[fileTransferTableViewCellModel alloc]init];
//                videoModel.videoDate = [result valueForProperty:ALAssetPropertyDate];
//                videoModel.videoFileName = result.defaultRepresentation.filename;
//                videoModel.videoFileSize = result.defaultRepresentation.size;
//                videoModel.videoUrl = result.defaultRepresentation.url;
//                
//                [self.videoUrlStrArr addObject:videoModel];
                
                NSLog(@"*** video result.defaultRepresentation.url = %@",result.defaultRepresentation.url);
                
                [self.videoAssets addObject:result];
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
    
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:libraryGroupsEnumeration
                         failureBlock:failureblock];
    //    });
    
}



- (void)showMenuWithPath:(NSString *)path{
    
//    _docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL  fileURLWithPath:@"assets-library://asset/asset.MOV?id=E5F7CC57-8D2E-4AE4-A9D6-36FF12F87561&ext=MOV"]];//为该对象初始化一个加载路径
    _docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL  URLWithString:@"assets-library://asset/asset.MOV?id=E5F7CC57-8D2E-4AE4-A9D6-36FF12F87561&ext=MOV"]];//为该对象初始化一个加载路径

    
    _docController.delegate =self;//设置代理

    //直接显示预览
    // [_docController presentPreviewAnimated:YES];

    CGRect navRect =self.navigationController.navigationBar.frame;
    navRect.size =CGSizeMake(1500.0f,40.0f);

    //显示包含预览的菜单项
    
    [_docController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];

    //显示不包含预览菜单项
    //[docController presentOpenInMenuFromRect:navRect inView:self.view animated:YES];
}

//4、代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
                      
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}
                      
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return  self.view.frame;
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
