//
//  IPINetWorking.h
//  ZJSDemoProjection
//
//  Created by robert on 16/3/16.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, NETSTATUS) {
    
    NETSTATUS_NONET = 0,
    NETSTATUS_VIAWIFI,
    NETSTATUS_VIA3G,
    NETSTATUS_VIA4G
};


@interface IPINetWorking : NSObject

@property(nonatomic,assign) BOOL isReach;

+ (instancetype)shareNetWorking;//单例创建

+ (NETSTATUS) instanceNetStatues;
//网络状态的实时监测
+ (void) isNetWorkReachable; //第一次请求网络的时候必须调用一次

//取消请求
- (void)cancelNetwork;


//AF3.0
/*因为NSURLConnection 在iOS9中被弃，都改成NSURLSession使用，所以AF中基于NSURLConnection的API全部改用基于NSURLSession的API*/
//网络请求
- (void)postNetworkWithHostUrl:(NSString *)host subUrl:(NSString *)subUrl
                        method:(NSString *)method
                        params:(NSDictionary *)params
                       success:(void (^)(NSURLSessionTask *operation, id responseObject))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;


@end
