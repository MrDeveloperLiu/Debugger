//
//  DeHTTPRequestSerializer.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHTTPContentType            @"Content-Type"
#define kHTTPAcceptType             @"Accept"
#define kHTTPUserAgent              @"User-Agent"
#define kHTTPContentEncoding        @"Content-Encoding"

#define kHTTPMethodGET      @"GET"
#define kHTTPMethodPOST     @"POST"

@interface DeHTTPRequestSerializer : NSObject

+ (instancetype)serializer;

@property (nonatomic, strong) NSSet *urlEncodingParametersInURI;
@property (nonatomic, strong) NSMutableDictionary *allHTTPHeaderFields;
@property (nonatomic, assign) NSTimeInterval timeout;

- (NSMutableURLRequest *)requestWithBaseUrl:(NSURL *)url method:(NSString *)method paramters:(NSDictionary *)paramters error:(NSError **)error;
@end

@interface DeHTTPRequestSerializer (HTTPField)
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
- (void)HTTPRequestSerializerSetHTTPField:(NSMutableURLRequest *)request;
@end

@interface DeHTTPRequestParamterPairs : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;
+ (instancetype)pairsWithKey:(NSString *)key value:(NSString *)value;
@end

FOUNDATION_EXPORT NSArray * de_paramtersToPairs(NSString *key, id value);
FOUNDATION_EXPORT NSString * de_urlEncodeStringWithKeyValuePairs(NSArray *pairs);
FOUNDATION_EXPORT NSString * de_urlEncodeString(NSString *string);


@interface DeHTTPJsonRequestSerializer : DeHTTPRequestSerializer
@property (nonatomic, assign) NSJSONWritingOptions writingOptions;
@end
