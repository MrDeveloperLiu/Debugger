//
//  DeDispose.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DeDispose : NSObject
@property (nonatomic, assign, getter=isDisposed) BOOL disposed;
- (instancetype)initWithBlock:(dispatch_block_t)block;
+ (instancetype)disposeWithBlock:(dispatch_block_t)block;
- (void)dispose;
@end

@interface DeFlagDispose : DeDispose
@end

@interface DeComboneDispose : DeDispose
+ (DeComboneDispose *)comboneDispose;
@property (nonatomic, strong, readonly) NSMutableArray *disponses;
- (void)addDispose:(DeDispose *)dispose;
- (void)removeDispose:(DeDispose *)dispose;
@end

