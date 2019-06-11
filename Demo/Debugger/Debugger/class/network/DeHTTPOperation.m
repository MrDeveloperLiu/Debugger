//
//  DeHttpOperation.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPOperation.h"
#import "DeHTTPManager.h"

@interface DeHTTPOperation ()
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, weak) DeHTTPManager *manager;
@end

@implementation DeHTTPOperation
@synthesize executing = _executing;
@synthesize finished = _finished;

- (void)dealloc{
    _lock = nil;
    _task = nil;
}

- (instancetype)initWithRequest:(NSURLRequest *)request manager:(DeHTTPManager *)manager successBlock:(DeHTTPDataTaskSuccessBlock)successBlock failedBlock:(DeHTTPDataTaskFailedBlock)failedBlock{
    self = [super init];
    _manager = manager;
    _task = [_manager.network dataTaskWithRequest:request success:successBlock failed:failedBlock];
    return self;
}

- (void)cancelNetwork{
    _task.canceled = YES;
    [_task.dataTask cancel];
    [_manager.network.session finishTasksAndInvalidate];
}

- (void)start{
    if (self.isCancelled || self.isExecuting) {
        return;
    }
    [_lock lock];
    [super start];
    self.executing = YES;
    [_lock unlock];
}

- (void)main{
    [_task.dataTask resume];
}

- (void)cancel{
    if (self.isFinished) {
        return;
    }
    [super cancel];    
    [_lock lock];
    self.executing = NO;
    self.finished = YES;
    [self cancelNetwork];
    [_lock unlock];
}

- (void)setExecuting:(BOOL)executing{
    NSString *key = NSStringFromSelector(@selector(isExecuting));
    [self willChangeValueForKey:key];
    _executing = executing;
    [self didChangeValueForKey:key];
}

- (void)setFinished:(BOOL)finished{
    NSString *key = NSStringFromSelector(@selector(isFinished));
    [self willChangeValueForKey:key];
    _finished = finished;
    [self didChangeValueForKey:key];
}
@end
