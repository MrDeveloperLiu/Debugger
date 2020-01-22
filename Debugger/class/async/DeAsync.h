//
//  DeAsync.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/26.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeAsyncGroup.h"

@class DeAsync;
typedef void (^DeAsyncBlock)(DeAsync *async);

@interface DeAsync : NSObject
@property (nonatomic, strong) id userinfo;
@property (nonatomic, strong, readonly) DeAsyncGroup *group;
@property (nonatomic, assign) BOOL invalid;

+ (instancetype)serial;
+ (instancetype)concurrent;
- (instancetype)initWithQueue:(dispatch_queue_t)queue;

- (DeAsync *)then:(DeAsyncBlock)then;
- (DeAsync *)finaly:(DeAsyncBlock)finaly;

- (DeAsync * (^)(DeAsyncBlock))then;
- (DeAsync * (^)(DeAsyncBlock))finaly;
@end

