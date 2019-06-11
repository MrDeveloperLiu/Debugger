//
//  DeHTTPNetwork.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeHTTPDataTask.h"

@interface DeHTTPNetwork : NSObject

@property (nonatomic, strong, readonly) NSMutableDictionary *tasks;
@property (nonatomic, strong, readonly) NSOperationQueue *delegateQueue;
@property (nonatomic, strong, readonly) NSURLSession *session;

- (DeHTTPDataTask *)dataTaskWithRequest:(NSURLRequest *)request success:(DeHTTPDataTaskSuccessBlock)success failed:(DeHTTPDataTaskFailedBlock)failed;
- (void)cancel;
@end


