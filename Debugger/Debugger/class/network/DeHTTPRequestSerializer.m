//
//  DeHTTPRequestSerializer.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/6.
//  Copyright © 2019 liu. All rights reserved.
//


#import "DeHTTPRequestSerializer.h"
#import "Debugger.h"

@implementation DeHTTPRequestSerializer

+ (instancetype)serializer{
    DeHTTPRequestSerializer *serializer = [[self alloc] init];
    serializer.urlEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", @"DELETE", nil];
    [serializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:kHTTPContentType];
    serializer.timeout = 30;
    return serializer;
}

- (NSMutableURLRequest *)requestWithBaseUrl:(NSURL *)url method:(NSString *)method paramters:(id)paramters error:(NSError *__autoreleasing *)error{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //头域
    [self HTTPRequestSerializerSetHTTPField:request];
    if (method) {//方式
        request.HTTPMethod = method;
    }
    if (paramters) {
        NSArray *keyValuePairs = de_paramtersToPairs(nil, paramters);
        NSString *bodyString = de_urlEncodeStringWithKeyValuePairs(keyValuePairs);
        if ([_urlEncodingParametersInURI containsObject:[method uppercaseString]]) {
            [self _urlByAppendQuaryString:request quary:bodyString];
        }else{
            request.HTTPBody = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    request.timeoutInterval = self.timeout;
    return request;
}

- (void)_urlByAppendQuaryString:(NSMutableURLRequest *)request quary:(NSString *)quary{
    if (!quary) {
        return;
    }
    if (request.URL.query) {
        request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:@"&%@", quary]];
    }else{
        request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:@"?%@", quary]];
    }
}

- (NSMutableDictionary *)allHTTPHeaderFields{
    if (!_allHTTPHeaderFields) {
        _allHTTPHeaderFields = [NSMutableDictionary dictionary];
    }
    return _allHTTPHeaderFields;
}

@end

@implementation DeHTTPRequestSerializer (HTTPField)
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
    if (field) {
        self.allHTTPHeaderFields[field] = value;
    }
}

- (void)HTTPRequestSerializerSetHTTPField:(NSMutableURLRequest *)request{
    if (!self.allHTTPHeaderFields) {
        return;
    }
    NSMutableDictionary *allHeaderField = @{}.mutableCopy;
    if (request.allHTTPHeaderFields) {
        [allHeaderField addEntriesFromDictionary:request.allHTTPHeaderFields];
    }
    [self.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![allHeaderField objectForKey:key]) {
            [allHeaderField setObject:obj forKey:key];
        }
    }];
    request.allHTTPHeaderFields = allHeaderField;
}
@end


@implementation DeHTTPRequestParamterPairs
+ (instancetype)pairsWithKey:(NSString *)key value:(NSString *)value{
    return [[self alloc] initWithKey:key value:value];
}
- (instancetype)initWithKey:(NSString *)key value:(NSString *)value{
    self = [super init];
    self.key = key;
    self.value = value;
    return self;
}
- (void)setKey:(NSString *)key{
    _key = key;
}
- (void)setValue:(NSString *)value{
    _value = de_urlEncodeString(value);
}
- (NSString *)description{
    if (!_value && [_value isEqual:[NSNull null]]) {
        return [NSString stringWithFormat:@"%@=", _key];
    }
    return [NSString stringWithFormat:@"%@=%@", _key, _value];
}
@end

NSString * __de_paramtersDictKey(NSString *key, NSString *dictKey){
    if (key) {
        return [NSString stringWithFormat:@"%@[%@]", key, dictKey];
    }
    return dictKey;
}

NSString * __de_paramtersArrayKey(NSString *key){
    return [NSString stringWithFormat:@"%@[]", key];
}

NSArray * de_paramtersToPairs(NSString *key, id value){
    NSMutableArray *temp = [NSMutableArray array];
    if ([value isKindOfClass:[NSDictionary class]]) {
        [(NSDictionary *)value enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull dictKey, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [temp addObjectsFromArray:de_paramtersToPairs(__de_paramtersDictKey(key, dictKey), obj)];
        }];
    }else if ([value isKindOfClass:[NSArray class]]){
        [(NSArray *)value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [temp addObjectsFromArray:de_paramtersToPairs(__de_paramtersArrayKey(key), obj)];
        }];
    }else if ([value isKindOfClass:[NSSet class]]){
        [(NSSet *)value enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            [temp addObjectsFromArray:de_paramtersToPairs(key, obj)];
        }];
    }else{
        [temp addObject:[DeHTTPRequestParamterPairs pairsWithKey:key value:value]];
    }
    return temp;
}

NSString * de_urlEncodeStringWithKeyValuePairs(NSArray *pairs){
    if ([pairs isKindOfClass:[NSArray class]]) {
        NSMutableArray *stringPairs = [NSMutableArray array];
        [pairs enumerateObjectsUsingBlock:^(DeHTTPRequestParamterPairs *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [stringPairs addObject:obj.description];
        }];
        return [stringPairs componentsJoinedByString:@"&"];
    }
    return nil;
}

NSString * de_urlEncodeString(NSString *string){
    if (!string) return string;
    static NSString *const kCharactersToEncode = @":#[]@!$&'()*+,;=";
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:kCharactersToEncode];
    NSString *encoded = [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    return encoded;
}


@implementation DeHTTPJsonRequestSerializer
+ (instancetype)serializer{
    DeHTTPJsonRequestSerializer *serializer = [[self alloc] init];
    [serializer setValue:@"application/json" forHTTPHeaderField:kHTTPContentType];
    serializer.writingOptions = 0;
    serializer.timeout = 30;
    return serializer;
}

- (NSMutableURLRequest *)requestWithBaseUrl:(NSURL *)url method:(NSString *)method paramters:(id)paramters error:(NSError *__autoreleasing *)error{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //头域
    [self HTTPRequestSerializerSetHTTPField:request];
    if (method) {//方式
        request.HTTPMethod = method;
    }
    if (paramters) {
        if ([NSJSONSerialization isValidJSONObject:paramters]) {
            request.HTTPBody = [NSJSONSerialization dataWithJSONObject:paramters options:self.writingOptions error:error];
        }else{
            *error = [DeHTTPJsonInvalidParamterError errorWithParamters:paramters];
        }
    }
    request.timeoutInterval = self.timeout;
    return request;
}

@end
