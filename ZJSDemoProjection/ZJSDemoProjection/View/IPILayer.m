//
//  IPILayer.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/22.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPILayer.h"

@implementation IPILayer

- (void)drawInContext:(CGContextRef)ctx{

    //1.绘制图形
    //画一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
    
    //设置属性（颜色）
    //    [[UIColor yellowColor]set];
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    
    //2.渲染
    CGContextFillPath(ctx);

}

@end
