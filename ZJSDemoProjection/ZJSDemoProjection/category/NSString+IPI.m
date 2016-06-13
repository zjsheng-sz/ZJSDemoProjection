//
//  NSString+IPI.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/6/13.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "NSString+IPI.h"

@implementation NSString (IPI)

//求size函数
- (CGSize)getTextHeightWithMaxWidth:(CGFloat)width font:(CGFloat)fontsize
{
    NSLog(@"%@",[UIDevice currentDevice].systemVersion);
    
    CGFloat systemVerson = [[UIDevice currentDevice].systemVersion floatValue];
    
    CGSize size;
    
    if (systemVerson >= 7.0) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName] context:nil];
        
        size = rect.size;
        
    }else{
    
        size = [self sizeWithFont:[UIFont systemFontOfSize:fontsize] constrainedToSize:CGSizeMake(width, 1000)];

    }
    
    return size;
}



- (CGSize)getTextWidthWithMaxHeight:(CGFloat)height font:(CGFloat)fontsize{

    NSLog(@"%@",[UIDevice currentDevice].systemVersion);
    
    CGFloat systemVerson = [[UIDevice currentDevice].systemVersion floatValue];
    
    CGSize size;
    
    if (systemVerson >= 7.0) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(320, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName] context:nil];
        
        size = rect.size;
        
    }else{
        
        size = [self sizeWithFont:[UIFont systemFontOfSize:fontsize] constrainedToSize:CGSizeMake(320, height)];
        
    }
    
    return size;

}

@end
