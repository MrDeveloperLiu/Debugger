//
//  DeHTTPNetwork.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeHTTPDataTask.h"

typedef void (^DeHTTPNetworkRedirectCompleteHandler)(NSURLRequest *request);
typedef void (^DeHTTPNetworkRedirectBlock) (NSURLRequest *request, NSURLResponse *response, DeHTTPNetworkRedirectCompleteHandler handler);

@interface DeHTTPNetwork : NSObject

@property (nonatomic, copy) DeHTTPNetworkRedirectBlock redirectBlock;
@property (nonatomic, strong, readonly) NSMutableDictionary *tasks;
@property (nonatomic, strong, readonly) NSOperationQueue *delegateQueue;
@property (nonatomic, strong, readonly) NSURLSession *session;

- (DeHTTPDataTask *)dataTaskWithRequest:(NSURLRequest *)request success:(DeHTTPDataTaskSuccessBlock)success failed:(DeHTTPDataTaskFailedBlock)failed;
- (void)cancel;
@end


