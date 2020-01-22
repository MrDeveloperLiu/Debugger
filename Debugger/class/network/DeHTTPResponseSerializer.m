//
//  DeHTTPResponseSerializer.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeHTTPResponseSerializer.h"


@implementation DeHTTPResponseSerializer

+ (DeHTTPResponseSerializer *)serializer{
    DeHTTPResponseSerializer *serializer = [[self alloc] init];
    serializer.acceptContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    serializer.readingOptions = 0;
    return serializer;
}

- (id)responseObjectFromResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError **)error{
    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
    if (![self.acceptContentTypes containsObject:httpResp.MIMEType]) {
        *error = [DeHTTPInvalidResponseError errorWithResponse:response];
        return nil;
    }
    //json parser
    return [NSJSONSerialization JSONObjectWithData:data options:self.readingOptions error:error];
}
@end
