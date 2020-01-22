//
//  DeHTTPInvalidResponseError.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 响应错误
 */
@interface DeHTTPInvalidResponseError : NSError
+ (instancetype)errorWithResponse:(NSURLResponse *)response;
@end

