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
    
#if 0
    /*第一种方式：UIKit框架绘制一个蓝色圆圈*/
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 80, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];
#endif
    
#if 0
    /*第二种方式：CoreGraphic框架来绘制一个蓝色圆圈*/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(100, 70, 100, 100));
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillPath(context);
#endif
    
#if 0
    /*第五种方式：*/
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
#endif
    
#if 0
    /*第六种方式*/
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(10, 10, 100, 100));
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillPath(context);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [self addSubview:imgView];
    
#endif
    
#if 0
    /*UIImage.图像平移*/
    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * 2, size.height), NO, 0);
    [headImage drawAtPoint:CGPointMake(0, 0)];
    [headImage drawAtPoint:CGPointMake(size.width, 0)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = self.center;
    [self addSubview:imageView];
    
#endif
    
#if 0
    /*UIImage.图像缩放*/
    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * 2, size.height * 2), NO, 0);
    [headImage drawInRect:CGRectMake(0, 0, size.width * 2, size.height * 2)];
    [headImage drawInRect:CGRectMake(size.width / 2.0, size.height / 2.0, size.width, size.height) blendMode:kCGBlendModeMultiply alpha:1.0];
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    imageView.center = self.center;
    
    
#endif
    
#if 0
    /*UIImage.图像截取*/
    UIImage* mars = [UIImage imageNamed:@"头像.png"];
    
    CGSize sz = [mars size];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(sz.width/2.0, sz.height), NO, 0);
    
    [mars drawAtPoint:CGPointMake(-sz.width/2.0, 0)];
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:im];
    [self addSubview:imageView];
    imageView.center = self.center;
    
#endif
    
#if 0
    /*CGImageRef.下面的代码展示了将图片拆分成两半，并分别绘制在上下文的左右两边：,未考虑@2x情况*/
    
    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    
    CGImageRef leftImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(0, 0, size.width/2.0, size.height));
    CGImageRef rightImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(size.width/2.0, 0, size.width/2.0, size.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width*3/2.0, size.height), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 0, size.width/2.0, size.height), flip(leftImg));
    CGContextDrawImage(context, CGRectMake(size.width, 0, size.width/2.0, size.height), flip(rightImg));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    imageView.center = self.center;
    
    CGImageRelease(leftImg);
    
    CGImageRelease(rightImg);
    
#endif
    
    
#if 0
    
    /*CGImageRef.下面的代码展示了将图片拆分成两半，并分别绘制在上下文的左右两边：,考虑了@2x情况*/
    
    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage),CGImageGetHeight(headImage.CGImage));
    
    CGImageRef leftImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(0,0,sizeCG.width/2.0,sizeCG.height));
    CGImageRef rightImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(sizeCG.width/2.0,0,sizeCG.width/2.0, sizeCG.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * 1.5, size.height), NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 0, size.width/2.0, size.height), flip(leftImg));
    CGContextDrawImage(context, CGRectMake(size.width, 0, size.width/2.0, size.height), flip(rightImg));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    imageView.center = self.center;
    
    CGImageRelease(leftImg);
    
    CGImageRelease(rightImg);
    
    
#endif
    
#if 0
    /*CGImageRef.换一种处理图片倒置的问题*/
    
    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage),CGImageGetHeight(headImage.CGImage));
    
    CGImageRef leftImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(0,0,sizeCG.width/2.0,sizeCG.height));
    CGImageRef rightImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(sizeCG.width/2.0,0,sizeCG.width/2.0, sizeCG.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * 1.5, size.height), NO, 0);
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextDrawImage(context, CGRectMake(0, 0, size.width/2.0, size.height), flip(leftImg));
//    CGContextDrawImage(context, CGRectMake(size.width, 0, size.width/2.0, size.height), flip(rightImg));
    
    [[UIImage imageWithCGImage:leftImg scale:[headImage scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(0, 0)];
    [[UIImage imageWithCGImage:rightImg scale:[headImage scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(size.width, 0)];

    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    imageView.center = self.center;
    
    CGImageRelease(leftImg);
    
    CGImageRelease(rightImg);
    
#endif
    
#if 0
    
    //CIFilter  CIImage  未弄懂
    
    UIImage* moi = [UIImage imageNamed:@"头像.png"];
    
    CIImage* moi2 = [[CIImage alloc] initWithCGImage:moi.CGImage];
    
    CIFilter* grad = [CIFilter filterWithName:@"CIRadialGradient"];
    
    CIVector* center = [CIVector vectorWithX:moi.size.width / 2.0 Y:moi.size.height / 2.0];
    
    // 使用setValue：forKey：方法设置滤镜属性
    
    [grad setValue:center forKey:@"inputCenter"];
    
    // 在指定滤镜名时提供所有滤镜键值对
    
    CIFilter* dark = [CIFilter filterWithName:@"CIDarkenBlendMode" keysAndValues:@"inputImage", grad.outputImage, @"inputBackgroundImage", moi2, nil];
    
    CIContext* c = [CIContext contextWithOptions:nil];
    
    CGImageRef moi3 = [c createCGImage:dark.outputImage fromRect:moi2.extent];
    
    UIImage* moi4 = [UIImage imageWithCGImage:moi3 scale:moi.scale orientation:moi.imageOrientation];
    
    CGImageRelease(moi3);
    
#endif
    
    
    [self coreGraphicMethod];
    
}

//core Graphic 属性
- (void)coreGraphicMethod{


    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    {

#if 0
        //CGPath
        
        // 绘图代码
        
        CGContextRef con = UIGraphicsGetCurrentContext();
        
        // 绘制一个黑色的垂直黑色线，作为箭头的杆子
        
        CGContextMoveToPoint(con, 100, 100);
        
        CGContextAddLineToPoint(con, 100, 19);
        
        CGContextSetLineWidth(con, 20);
        
        CGContextStrokePath(con);
        
        // 绘制一个红色三角形箭头
        
        CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
        
        CGContextMoveToPoint(con, 80, 25);
        
        CGContextAddLineToPoint(con, 100, 0);
        
        CGContextAddLineToPoint(con, 120, 25);
        
        CGContextFillPath(con);
        
        // 从箭头杆子上裁掉一个三角形，使用清除混合模式
                
        CGContextMoveToPoint(con, 90, 100);
        
        CGContextAddLineToPoint(con, 100, 90); 
        
        CGContextAddLineToPoint(con, 110, 100);
        
        CGContextSetBlendMode(con, kCGBlendModeClear); 
        
        CGContextFillPath(con);
        
#endif
        
#if 0
        //UIBezierPath
        UIBezierPath* p = [UIBezierPath bezierPath];
        
        [p moveToPoint:CGPointMake(100,100)];
        
        [p addLineToPoint:CGPointMake(100, 19)];
        
        [p setLineWidth:20];
        
        [p stroke];
        
        [[UIColor redColor] set];
        
        [p removeAllPoints];
        
        [p moveToPoint:CGPointMake(80,25)];
        
        [p addLineToPoint:CGPointMake(100, 0)];
        
        [p addLineToPoint:CGPointMake(120, 25)];
        
        [p fill];
        
        [p removeAllPoints];
        
        [p moveToPoint:CGPointMake(90,101)];
        
        [p addLineToPoint:CGPointMake(100, 90)]; 
        
        [p addLineToPoint:CGPointMake(110, 101)]; 
        
        [p fillWithBlendMode:kCGBlendModeClear alpha:1.0];
#endif
        
#if 1
        
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
        
        CGContextSetLineWidth(ctx, 3);
        
        UIBezierPath *path;
        
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerTopRight) cornerRadii:CGSizeMake(10, 10)];
        
        [path stroke];
        
#endif
        
        
    } 
    
    CGContextRestoreGState(ctx);
    
    
    
}


CGImageRef flip (CGImageRef image){

    CGSize size = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image);
    
    CGImageRef resultImgRef = [UIGraphicsGetImageFromCurrentImageContext() CGImage];

    return resultImgRef;
}





@end
