//
//  IPIMasonryViewController.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/16.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIMasonryViewController.h"
#import <Masonry/Masonry.h>
#import "UIColor+HexColor.h"

@interface IPIMasonryViewController ()

@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;

@end

@implementation IPIMasonryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
//    [self.view addSubview:self.view1];
    [self.view addSubview:self.view2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark setter and Getter

//普通的
-(UIView *)view1{
    
    if (!_view1) {
        
        _view1 = [[UIView alloc] init];
        _view1.translatesAutoresizingMaskIntoConstraints = NO;
        _view1.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_view1];
        
        UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
        
        [self.view addConstraints:@[
                                    
                                    //view1 constraints
                                    [NSLayoutConstraint constraintWithItem:_view1
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:padding.top],
                                    
                                    [NSLayoutConstraint constraintWithItem:_view1
                                                                 attribute:NSLayoutAttributeLeft
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeft
                                                                multiplier:1.0
                                                                  constant:padding.left],
                                    
                                    [NSLayoutConstraint constraintWithItem:_view1
                                                                 attribute:NSLayoutAttributeBottom
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:-padding.bottom],
                                    
                                    [NSLayoutConstraint constraintWithItem:_view1
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1
                                                                  constant:-padding.right],
                                    
                                    ]];

    }

    return _view1;
}


- (UIView *)view2{

    if (!_view2) {
        //
        
        UIEdgeInsets padding = UIEdgeInsetsMake(20, 20, 20, 20);
        
        _view2 = [[UIView alloc] init];
        _view2.backgroundColor = [UIColor redColor];
        [self.view addSubview:_view2];
        
        [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).width.insets(padding);
        }];
        
    }
    
    return _view2;
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
