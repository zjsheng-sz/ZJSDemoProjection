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

@interface ViewController ()

@property(nonatomic, strong) UIImageView *statusBarView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar addSubview:self.statusBarView];
    
    
}

- (UIView *)statusBarView{
    
    if (!_statusBarView) {
//        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
//        _statusBarView.backgroundColor = [UIColor colorWithHexString:@"28B2E7"];
        
        _statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 320, 20)];
        _statusBarView.image = [UIImage imageNamed:IMAGENAME_NAVIGATIONBAR];
        
        
    }
    
    return _statusBarView;
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

@end
