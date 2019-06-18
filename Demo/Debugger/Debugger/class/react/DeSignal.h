//
//  DeSignal.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeStream.h"
#import "DeSubscribler.h"

@class DeDispose;

typedef DeDispose * (^DeSignalBlock)(id<DeSubscribler> subscribler);

@interface DeSignal : DeStream
+ (DeSignal *)createSignal:(DeSignalBlock)signal;
@end

@interface DeSignal (DeSubscribler)
- (DeDispose *)subscribe:(id<DeSubscribler>)subscriber;
- (DeDispose *)subscribeNext:(DeSubscriblerNextBlock)next;
- (DeDispose *)subscribeNext:(DeSubscriblerNextBlock)next completed:(DeSubscriblerCompletedBlock)completed;
- (DeDispose *)subscribeNext:(DeSubscriblerNextBlock)next error:(DeSubscriblerErrorBlock)error completed:(DeSubscriblerCompletedBlock)completed;
@end
