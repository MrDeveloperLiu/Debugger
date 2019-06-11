//
//  DeHTTPManager.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeHTTPOperation.h"
#import "DeHTTPResponseSerializer.h"
#import "DeHTTPRequestSerializer.h"
#import "DeReachable.h"

FOUNDATION_EXPORT NSString *const DeHTTPManagerProcessingNotification;
FOUNDATION_EXPORT NSString *const DeHTTPManagerSuccessNotification;
FOUNDATION_EXPORT NSString *const DeHTTPManagerFailedNotification;

FOUNDATION_EXPORT NSString *const DeHTTPManagerUserinfoSerializerDataKey;
FOUNDATION_EXPORT NSString *const DeHTTPManagerUserinfoDataKey;
FOUNDATION_EXPORT NSString *const DeHTTPManagerUserinfoErrorKey;
FOUNDATION_EXPORT NSString *const DeHTTPManagerUserinfoResponseKey;
FOUNDATION_EXPORT NSString *const DeHTTPManagerUserinfoTaskKey;


FOUNDATION_EXPORT DeReachable *DeHTTPManagerReachable(void);
FOUNDATION_EXPORT void DeHTTPManagerReachableRelease(void);

@interface DeHTTPManager : NSObject

@property (nonatomic, strong, readonly) DeHTTPNetwork *network;
@property (nonatomic, strong, readonly) NSOperationQueue *queue;
@property (nonatomic, strong) dispatch_queue_t processQueue;

@property (nonatomic, strong) DeHTTPResponseSerializer *responseSerializer;
@property (nonatomic, strong) DeHTTPRequestSerializer *requestSerializer;

+ (DeHTTPManager *)manager;

- (DeHTTPOperation *)requestWithBaseUrl:(NSURL *)url method:(NSString *)method paramters:(NSDictionary *)paramters successBlock:(DeHTTPDataTaskSuccessBlock)successBlock failedBlock:(DeHTTPDataTaskFailedBlock)failedBlock;
@end

