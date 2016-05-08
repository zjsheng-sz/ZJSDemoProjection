//
//  Reciever.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/30.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIReciever.h"
#import <GCDAsyncSocket.h>

@interface IPIReciever ()<GCDAsyncSocketDelegate>

@property(nonatomic, strong) NSString *port;
@property(nonatomic, strong) GCDAsyncSocket *seviceSocket;
@property(nonatomic, strong) NSMutableArray *clientSocketArr;//成员为：GCDAsyncSocket
@property(nonatomic, strong) NSMutableData *recieveData;

@end

@implementation IPIReciever

- (instancetype)initWithPort:(NSString *)port{

    
    if (self = [super init]) {
        _seviceSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        _recieveData = [[NSMutableData alloc] init];
        _clientSocketArr = [[NSMutableArray alloc] init];

    }
    
    return self;
}


- (void)listen{

    if (![_seviceSocket isConnected]) {
        //
        NSError *error = nil;
        
        if (![_seviceSocket acceptOnPort:self.port.intValue error:&error]) {
            NSLog(@"%@",error.localizedDescription);
        }
    }

}

- (void)disConnect{

    [_seviceSocket disconnect];
}

#pragma mark -GCDAsyncSocketDelegate

//接受到连接
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket{

    NSLog(@"Accept new socket: %@:%u", newSocket.connectedHost, newSocket.connectedPort);
    
    [self.clientSocketArr addObject:newSocket];
    
    
    
//    if (_clientSocket && [_clientSocket isConnected]) {
//
//        _clientSocket = nil;
//    }
//    _clientSocket = newSocket;
    
}


//连接成功
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{

    [sock readDataWithTimeout:-1 buffer:self.recieveData bufferOffset:0 tag:0];

}


//读取成功
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{

    if (self.delegate && [self.delegate respondsToSelector:@selector(reciever:didRecieveData:)]) {
        
        [self.delegate reciever:self didRecieveData:data];
    }

}


//读取一部分
- (void)socket:(GCDAsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{


}


//写入成功
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{


}


//写入一部分
- (void)socket:(GCDAsyncSocket *)sock didWritePartialDataOfLength:(NSUInteger)partialLength tag:(long)tag{


}


//断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{


}






@end
