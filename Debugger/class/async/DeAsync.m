//
//  DeAsync.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/26.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeAsync.h"

@interface DeAsync ()
@property (nonatomic, strong) DeAsyncGroup *group;
@property (nonatomic) dispatch_queue_t queue;
@end

@implementation DeAsync

+ (instancetype)serial{
    dispatch_queue_t queue = dispatch_queue_create("DeAsync.queue.serial", DISPATCH_QUEUE_SERIAL);
    return [[self alloc] initWithQueue:queue];
}

+ (instancetype)concurrent{
    dispatch_queue_t queue = dispatch_queue_create("DeAsync.queue.concurrent", DISPATCH_QUEUE_CONCURRENT);
    return [[self alloc] initWithQueue:queue];
}

- (instancetype)initWithQueue:(dispatch_queue_t)queue{
    NSParameterAssert(queue);
    self = [super init];
    _queue = queue;
    return self;
}

- (instancetype)init{
    return nil;
}

- (DeAsyncGroup *)group{
    if (!_group) {
        _group = [[DeAsyncGroup alloc] init];
    }
    return _group;
}

- (DeAsync *)then:(DeAsyncBlock)then{
    NSParameterAssert(then);
    [self.group enter];
    [self.group async:_queue task:^dispatch_block_t(DeAsyncGroup *g) {
        return ^(void){
            if (self.invalid) {
                [g leave];
            }else{
                then(self);
            }
        };
    }];
    return self;
}

- (DeAsync *)finaly:(DeAsyncBlock)finaly{
    NSParameterAssert(finaly);
    [self.group notify:dispatch_get_main_queue() task:^dispatch_block_t(DeAsyncGroup *g) {
        return ^(void){
            finaly(self);
        };
    }];
    return self;
}

- (DeAsync * (^)(DeAsyncBlock))then{
    return ^DeAsync *(DeAsyncBlock thenBlock) {
        return [self then:thenBlock];
    };
}

- (DeAsync * (^)(DeAsyncBlock))finaly{
    return ^DeAsync *(DeAsyncBlock finalyBlock) {
        return [self finaly:finalyBlock];
    };
}
@end
