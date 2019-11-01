//
//  DeJavaScriptCore.h
//  Demo
//
//  Created by 刘杨 on 2019/7/9.
//  Copyright © 2019 liu. All rights reserved.
//
#import "JSContext+DeJSCore.h"
#import "JSValue+DeJSCore.h"
#import "DeLogger.h"

typedef void (^DeJavaScriptCoreExceptionBlock)(JSValue *exception);

@interface DeJavaScriptCore : NSObject

@property (nonatomic, strong, readonly) JSContext *jsContext;
@property (nonatomic, copy) DeJavaScriptCoreExceptionBlock exceptionHandler;
- (instancetype)initWithName:(NSString *)name;

@end


