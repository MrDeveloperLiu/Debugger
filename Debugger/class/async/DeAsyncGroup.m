//
//  DeAsyncGroup.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/26.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeAsyncGroup.h"

@implementation DeAsyncGroup

- (instancetype)init{
    self = [super init];
    _group = dispatch_group_create();
    return self;
}

- (void)enter{
    dispatch_group_enter(_group);
}

- (void)leave{
    dispatch_group_leave(_group);
}

- (long)wait:(NSTimeInterval)interval{
    NSAssert(interval > 0, @"-wait: interval must longer than 0");
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * interval);
    return dispatch_group_wait(_group, timeout);
}

- (void)async:(DeAsyncGroupTaskBlock)task{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self async:queue task:task];
}

- (void)async:(dispatch_queue_t)queue task:(DeAsyncGroupTaskBlock)task{
    NSParameterAssert(task);
    __weak __typeof(self) ws = self;
    dispatch_group_async(_group, queue, ^{
        dispatch_block_t block = task(ws);
        block();
    });
}

- (void)notify:(DeAsyncGroupTaskBlock)task{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    [self notify:queue task:task];
}

- (void)notify:(dispatch_queue_t)queue task:(DeAsyncGroupTaskBlock)task{
    NSParameterAssert(task);
    __weak __typeof(self) ws = self;
    dispatch_group_notify(_group, queue, ^{
        dispatch_block_t block = task(ws);
        block();
    });
}
@end
