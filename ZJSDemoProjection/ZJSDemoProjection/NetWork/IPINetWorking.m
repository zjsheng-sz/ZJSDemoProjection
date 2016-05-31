//
//  IPINetWorking.m
//  ZJSDemoProjection
//
//  Created by robert on 16/3/16.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPINetWorking.h"
#import <AFNetworking/AFNetworking.h>

@interface IPINetWorking ()

@end

static IPINetWorking *networkSingle = nil;
static NETSTATUS netStatues = 0;

@implementation IPINetWorking

+(instancetype)shareNetWorking{
    
    static dispatch_once_t oneToken;
    dispatch_once(& oneToken, ^{
        
        if (!networkSingle) {
            networkSingle = [[IPINetWorking alloc] init];
        }
    });
    
    return networkSingle;
    
}

+ (NETSTATUS)instanceNetStatues{

    return netStatues;
}


+ (void)isNetWorkReachable{
    
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [afNetworkReachabilityManager startMonitoring];
    
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通");
                networkSingle.isReach = NO;
//                [ZJSNetWorking showAlertText:@"网络不可用"];
                netStatues = NETSTATUS_NONET;
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过3G连接");
                networkSingle.isReach = YES;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"KnetworkReachableNotification" object:nil];
                netStatues = NETSTATUS_VIA3G;
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接");
                networkSingle.isReach = YES;
                netStatues = NETSTATUS_VIAWIFI;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"KnetworkReachableNotification" object:nil];
            }
                break;
                
            default:
                break;
        }
    }];
    
}


- (void)postNetworkWithHostUrl:(NSString *)host
                        subUrl:(NSString *)subUrl
                        method:(NSString *)method
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionTask *, id responseObject))success
                       failure:(void (^)(NSURLSessionTask *, NSError * error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/xml"];
    manager.requestSerializer.timeoutInterval = 10;
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",host,subUrl,method];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        
        success(task,responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"%@",error.localizedDescription);
        
        failure(task,error);
        
    }];
    
}


// 待修改
- (void)cancelNetwork{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
    
}


@end
