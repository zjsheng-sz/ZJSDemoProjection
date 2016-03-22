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

/*
 
 2个框架：UIkit 和 Core Graphic
 
 */

@interface IPIGraphicViewController ()

@property (nonatomic, strong) IPIGraphicView *graphicView;

@end

@implementation IPIGraphicViewController

#pragma mark getter and setter

-(IPIGraphicView *)graphicView{
    
    if (!_graphicView) {
        
        _graphicView = [[IPIGraphicView alloc] init];
        _graphicView.backgroundColor = [UIColor redColor];
        UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
        [self.view addSubview:_graphicView]; //此处不能免掉
        
        [_graphicView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view).width.insets(padding);
            
        }];
                
    }
    
    return _graphicView;

}

#pragma mark life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.graphicView];
    
    CALayer *myLayer = [CALayer layer];
    
    myLayer.delegate = self;
    
    [myLayer setNeedsDisplay];

    
    [self.view.layer addSublayer:myLayer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{


    UIGraphicsPushContext(ctx);
    
    UIBezierPath* p = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0,100,100)];
    
    [[UIColor blueColor] setFill];
    
    [p fill];
    
    UIGraphicsPopContext();
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
