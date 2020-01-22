//
//  DeHTTPDataTask.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPDataTask.h"
#import "DeHTTPManager.h"

@interface DeHTTPDataTask ()

@end

@implementation DeHTTPDataTask

- (void)dealloc{
    _dataTask = nil;
    _successBlock = nil;
    _failedBlock = nil;
}

- (instancetype)initWithDataTask:(NSURLSessionDataTask *)dataTask successBlock:(DeHTTPDataTaskSuccessBlock)successBlock failedBlock:(DeHTTPDataTaskFailedBlock)failedBlock{
    self = [super init];
    _dataTask = dataTask;
    _successBlock = successBlock;
    _failedBlock = failedBlock;
    return self;
}

//完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if (error) {
        _error = error;
        _failedBlock(self, task.response, error);
    }else{
        _successBlock(self, task.response, _data);
    }
    _failedBlock = nil; _successBlock = nil;
}

//接受数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [_data appendData:data];
}

//响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    _response = response;
    _data = [NSMutableData data];
    //next
    NSURLSessionResponseDisposition disposition = NSURLSessionResponseAllow;
    completionHandler(disposition);
}


- (NSDictionary *)userInfo{
    NSMutableDictionary *userInfo = @{}.mutableCopy;
    userInfo[DeHTTPManagerUserinfoTaskKey] = _dataTask;
    userInfo[DeHTTPManagerUserinfoDataKey] = _data;
    userInfo[DeHTTPManagerUserinfoResponseKey] = _response;
    userInfo[DeHTTPManagerUserinfoErrorKey] = _error;
    return userInfo;
}

- (void)setCanceled:(BOOL)canceled{
    if (canceled) {
        _data = nil;
    }
    NSString *key = NSStringFromSelector(@selector(isCancelled));
    [self willChangeValueForKey:key];
    _canceled = canceled;
    [self didChangeValueForKey:key];
}
@end
