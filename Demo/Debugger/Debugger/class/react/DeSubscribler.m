//
//  DeSubscribler.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeSubscribler.h"
#import "DeReact.h"

@interface DeSubscribler ()
@property (nonatomic, copy) DeSubscriblerNextBlock next;
@property (nonatomic, copy) DeSubscriblerErrorBlock error;
@property (nonatomic, copy) DeSubscriblerCompletedBlock completed;
@end

@implementation DeSubscribler

- (void)dealloc{
    _next = nil;
    _error = nil;
    _completed = nil;
}

- (instancetype)initWithNext:(DeSubscriblerNextBlock)next error:(DeSubscriblerErrorBlock)error completed:(DeSubscriblerCompletedBlock)completed{
    self = [super init];
    _next = next;
    _error = error;
    _completed = completed;
    return self;
}

+ (instancetype)subscribleWithNext:(DeSubscriblerNextBlock)next error:(DeSubscriblerErrorBlock)error completed:(DeSubscriblerCompletedBlock)completed{
    return [[self alloc] initWithNext:next error:error completed:completed];
}

- (void)sendNext:(id)value{
    if (self.next) {
        self.next(value);
    }
}
- (void)sendError:(NSError *)error{
    if (self.error) {
        self.error(error);
    }
}
- (void)sendCompleted{
    if (self.completed) {
        self.completed();
    }
}
@end


@interface DeSignalSubscribler ()
@property (nonatomic, weak, readonly) DeSignal *signal;
@property (nonatomic, strong, readonly) DeSubscribler *innerSubscribler;
@property (nonatomic, strong, readonly) DeDispose *dispose;
@end

@implementation DeSignalSubscribler
- (instancetype)initWithSubscribler:(DeSubscribler *)subscribler signal:(DeSignal *)signal dispose:(DeDispose *)dispose{
    self = [super init];
    _innerSubscribler = subscribler;
    _signal = signal;
    _dispose = dispose;
    return self;
}
- (void)sendNext:(id)value{
    if (_dispose.isDisposed) {
        return;
    }
    [_innerSubscribler sendNext:value];
}
- (void)sendError:(NSError *)error{
    if (_dispose.isDisposed) {
        return;
    }
    [_innerSubscribler sendError:error];
}
- (void)sendCompleted{
    if (_dispose.isDisposed) {
        return;
    }
    [_innerSubscribler sendCompleted];
}
@end
