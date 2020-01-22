//
//  NSError+DeErrorMsg.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSError+DeErrorMsg.h"
#import "DeHTTPInvalidResponseError.h"
#import "DeHTTPNotReachableError.h"
#import "DeHTTPJsonInvalidParamterError.h"

@implementation NSError (DeErrorMsg)

- (NSString *)httpErrorMessage{
    if ([self isKindOfClass:[DeHTTPNotReachableError class]]) {
        return @"无网络链接, 请检查网络设置";
    }
    if ([self isKindOfClass:[DeHTTPInvalidResponseError class]]) {
        return [NSString stringWithFormat:@"响应错误: %@", self.userInfo[@"msg"]];
    }
    if ([self isKindOfClass:[DeHTTPJsonInvalidParamterError class]]) {
        return [NSString stringWithFormat:@"JSON格式错误: %@", self.userInfo[@"msg"]];
    }
    return [self description];
}

@end
