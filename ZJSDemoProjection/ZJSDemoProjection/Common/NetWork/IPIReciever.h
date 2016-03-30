//
//  Reciever.h
//  ZJSDemoProjection
//
//  Created by robert on 16/3/30.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IPIReciever;

@protocol ReciverDelegate <NSObject>

- (void)reciever:(IPIReciever *)recieve didRecieveData:(NSData *)data;

@end

@interface IPIReciever : NSObject

@property (nonatomic, weak)id<ReciverDelegate> delegate;

- (instancetype)initWithPort:(NSString *)port;

- (void)listen;

- (void)disConnect;

@end
