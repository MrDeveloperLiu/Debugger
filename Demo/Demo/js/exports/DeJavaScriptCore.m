//
//  DeJavaScriptCore.m
//  Demo
//
//  Created by 刘杨 on 2019/7/9.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeJavaScriptCore.h"

@interface DeJavaScriptCore ()
@property (nonatomic, strong) JSContext *jsContext;
@end

@implementation DeJavaScriptCore

- (instancetype)initWithName:(NSString *)name{
    self = [super init];
    self.jsContext.name = name;    
    return self;
}

- (instancetype)init{
    return [self initWithName:@"com.de.default"];
}

- (JSContext *)jsContext{
    if (!_jsContext) {
        _jsContext = [[JSContext alloc] init];
        __weak __typeof(self) ws = self;
        [_jsContext setExceptionHandler:^(JSContext *context, JSValue *exception) {
            [ws exception:exception];
        }];
    }
    return _jsContext;
}

- (void)exception:(JSValue *)exception{
    if (_exceptionHandler) {
        _exceptionHandler(exception);
    }else{
        NSLog(@"[DeJSCtx:%@]->exception: %@", _jsContext.name, exception);
    }
}
@end
