//
//  DeHTTPDataTask.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DeHTTPDataTask;
typedef void(^DeHTTPDataTaskSuccessBlock)(DeHTTPDataTask *task, NSURLResponse *response, id data);
typedef void(^DeHTTPDataTaskFailedBlock)(DeHTTPDataTask *task, NSURLResponse *response, NSError *error);

@interface DeHTTPDataTask : NSObject <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (nonatomic, strong, readonly) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong, readonly) NSURLResponse *response;
@property (nonatomic, strong, readonly) NSMutableData *data;

@property (nonatomic, assign, getter=isCanceled) BOOL canceled;

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) id serializerData;

@property (nonatomic, strong, readonly) NSDictionary *userInfo;

@property (nonatomic, copy, readonly) DeHTTPDataTaskSuccessBlock successBlock;
@property (nonatomic, copy, readonly) DeHTTPDataTaskFailedBlock failedBlock;

- (instancetype)initWithDataTask:(NSURLSessionDataTask *)dataTask successBlock:(DeHTTPDataTaskSuccessBlock)successBlock failedBlock:(DeHTTPDataTaskFailedBlock)failedBlock;
@end


