//
//  fileTransferCustomSelectedView.m
//  CloudAdressBookV2
//
//  Created by apple on 15-7-21.
//  Copyright (c) 2015年 wds. All rights reserved.
//

#define File_cell_selected @"intercept_checked.png"

#import "fileTransferCustomSelectedView.h"

@implementation fileTransferCustomSelectedView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*3/4, 3, self.frame.size.width/4 -3, self.frame.size.width/4- 3)];
        imgView.image = [UIImage imageNamed:File_cell_selected];
        UIView * view = [[UIView alloc]initWithFrame:self.bounds];
        view.backgroundColor = [UIColor lightGrayColor];
        view.alpha = 0.7;
        [self addSubview:view];
        [self addSubview:imgView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
