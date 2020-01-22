//
//  DeScheduler.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, DeSchedulerQos) {
    DeSchedulerQosDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    DeSchedulerQosHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    DeSchedulerQosLow = DISPATCH_QUEUE_PRIORITY_LOW,
    DeSchedulerQosBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
};

@class DeDispose;
@interface DeScheduler : NSObject

@property (nonatomic, readonly) dispatch_queue_t queue;
@property (nonatomic, copy, readonly) NSString *name;

+ (DeScheduler *)mainthreadScheduler;
+ (DeScheduler *)defaultScheduler;//DeSchedulerQosBackground

- (instancetype)initWithName:(NSString *)name queue:(dispatch_queue_t)queue;

- (DeDispose *)scheduleAsync:(dispatch_block_t)block;
- (DeDispose *)scheduleSync:(dispatch_block_t)block;
- (DeDispose *)scheduleAfter:(NSTimeInterval)inteval block:(dispatch_block_t)block;
@end

