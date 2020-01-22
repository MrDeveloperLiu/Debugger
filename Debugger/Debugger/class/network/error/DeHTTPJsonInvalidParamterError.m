//
//  DeHTTPJsonInvalidParamterError.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPJsonInvalidParamterError.h"

@implementation DeHTTPJsonInvalidParamterError
+ (instancetype)errorWithParamters:(id)paramters{
    NSString *errorMsg = [NSString stringWithFormat:@"(paramters: %@) it is not a json object!", paramters];
    return [DeHTTPJsonInvalidParamterError errorWithDomain:@"DeHTTPJsonInvalidParamterErrorDomain"
                                               code:-1
                                           userInfo:@{@"msg" : errorMsg}];
    
}
@end
