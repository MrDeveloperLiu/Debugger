//
//  NetComponents.h
//  Demo
//
//  Created by 刘杨 on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NetOperation <NSObject>
- (BOOL)isExecuting;
- (BOOL)isFinished;
- (void)cancel;
@end

@protocol NetTask <NSObject>
@property (nonatomic, assign, getter=isCanceled) BOOL canceled;
@end

typedef void(^NetComponentsSuccessBlock)(id<NetTask> task, NSURLResponse *response, id data);
typedef void(^NetComponentsFailedBlock)(id<NetTask> task, NSURLResponse *response, NSError *error);

@protocol NetComponents <NSObject>
- (id<NetOperation>)requestWithBaseUrl:(NSURL *)url
                                method:(NSString *)method
                             paramters:(id)paramters
                          successBlock:(NetComponentsSuccessBlock)successBlock
                           failedBlock:(NetComponentsFailedBlock)failedBlock;

- (id<NetOperation>)requestWithRequest:(NSURLRequest *)request
                           successBlock:(NetComponentsSuccessBlock)successBlock
                            failedBlock:(NetComponentsFailedBlock)failedBlock;

@end


