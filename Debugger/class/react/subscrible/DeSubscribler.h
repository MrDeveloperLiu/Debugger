//
//  DeSubscribler.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeSubscribler <NSObject>
- (void)sendNext:(id)value;
- (void)sendError:(NSError *)error;
- (void)sendCompleted;
@end

typedef void (^DeSubscriblerNextBlock)(id x);
typedef void (^DeSubscriblerErrorBlock)(NSError *error);
typedef void (^DeSubscriblerCompletedBlock)(void);

@class DeSignal, DeDispose;

@interface DeSubscribler : NSObject <DeSubscribler>

- (instancetype)initWithNext:(DeSubscriblerNextBlock)next error:(DeSubscriblerErrorBlock)error completed:(DeSubscriblerCompletedBlock)completed;
+ (instancetype)subscribleWithNext:(DeSubscriblerNextBlock)next error:(DeSubscriblerErrorBlock)error completed:(DeSubscriblerCompletedBlock)completed;

@end

@interface DeSignalSubscribler : DeSubscribler
- (instancetype)initWithSubscribler:(DeSubscribler *)subscribler signal:(DeSignal *)signal dispose:(DeDispose *)dispose;
@end

