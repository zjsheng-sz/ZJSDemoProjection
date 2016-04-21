//
//  IPIFileViewController.h
//  ZJSDemoProjection
//
//  Created by ipi on 16/4/21.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIBasicViewController.h"

@interface IPIFileViewController : IPIBasicViewController
{
    int _point;
}


- (int)setPoint:(NSInteger)point;
- (int)point;

@end
