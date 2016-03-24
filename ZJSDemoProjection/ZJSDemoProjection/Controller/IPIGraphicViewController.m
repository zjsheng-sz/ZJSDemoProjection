//
//  IPIGraphicViewController.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/21.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIGraphicViewController.h"
#import <Masonry.h>
#import "IPIGraphicView.h"
#import "IPILayer.h"


/*
 
 2个框架：UIkit 和 Core Graphic
 
 */

@interface IPIGraphicViewController ()

@property (nonatomic, strong) IPIGraphicView *graphicView;
@property (nonatomic, strong) IPILayer *myLayer;
@property (nonatomic, strong) CALayer *myDelegateLayer;

@end

@implementation IPIGraphicViewController

#pragma mark getter and setter

-(IPIGraphicView *)graphicView{
    
    if (!_graphicView) {
        
        _graphicView = [[IPIGraphicView alloc] init];
        _graphicView.backgroundColor = [UIColor grayColor];
        UIEdgeInsets padding = UIEdgeInsetsMake(100, 10, 10, 10);
        [self.view addSubview:_graphicView]; //此处不能免掉
        
        [_graphicView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view).width.insets(padding);
            
        }];
                
    }
    
    return _graphicView;

}

- (IPILayer *)myLayer{
    
    if (!_myLayer) {
        //
        _myLayer = [IPILayer layer];
        _myLayer.backgroundColor = [UIColor brownColor].CGColor;
        _myLayer.bounds = CGRectMake(0, 0, 200, 150);
        _myLayer.anchorPoint = CGPointZero;
        _myLayer.position = CGPointMake(100, 100);
        _myLayer.cornerRadius = 20;
        _myLayer.shadowColor = [UIColor blackColor].CGColor;
        _myLayer.shadowOffset = CGSizeMake(10, 20);
        _myLayer.shadowOpacity = 0.6;
        [_myLayer setNeedsDisplay];
        
    }
    
    return _myLayer;
}

- (CALayer *)myDelegateLayer{

    if (!_myLayer) {
        
        _myDelegateLayer = [CALayer layer];
        _myDelegateLayer.backgroundColor = [UIColor blueColor].CGColor;
        _myDelegateLayer.bounds = CGRectMake(0, 0, 200, 150);
        _myDelegateLayer.position = CGPointMake(100, 100);
        _myDelegateLayer.cornerRadius = 10;
        
        _myDelegateLayer.delegate = self;
        
        [_myDelegateLayer setNeedsDisplay];

    }
    
    return _myLayer;
}



#pragma mark life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:self.graphicView];
//    [self.view.layer addSublayer:self.myLayer];
//    [self.view.layer addSublayer:_myDelegateLayer];
    
    
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{

    CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
    
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextFillPath(ctx);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
