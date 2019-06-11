//
//  DeHTTPNetwork.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPNetwork.h"

@interface DeHTTPNetwork () <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
@property (nonatomic, strong) NSOperationQueue *delegateQueue;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSLock *lock;
@end

@implementation DeHTTPNetwork

- (void)dealloc{
    [_session finishTasksAndInvalidate];
    _session = nil;
    _delegateQueue = nil;
    _lock = nil;
    _tasks = nil;
}

- (instancetype)init{
    self = [super init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    _delegateQueue = [[NSOperationQueue alloc] init];
    _delegateQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    
    _session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:_delegateQueue];
    
    _tasks = [NSMutableDictionary dictionary];
    _lock = [[NSLock alloc] init];
    return self;
}

//认证
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler{
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
    }
}

//响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    DeHTTPDataTask *requestTask = [self taskWithDataTask:dataTask];
    [requestTask URLSession:session dataTask:dataTask didReceiveResponse:response completionHandler:completionHandler];
}

//完成
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    DeHTTPDataTask *requestTask = [self taskWithDataTask:task];
    [requestTask URLSession:session task:task didCompleteWithError:error];
    [self removeTask:requestTask];
}

//接受数据
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    DeHTTPDataTask *requestTask = [self taskWithDataTask:dataTask];
    [requestTask URLSession:session dataTask:dataTask didReceiveData:data];
}

- (DeHTTPDataTask *)dataTaskWithRequest:(NSURLRequest *)request success:(DeHTTPDataTaskSuccessBlock)success failed:(DeHTTPDataTaskFailedBlock)failed{
    NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request];
    DeHTTPDataTask *requestTask = [[DeHTTPDataTask alloc] initWithDataTask:dataTask
                                                              successBlock:success
                                                               failedBlock:failed];    
    [dataTask resume];
    [self addTask:requestTask];
    return requestTask;
}

- (void)cancel{
    [_lock lock];
    [_tasks enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        DeHTTPDataTask *task = obj;
        [task.dataTask cancel];
    }];
    [_lock unlock];    
    [_session finishTasksAndInvalidate];
}

- (void)addTask:(DeHTTPDataTask *)task{
    [_lock lock];
    _tasks[@(task.dataTask.taskIdentifier)] = task;
    [_lock unlock];
}

- (void)removeTask:(DeHTTPDataTask *)task{
    [_lock lock];
    _tasks[@(task.dataTask.taskIdentifier)] = nil;
    [_lock unlock];
}

- (DeHTTPDataTask *)taskWithDataTask:(NSURLSessionTask *)dataTask{
    DeHTTPDataTask *task = nil;
    [_lock lock];
    task = _tasks[@(dataTask.taskIdentifier)];
    [_lock unlock];
    return task;
}
@end
