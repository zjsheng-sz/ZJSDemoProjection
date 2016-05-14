//
//  ViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/3/14.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+HexColor.h"
#import "AppDelegate.h"
#import <Masonry/Masonry.h>
#import "ConfigMacro.h"

#import "LGJFoldHeaderView.h"

#import "IPIMapViewController.h"
#import "IPIMasonryViewController.h"
#import "IPIGraphicViewController.h"
#import "IPIWebViewController.h"
#import "IPIMessageViewController.h"
#import "IPITextKitViewController.h"
#import "IPIFileViewController.h"
#import "IPIShareIktViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,FoldSectionHeaderViewDelegate>

@property(nonatomic, strong) UIView *statusBarView;//状态栏
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *functionsArray;
@property(nonatomic, strong) NSArray *sectionArray;
@property(nonatomic, strong) NSDictionary* foldInfoDic;/**< 存储开关字典 */


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configData];

    //状态栏和导航栏的设置
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar addSubview:self.statusBarView];
    
    [self.view addSubview:self.tableView];
    
}

//此方法不掉用，这么回事？？
- (UIStatusBarStyle)preferredStatusBarStyle{

//  return UIStatusBarStyleDefault;
    return UIStatusBarStyleDefault;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark 初始化数据
- (void)configData{
    
    _sectionArray = @[@"view",@"基础知识",@"数据&数据处理",@"网络"];
    _functionsArray = @[@[@"百度地图",@"Masonry",@"图像绘制",@"WebView",
                          @"Mess",@"图片压缩",@"Text Kit",@"其它应用打开",@"collectionView"],
                        @[@"C语言",@"GCD",@"加密"],
                        @[@"FMDB",@"CoreData",@"文件"],
                        @[@"AFNetWorking",@"socket封装"]];
    
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"0",
                                                                   @"1":@"0",
                                                                   @"2":@"0",
                                                                   @"3":@"0"
                                                                   }];
}

#pragma mark tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _sectionArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    LGJFoldHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[LGJFoldHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    
    [headerView setFoldSectionHeaderViewWithTitle:_sectionArray[section] detail:@"" type: HerderStyleTotal section:section canFold:YES];
    headerView.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    headerView.fold = folded;
    return headerView;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSArray *array = [_functionsArray objectAtIndex:section];
    
    return folded?array.count:0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    NSArray *array = [_functionsArray objectAtIndex:indexPath.section];
    cell.textLabel.text = array[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0://view
        {
            switch (indexPath.row) {
                case 0:
                {
                    IPIMapViewController *mapViewController = [[IPIMapViewController alloc] init];
                    [self.navigationController pushViewController:mapViewController animated:YES];
                }
                    break;
                    
                case 1:
                {
                    IPIMasonryViewController *masonryViewController = [[IPIMasonryViewController alloc] init];
                    [self.navigationController pushViewController:masonryViewController animated:YES];
                }
                    break;
                    
                case 2:
                {
                    IPIGraphicViewController *masonryViewController = [[IPIGraphicViewController alloc] init];
                    [self.navigationController pushViewController:masonryViewController animated:YES];
                }
                    break;
                    
                case 3:
                {
                    IPIWebViewController *webViewController = [[IPIWebViewController alloc] init];
                    [self.navigationController pushViewController:webViewController animated:YES];
                }
                    break;
                    
                case 4:
                {
                    IPIMessageViewController *messageViewController = [[IPIMessageViewController alloc] init];
                    [self.navigationController pushViewController:messageViewController animated:YES];
                }
                    break;
                case 5:
                {

                }
                    break;
                case 6:
                {
                    IPITextKitViewController *textKitViewController = [[IPITextKitViewController alloc] init];
                    [self.navigationController pushViewController:textKitViewController animated:YES];
                }
                    break;
                case 7:
                {
                    IPIShareIktViewController *shareViewController = [[IPIShareIktViewController alloc] init];
                    [self.navigationController pushViewController:shareViewController animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1://基础知识
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {

                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 2://data
        {
            switch (indexPath.row) {
                case 0:
                {

                }
                    break;
                case 1:
                {

                }
                    break;
                case 2:
                {
                    IPIFileViewController *fileViewController = [[IPIFileViewController alloc] init];
                    [self.navigationController pushViewController:fileViewController animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 3://netWork
        {
            switch (indexPath.row) {
                case 0:
                {
                
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark getter and setter
- (UIView *)statusBarView{
    
    if (!_statusBarView) {
        
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
        _statusBarView.backgroundColor = [UIColor colorWithHexString:@"28B2E7"];

    }
    
    return _statusBarView;
}


- (UITableView *)tableView{
        
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


#pragma mark sectionDelegate

- (void)foldHeaderInSection:(NSInteger)SectionHeader{

    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
