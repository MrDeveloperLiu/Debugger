//
//  DeHttpOperation.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeHTTPNetwork.h"

@class DeHTTPManager;
@interface DeHTTPOperation : NSOperation

@property (nonatomic, assign, getter=isExecuting) BOOL executing;
@property (nonatomic, assign, getter=isFinished) BOOL finished;

@property (nonatomic, strong, readonly) DeHTTPDataTask *task;

- (instancetype)initWithRequest:(NSURLRequest *)request manager:(DeHTTPManager *)manager successBlock:(DeHTTPDataTaskSuccessBlock)successBlock failedBlock:(DeHTTPDataTaskFailedBlock)failedBlock;
@end


