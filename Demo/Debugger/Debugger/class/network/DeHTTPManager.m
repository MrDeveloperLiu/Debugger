//
//  DeHTTPManager.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPManager.h"
#import "Debugger.h"

NSString *const DeHTTPManagerProcessingNotification = @"DeHTTPManager-Processing";
NSString *const DeHTTPManagerSuccessNotification = @"DeHTTPManager-Success";
NSString *const DeHTTPManagerFailedNotification = @"DeHTTPManager-Failed";

NSString *const DeHTTPManagerUserinfoSerializerDataKey = @"DeHTTPManager-SerializerData";
NSString *const DeHTTPManagerUserinfoDataKey = @"DeHTTPManager-Data";
NSString *const DeHTTPManagerUserinfoErrorKey = @"DeHTTPManager-Error";
NSString *const DeHTTPManagerUserinfoResponseKey = @"DeHTTPManager-Response";
NSString *const DeHTTPManagerUserinfoTaskKey = @"DeHTTPManager-Task";


dispatch_queue_t DeHTTPManagerProcessingQueue(){
    static dispatch_queue_t queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("DeHTTPManagerProcessingQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

static DeReachable *deReachable = nil;
DeReachable *DeHTTPManagerReachable() {
    if (!deReachable) {
        deReachable = [DeReachable reachable];
    }
    return deReachable;
}
void DeHTTPManagerReachableRelease(){
    [deReachable stop];
    deReachable = nil;
}

@implementation DeHTTPManager

+ (void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DeReachable *reachable = DeHTTPManagerReachable();
        [reachable start];
    });
}

+ (DeHTTPManager *)manager{
    DeHTTPManager *manager = [[self alloc] init];
    manager.responseSerializer = [DeHTTPResponseSerializer serializer];
    manager.requestSerializer = [DeHTTPRequestSerializer serializer];
    return manager;
}

- (instancetype)init{
    self = [super init];
    _network = [[DeHTTPNetwork alloc] init];
    _queue = [[NSOperationQueue alloc] init];
    _queue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    return self;
}

- (DeHTTPOperation *)requestWithBaseUrl:(NSURL *)url method:(NSString *)method paramters:(NSDictionary *)paramters successBlock:(DeHTTPDataTaskSuccessBlock)successBlock failedBlock:(DeHTTPDataTaskFailedBlock)failedBlock{

    DeReachable *reachable = DeHTTPManagerReachable();
    if ([reachable notReachable]) { //无网络错误
        if (failedBlock) {
            failedBlock(nil, nil, [DeHTTPNotReachableError error]);
        }
        return nil;
    }
    
    __weak __typeof(self) ws = self;
    NSError *requestSerializerError = nil;
    NSMutableURLRequest *request = [_requestSerializer requestWithBaseUrl:url method:method paramters:paramters error:&requestSerializerError];
    if (requestSerializerError) { //请求串行器错误
        if (failedBlock) {
            failedBlock(nil, nil, requestSerializerError);
        }
        return nil;
    }
    
    DeHTTPOperation *operation = [[DeHTTPOperation alloc] initWithRequest:request manager:self successBlock:^(DeHTTPDataTask *task, NSURLResponse *response, id data) {
        
        NSError *responseSerializerError = nil;
        id serializerData = [ws.responseSerializer responseObjectFromResponse:response
                                                                         data:data
                                                                        error:&responseSerializerError];
        if (responseSerializerError) { //响应串行器错误
            task.error = responseSerializerError;
            [ws postNotification:DeHTTPManagerFailedNotification task:task userInfo:task.userInfo];
            if (failedBlock) {
                failedBlock(task, response, responseSerializerError);
            }
        }else{
            task.serializerData = serializerData;
            [ws postNotification:DeHTTPManagerSuccessNotification task:task userInfo:task.userInfo];
            if (successBlock) {
                successBlock(task, response, serializerData);
            }
        }
    } failedBlock:^(DeHTTPDataTask *task, NSURLResponse *response, NSError *error) {
        
        [ws postNotification:DeHTTPManagerFailedNotification task:task userInfo:task.userInfo];
        if (failedBlock) { //其他错误
            failedBlock(task, response, error);
        }
    }];
    [_queue addOperation:operation];
    
    [self postNotification:DeHTTPManagerProcessingNotification task:operation.task userInfo:nil];
    return operation;
}

- (void)postNotification:(NSString *)name task:(DeHTTPDataTask *)task userInfo:(NSDictionary *)userInfo{
    dispatch_queue_t queue = _processQueue ?: DeHTTPManagerProcessingQueue();
    dispatch_async(queue, ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:task userInfo:userInfo];
    });
}
@end
