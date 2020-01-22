//
//  DeDispose.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeDispose.h"
#import "DeReact.h"

@interface DeDispose (){
@protected
    dispatch_block_t _block;
}
@property (nonatomic, copy) dispatch_block_t block;
@end

@implementation DeDispose
- (void)dealloc{

}

- (instancetype)initWithBlock:(dispatch_block_t)block{
    self = [super init];
    self.block = block;
    return self;
}

+ (instancetype)disposeWithBlock:(dispatch_block_t)block{
    return [[self alloc] initWithBlock:block];
}

- (BOOL)isDisposed{
    return !_block;
}

- (void)setDisposed:(BOOL)disposed{
    if (disposed) {
        _block = nil;
    }
}

- (void)dispose{
    if (_block) {
        _block();
        _block = nil;
    }
}
@end


@interface DeFlagDispose ()
@property (nonatomic, assign, getter=isDisposed) BOOL disposed;
@end

@implementation DeFlagDispose
@synthesize disposed = _disposed;

- (instancetype)initWithBlock:(dispatch_block_t)block{
    self = [super initWithBlock:block];
    _disposed = NO;
    return self;
}

- (BOOL)isDisposed{
    return _disposed;
}

- (void)dispose{
    if (!_disposed) {
        [super dispose];
    }
    _disposed = YES;
}
@end


@interface DeComboneDispose ()
@property (nonatomic, strong) NSMutableArray *disponses;
@end

@implementation DeComboneDispose

+ (DeComboneDispose *)comboneDispose{
    return [[self alloc] initWithBlock:nil];
}

- (BOOL)isDisposed{
    return _disponses.count <= 0;
}

- (void)addDispose:(DeDispose *)dispose{
    if (![_disponses containsObject:dispose]) {
        [self.disponses addObject:dispose];
    }
}

- (void)removeDispose:(DeDispose *)dispose{
    if ([_disponses containsObject:dispose]) {
        [self.disponses removeObject:dispose];
    }
}

- (NSMutableArray *)disponses{
    if (!_disponses) {
        _disponses = [NSMutableArray arrayWithCapacity:1];
    }
    return _disponses;
}

- (void)dispose{
    [_disponses enumerateObjectsUsingBlock:^(DeDispose *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj dispose];
    }];
    _disponses = nil;
    [super dispose];
}
@end


