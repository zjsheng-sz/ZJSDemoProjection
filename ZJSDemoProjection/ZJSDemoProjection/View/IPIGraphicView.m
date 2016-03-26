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
    [self drawCircleWithUIKit];
    [self drawCircleWithCoreGraphic];
    [self drawCircleWithImageContex];
    
#endif
    
#if 0
    [self moveImage];
    [self scaleImage];
    [self clipImage];
    [self divideImage];
    [self divideImageAnotherWay];
#endif
    
#if 0 //Core Image 未搞懂
    [self simpleFilter];
#endif
    
#if 0
    [self coreGraphicMethod];
#endif
    
#if 1
    //    [self clipMethod];
    [self gradientMethod];
    //    [self colorAndPattern];
    //    [self CTMMethod];
#endif
    
}


#pragma mark 用UIKit框架绘制

- (void)drawCircleWithUIKit{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];

}

#pragma mark 用CoreGraphic框架绘制


- (void)drawCircleWithCoreGraphic{

    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, CGRectMake(100, 0, 100, 100));
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextFillPath(context);
    
}

#pragma mark 用ImageContext绘制

- (void)drawCircleWithImageContex{

    UIGraphicsBeginImageContext(CGSizeMake(100, 100));

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, 100, 100));
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
}

#pragma mark 图像平移

- (void)moveImage{

    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage), CGImageGetHeight(headImage.CGImage));
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width * 2, size.height));
    [headImage drawAtPoint:CGPointMake(0, 0)];
    [headImage drawAtPoint:CGPointMake(size.width, 0)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, size.width * 2, size.height);
    [self addSubview:imageView];
}

#pragma mark 缩放图像

- (void)scaleImage{

    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage), CGImageGetHeight(headImage.CGImage));
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width * 2, size.height * 2));
    
    [headImage drawInRect:CGRectMake(0, 0, size.width * 2, size.height * 2)];
    [headImage drawInRect:CGRectMake(size.width/2.0, size.height/2.0, size.width, size.height) blendMode:kCGBlendModeMultiply alpha:1.0];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(size.width * 2, 0, size.width * 2, size.height * 2);
    [self addSubview:imageView];
    
}

#pragma mark 截取图像

- (void)clipImage{

    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage), CGImageGetHeight(headImage.CGImage));
    
    UIGraphicsBeginImageContext(CGSizeMake(size.width/2.0, size.height));
    
    [headImage drawInRect:CGRectMake(- size.width/2.0, 0, size.width, size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(50, size.height * 2, image.size.width,image.size.height);
    [self addSubview:imageView];
    

}

#pragma mark 拆分图片放置于两边 考虑@2x 考虑倒置

- (void)divideImage{

    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage), CGImageGetHeight(headImage.CGImage));
    
    CGImageRef leftImageRef = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(0, 0, sizeCG.width/2.0, sizeCG.height));
    CGImageRef rightImageRef = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(sizeCG.width/2.0, 0, sizeCG.width/2.0, sizeCG.height));
    
    UIGraphicsBeginImageContext(CGSizeMake(sizeCG.width * 1.5, sizeCG.height));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //图像倒置
    CGContextTranslateCTM(context, 0, sizeCG.height);
    CGContextScaleCTM(context, 1, -1);
    
    CGContextDrawImage(context, CGRectMake(0, 0, sizeCG.width / 2.0, sizeCG.height), leftImageRef);
    CGContextDrawImage(context, CGRectMake(sizeCG.width, 0, sizeCG.width/2.0, sizeCG.height), rightImageRef);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(100, 200, size.width * 1.5, size.height);
    [self addSubview:imageView];
    
    CFRelease(leftImageRef);
    CFRelease(rightImageRef);
}

- (void)divideImageAnotherWay{
    
    UIImage *headImage = [UIImage imageNamed:@"头像.png"];
    CGSize size = [headImage size];
    CGSize sizeCG = CGSizeMake(CGImageGetWidth(headImage.CGImage),CGImageGetHeight(headImage.CGImage));
    
    CGImageRef leftImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(0,0,sizeCG.width/2.0,sizeCG.height));
    CGImageRef rightImg = CGImageCreateWithImageInRect(headImage.CGImage, CGRectMake(sizeCG.width/2.0,0,sizeCG.width/2.0, sizeCG.height));
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width * 1.5, size.height), NO, 0);

    [[UIImage imageWithCGImage:leftImg scale:[headImage scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(0, 0)];
    [[UIImage imageWithCGImage:rightImg scale:[headImage scale] orientation:UIImageOrientationUp] drawAtPoint:CGPointMake(size.width, 0)];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    imageView.center = self.center;
    
    CGImageRelease(leftImg);
    
    CGImageRelease(rightImg);
    
}

#pragma mark 滤镜

- (void)simpleFilter{
    
    UIImage* originImage = [UIImage imageNamed:@"dog.jpg"];
    
    CIImage* originImageRef = [[CIImage alloc] initWithCGImage:originImage.CGImage];
    
    CIFilter* grad = [CIFilter filterWithName:@"CIRadialGradient"];
    
    CIVector* center = [CIVector vectorWithX:originImage.size.width / 2.0 Y:originImage.size.height / 2.0];
    
    // 使用setValue：forKey：方法设置滤镜属性
    
    [grad setValue:center forKey:@"inputCenter"];
    
    // 在指定滤镜名时提供所有滤镜键值对
    
    CIFilter* dark = [CIFilter filterWithName:@"CIDarkenBlendMode" keysAndValues:@"inputImage", grad.outputImage, @"inputBackgroundImage", originImageRef, nil];
    
    CIContext* c = [CIContext contextWithOptions:nil];
    
    CGImageRef moi3 = [c createCGImage:dark.outputImage fromRect:originImageRef.extent];
    
    UIImage* moi4 = [UIImage imageWithCGImage:moi3 scale:originImage.scale orientation:originImage.imageOrientation];
    
    CGImageRelease(moi3);
    
    
    
    
    
    
    
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:originImage];
    imageView2.frame = CGRectMake(0, 0, originImage.size.width, originImage.size.height);
    [self addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:moi3 scale:[originImage scale] orientation:UIImageOrientationUp]];
    imageView3.frame = CGRectMake(0, (originImage.size.height + 10), originImage.size.width, originImage.size.height);
    [self addSubview:imageView3];
    
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:moi4];
    imageView4.frame = CGRectMake(0, (originImage.size.height + 10) * 2, originImage.size.width, originImage.size.height);
    [self addSubview:imageView4];
    
}


#pragma mark 绘制火箭

- (void)coreGraphicMethod{
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    {
        
#if 1
        //CGPath
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextSetLineWidth(context, 25);
        CGContextMoveToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 100, 25);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, 100 - 20, 25);
        CGContextAddLineToPoint(context, 100 + 20, 25);
        CGContextAddLineToPoint(context, 100, 0);
        CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
        CGContextFillPath(context);
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
        
        
#if 0
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 3);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 100, 100) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(10, 10)];
        [path stroke];
        
#endif
        
    }
    
    CGContextRestoreGState(ctx);
    
    
}

#pragma mark 修剪火箭脚

- (void)clipMethod{
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(con);
    {
        
        // 在上下文裁剪区域中挖一个三角形状的孔
        
        CGContextMoveToPoint(con, 90, 100);
        
        CGContextAddLineToPoint(con, 100, 90);
        
        CGContextAddLineToPoint(con, 110, 100);
        
        CGContextClosePath(con);
        
        CGContextAddRect(con, CGContextGetClipBoundingBox(con));
        
        //使用奇偶规则，裁剪区域为矩形减去三角形区域
        
        CGContextEOClip(con);
        
        [self coreGraphicMethod];
    
    }
    
    CGContextRestoreGState(con);
}


#pragma mark 渐变火箭筒

- (void)gradientMethod{
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(con);
    
    //在上下文裁剪区域挖一个三角形孔
    
    CGContextMoveToPoint(con, 90, 100);
    
    CGContextAddLineToPoint(con, 100, 90);
    
    CGContextAddLineToPoint(con, 110, 100);
    
    CGContextClosePath(con);
    
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    
    CGContextEOClip(con);
    
    //绘制一个垂线，让它的轮廓形状成为裁剪区域
    
    CGContextMoveToPoint(con, 100, 100);
    
    CGContextAddLineToPoint(con, 100, 19);
    
    CGContextSetLineWidth(con, 20);
    
    CGContextFillPath(con);
    
    // 使用路径的描边版本替换图形上下文的路径
    
    CGContextReplacePathWithStrokedPath(con);
    
    // 对路径的描边版本实施裁剪
    
    CGContextClip(con);
    
    // 绘制渐变
    
    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    
    CGFloat colors[12] = {
        
        0.3,0.3,0.3,0.8, // 开始颜色，透明灰
        
        0.0,0.0,0.0,1.0, // 中间颜色，黑色
        
        0.3,0.3,0.3,0.8 // 末尾颜色，透明灰
        
    };
    
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
    
    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    
    CGContextDrawLinearGradient(con, grad, CGPointMake(89,0), CGPointMake(111,0), 0);
    
    CGColorSpaceRelease(sp);
    
    CGGradientRelease(grad);
    
    CGContextRestoreGState(con); // 完成裁剪
    
    // 绘制红色箭头
    
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    
    CGContextMoveToPoint(con, 80, 25);
    
    CGContextAddLineToPoint(con, 100, 0);
    
    CGContextAddLineToPoint(con, 120, 25);
    
    CGContextFillPath(con);
    
}

#pragma mark 颜色和模型

- (void)colorAndPattern{
    
    // 绘制红色箭头
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    //    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    
    
    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace (con, sp2);
    CGColorSpaceRelease (sp2);
    CGPatternCallbacks callback = {0, &drawStripes, NULL };
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGPatternRef patt = CGPatternCreate(NULL,CGRectMake(0,0,4,4), tr, 4, 4, kCGPatternTilingConstantSpacingMinimalDistortion, true, &callback);
    CGFloat alph = 1.0;
    CGContextSetFillPattern(con, patt, &alph);
    CGPatternRelease(patt);
    
    
    
    CGContextMoveToPoint(con, 80, 50);
    
    CGContextAddLineToPoint(con, 120, 0);
    
    CGContextAddLineToPoint(con, 160, 50);
    
    CGContextFillPath(con);
    
}


#pragma mark CTM转换

- (void)CTMMethod{
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(40,100), NO, 0.0);
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(con);
    
    CGContextMoveToPoint(con, 90 - 80, 100);
    
    CGContextAddLineToPoint(con, 100 - 80, 90);
    
    CGContextAddLineToPoint(con, 110 - 80, 100);
    
    CGContextMoveToPoint(con, 110 - 80, 100);
    
    CGContextAddLineToPoint(con, 100 - 80, 90);
    
    CGContextAddLineToPoint(con, 90 - 80, 100);
    
    CGContextClosePath(con);
    
    CGContextAddRect(con, CGContextGetClipBoundingBox(con));
    
    CGContextEOClip(con);
    
    CGContextMoveToPoint(con, 100 - 80, 100);
    
    CGContextAddLineToPoint(con, 100 - 80, 19);
    
    CGContextSetLineWidth(con, 20);
    
    CGContextReplacePathWithStrokedPath(con);
    
    CGContextClip(con);
    
    CGFloat locs[3] = { 0.0, 0.5, 1.0 };
    
    CGFloat colors[12] = {
        
        0.3,0.3,0.3,0.8,
        
        0.0,0.0,0.0,1.0,
        
        0.3,0.3,0.3,0.8
        
    };
    
    CGColorSpaceRef sp = CGColorSpaceCreateDeviceGray();
    
    CGGradientRef grad = CGGradientCreateWithColorComponents (sp, colors, locs, 3);
    
    CGContextDrawLinearGradient (con, grad, CGPointMake(89 - 80,0), CGPointMake(111 - 80,0), 0);
    
    CGColorSpaceRelease(sp);
    
    CGGradientRelease(grad);
    
    CGContextRestoreGState(con);
    
    CGColorSpaceRef sp2 = CGColorSpaceCreatePattern(NULL);
    
    CGContextSetFillColorSpace (con, sp2);
    
    CGColorSpaceRelease (sp2);
    
    CGPatternCallbacks callback = {0, &drawStripes, NULL };
    
    CGAffineTransform tr = CGAffineTransformIdentity;
    
    CGPatternRef patt = CGPatternCreate(NULL,CGRectMake(0,0,4,4),tr,4,4,kCGPatternTilingConstantSpacingMinimalDistortion,true, &callback);
    
    CGFloat alph = 1.0;
    
    CGContextSetFillPattern(con, patt, &alph);
    
    CGPatternRelease(patt);
    
    CGContextMoveToPoint(con, 80 - 80, 25);
    
    CGContextAddLineToPoint(con, 100 - 80, 0);
    
    CGContextAddLineToPoint(con, 120 - 80, 25);
    
    CGContextFillPath(con);
    
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    con = UIGraphicsGetCurrentContext();
    
    [im drawAtPoint:CGPointMake(0,0)];
    
    for (int i=0; i<3; i++) {
        
        CGContextTranslateCTM(con, 20, 100);
        
        CGContextRotateCTM(con, 30 * M_PI/180.0);
        
        CGContextTranslateCTM(con, -20, -100);
        
        [im drawAtPoint:CGPointMake(0,0)];
        
    }
}


void drawStripes (void *info, CGContextRef con) {
    
    // assume 4 x 4 cell
    
    CGContextSetFillColorWithColor(con, [[UIColor redColor] CGColor]);
    
    CGContextFillRect(con, CGRectMake(0,0,4,4));
    
    CGContextSetFillColorWithColor(con, [[UIColor blueColor] CGColor]);
    
    CGContextFillRect(con, CGRectMake(0,0,2,4));
    
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
