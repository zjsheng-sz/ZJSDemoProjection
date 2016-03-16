//
//  IPIMasonryView.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/17.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIMasonryView.h"
#import <Masonry/Masonry.h>

@implementation IPIMasonryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{

    if (self = [super init]) {
        
        self.button = [[UIButton alloc] init];
    }
    
    return self;
}


+ (BOOL)requiresConstraintBasedLayout{

    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    
    // --- remake/update constraints here
    
    [self.button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.buttonSize.width));
        make.height.equalTo(@(self.buttonSize.height));
    }];
    
    //according to apple super should be called at end of method
//    [super updateViewConstraints];
}

- (void)didTapButton:(UIButton *)button {
    // --- Do your changes ie change variables that affect your layout etc ---
    self.buttonSize = CGSizeMake(200, 200);
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
}
@end
