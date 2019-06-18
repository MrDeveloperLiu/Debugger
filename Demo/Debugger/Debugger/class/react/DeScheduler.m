//
//  DeScheduler.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeScheduler.h"
#import "DeReact.h"

#define DeSchedulerDeafaultName @"DeSchedulerDeafault"

@interface DeScheduler ()
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, copy) NSString *name;
@end

@implementation DeScheduler

- (instancetype)initWithName:(NSString *)name queue:(dispatch_queue_t)queue{
    self = [super init];
    _queue = queue;
    _name = name;
    if (!queue) {
        _queue = dispatch_get_global_queue(DeSchedulerQosBackground, 0);
    }
    if (!name) {
        const char *queueLabel = dispatch_queue_get_label(_queue);
        if (queueLabel != NULL) {
            _name = [NSString stringWithUTF8String:queueLabel];
        }else{
            _name = DeSchedulerDeafaultName;
        }
    }
    return self;
}

+ (DeScheduler *)mainthreadScheduler{
    static DeScheduler *scheduler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scheduler = [[self alloc] initWithName:nil queue:dispatch_get_main_queue()];
    });
    return scheduler;
}

+ (DeScheduler *)defaultScheduler{
    static DeScheduler *scheduler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scheduler = [[self alloc] initWithName:nil queue:nil];
    });
    return scheduler;
}


- (DeDispose *)scheduleAsync:(dispatch_block_t)block{
    NSParameterAssert(block);
    DeFlagDispose *dispose = [[DeFlagDispose alloc] initWithBlock:nil];
    dispatch_async(self.queue, ^{
        if (dispose.isDisposed) {
            return;
        }
        @autoreleasepool {
            block();
        }
    });
    return dispose;
}

- (DeDispose *)scheduleSync:(dispatch_block_t)block{
    NSParameterAssert(block);
    NSAssert(self.queue != dispatch_get_main_queue(), @"scheduleSync: main_queue leak d deaded lock!");
    DeFlagDispose *dispose = [[DeFlagDispose alloc] initWithBlock:nil];
    dispatch_sync(self.queue, ^{
        if (dispose.isDisposed) {
            return;
        }
        @autoreleasepool {
            block();
        }
    });
    return dispose;
}

- (DeDispose *)scheduleAfter:(NSTimeInterval)inteval block:(dispatch_block_t)block{
    NSParameterAssert(block);
    DeFlagDispose *dispose = [[DeFlagDispose alloc] initWithBlock:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(inteval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (dispose.isDisposed) {
            return ;
        }
        @autoreleasepool {
            block();
        }
    });
    return dispose;
}
@end
