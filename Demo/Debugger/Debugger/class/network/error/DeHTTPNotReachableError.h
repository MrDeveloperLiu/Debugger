//
//  DeHTTPNotReachableError.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 无网络链接错误
 */
@interface DeHTTPNotReachableError : NSError
+ (instancetype)error;
@end

