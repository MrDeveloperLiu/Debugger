//
//  DeHTTPNotReachableError.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPNotReachableError.h"

@implementation DeHTTPNotReachableError
+ (instancetype)error{
    return [DeHTTPNotReachableError errorWithDomain:@"DeHTTPNotReachableErrorDomain"
                                               code:-1
                                           userInfo:@{@"msg" : @"network not reachable!"}];
    
}
@end
