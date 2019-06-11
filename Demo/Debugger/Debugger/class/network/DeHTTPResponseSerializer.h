//
//  DeHTTPResponseSerializer.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeHTTPInvalidResponseError.h"


@interface DeHTTPResponseSerializer : NSObject

@property (nonatomic, strong) NSSet *acceptContentTypes;
@property (nonatomic, assign) NSJSONReadingOptions readingOptions;

+ (DeHTTPResponseSerializer *)serializer;

- (id)responseObjectFromResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError **)error;
@end

