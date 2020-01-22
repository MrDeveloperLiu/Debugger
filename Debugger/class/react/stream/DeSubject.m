//
//  DeSubject.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeSubject.h"
#import "DeReact.h"

@interface DeSubject ()
@property (nonatomic, strong) DeComboneDispose *dispose;
@property (nonatomic, strong) NSMutableArray *subsriblers;
@end

@implementation DeSubject

+ (instancetype)subject{
    return [[self alloc] init];
}

- (instancetype)init{
    self = [super init];
    _dispose = [DeComboneDispose comboneDispose];
    _subsriblers = [NSMutableArray arrayWithCapacity:1];
    return self;
}

- (void)enumerateObjectsUsingBlock:(void (^)(id<DeSubscribler> subscirbler, NSUInteger idx, BOOL * _Nonnull stop))block{
    NSParameterAssert(block);
    [_subsriblers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block(obj, idx, stop);
    }];
}

- (void)sendNext:(id)value{
    [self enumerateObjectsUsingBlock:^(id<DeSubscribler> subscirbler, NSUInteger idx, BOOL * _Nonnull stop) {
        [subscirbler sendNext:value];
    }];
}

- (void)sendError:(NSError *)error{
    [self.dispose dispose];
    
    [self enumerateObjectsUsingBlock:^(id<DeSubscribler> subscirbler, NSUInteger idx, BOOL * _Nonnull stop) {
        [subscirbler sendError:error];
    }];
}

- (void)sendCompleted{
    [self.dispose dispose];
    
    [self enumerateObjectsUsingBlock:^(id<DeSubscribler> subscirbler, NSUInteger idx, BOOL * _Nonnull stop) {
        [subscirbler sendCompleted];
    }];
}

- (DeDispose *)subscribe:(id<DeSubscribler>)subscriber{
    NSCParameterAssert(subscriber);
    DeComboneDispose *dispose = [DeComboneDispose comboneDispose];
    
    NSMutableArray *subscribers = self.subsriblers;
    [subscribers addObject:subscriber];
    
    [dispose addDispose:[DeDispose disposeWithBlock:^{
        
        NSInteger index = [subscribers indexOfObject:subscriber];
        if (index != NSNotFound) {
            [subscribers removeObjectAtIndex:index];
        }
    }]];
    return dispose;
}


@end
