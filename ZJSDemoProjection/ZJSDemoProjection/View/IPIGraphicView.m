//
//  IPIGraphicView.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/21.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIGraphicView.h"

@implementation IPIGraphicView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    /*UIKit框架绘制一个蓝色圆圈*/
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 80, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [path fill];

    /*CoreGraphic框架来绘制一个蓝色圆圈*/
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(context, CGRectMake(100, 70, 100, 100));
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillPath(context);
    

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
}


@end
