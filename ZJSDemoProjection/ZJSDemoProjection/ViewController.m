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

#import "IPIMapViewController.h"
#import "IPIMasonryViewController.h"
#import "IPIGraphicViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong) UIImageView *statusBarView;//状态栏
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *functionsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //
    _functionsArray = @[@"百度地图",@"Masonry",@"AFNetWorking",@"CoreData",@"加密",@"FMDB",@"图像绘制"];

    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
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
#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _functionsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = _functionsArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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
            
        case 6:
        {
            IPIGraphicViewController *masonryViewController = [[IPIGraphicViewController alloc] init];
            [self.navigationController pushViewController:masonryViewController animated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark getter and setter
- (UIView *)statusBarView{
    
    if (!_statusBarView) {
        //        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
        //        _statusBarView.backgroundColor = [UIColor colorWithHexString:@"28B2E7"];
        
        _statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
        _statusBarView.image = [UIImage imageNamed:IMAGENAME_NAVIGATIONBAR];
        
    }
    
    return _statusBarView;
}


- (UITableView *)tableView{
        
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    return _tableView;
}


@end
