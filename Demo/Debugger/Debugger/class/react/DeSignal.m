//
//  DeSignal.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeSignal.h"
#import "DeReact.h"

@interface DeSignal ()
@property (nonatomic, copy) DeSignalBlock signalBlock;
@end

@implementation DeSignal

- (void)dealloc{
    NSLog(@"%s", __func__);
}

+ (DeSignal *)createSignal:(DeSignalBlock)signal{
    DeSignal *s = [[self alloc] init];
    s.signalBlock = signal;
    return s;
}

@end


@implementation DeSignal (DeSubscribler)
- (DeDispose *)subscribe:(id<DeSubscribler>)subscriber{
    DeComboneDispose *disponse = [DeComboneDispose comboneDispose];
    subscriber = [[DeSignalSubscribler alloc] initWithSubscribler:subscriber
                                                           signal:self
                                                          dispose:disponse];
    if (self.signalBlock) {
        DeDispose *scheduleDispose = [[DeScheduler defaultScheduler] scheduleSync:^{
            DeDispose *signalDispose = self.signalBlock(subscriber);
            [disponse addDispose:signalDispose];
        }];
        [disponse addDispose:scheduleDispose];
    }
    return disponse;
}

- (DeDispose *)subscribeNext:(DeSubscriblerNextBlock)next{
    DeSubscribler *subscriber = [DeSubscribler subscribleWithNext:next error:nil completed:nil];
    return [self subscribe:subscriber];
}
- (DeDispose *)subscribeNext:(DeSubscriblerNextBlock)next completed:(DeSubscriblerCompletedBlock)completed{
    DeSubscribler *subscriber = [DeSubscribler subscribleWithNext:next error:nil completed:completed];
    return [self subscribe:subscriber];
}
- (DeDispose *)subscribeNext:(DeSubscriblerNextBlock)next error:(DeSubscriblerErrorBlock)error completed:(DeSubscriblerCompletedBlock)completed{
    DeSubscribler *subscriber = [DeSubscribler subscribleWithNext:next error:error completed:completed];
    return [self subscribe:subscriber];
}
@end
