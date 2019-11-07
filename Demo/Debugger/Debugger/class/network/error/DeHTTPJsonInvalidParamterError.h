//
//  DeHTTPJsonInvalidParamterError.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 不是Json格式错误
 */
@interface DeHTTPJsonInvalidParamterError : NSError
+ (instancetype)errorWithParamters:(id)paramters;
@end

