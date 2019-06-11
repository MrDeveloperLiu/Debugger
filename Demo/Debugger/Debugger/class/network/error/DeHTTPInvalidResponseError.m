//
//  DeHTTPInvalidResponseError.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPInvalidResponseError.h"

@implementation DeHTTPInvalidResponseError
+ (instancetype)errorWithResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
    NSString *errorMsg = [NSString stringWithFormat:@"ERROR: unsupport response MIMEType: %@!", httpResp.MIMEType];
    NSMutableDictionary *userInfo = @{}.mutableCopy;
    userInfo[@"msg"] = errorMsg;
    userInfo[@"code"] = @(httpResp.statusCode);
    userInfo[@"allHeaderFields"] = [httpResp.allHeaderFields description];
    userInfo[@"localizedString"] = [NSHTTPURLResponse localizedStringForStatusCode:httpResp.statusCode];
    return [DeHTTPInvalidResponseError errorWithDomain:@"DeHTTPInvalidResponseErrorDomain"
                                               code:-1
                                           userInfo:userInfo];
    
}

@end
