//
//  DeAsyncGroup.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/26.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DeAsyncGroup;
typedef dispatch_block_t (^DeAsyncGroupTaskBlock)(DeAsyncGroup *g);

@interface DeAsyncGroup : NSObject

@property (nonatomic, strong, readonly) dispatch_group_t group;

- (void)enter;
- (void)leave;
- (long)wait:(NSTimeInterval)interval;
- (void)async:(DeAsyncGroupTaskBlock)task;
- (void)async:(dispatch_queue_t)queue task:(DeAsyncGroupTaskBlock)task;
- (void)notify:(DeAsyncGroupTaskBlock)task;
- (void)notify:(dispatch_queue_t)queue task:(DeAsyncGroupTaskBlock)task;
@end

