//
//  JSValue+Call.m
//  Demo
//
//  Created by 刘杨 on 2019/7/10.
//  Copyright © 2019 liu. All rights reserved.
//

#import "JSValue+DeJSCore.h"

@implementation JSValue (DeJSCore)
- (JSValue *)callVoid{
    return [self call:nil];
}

- (JSValue *)call:(NSArray *)arguments{
    if ([self isUndefined]) {
        return nil;
    }
    return [self callWithArguments:arguments];
}

- (JSValue *)instance:(NSString *)name{
    NSParameterAssert(name);
    return self[name];
}

- (JSValue *)function:(NSString *)name{
    NSParameterAssert(name);
    return self[name];
}

- (JSValue *)callInstanceFunction:(NSString *)function{
    NSParameterAssert(function);
    return [[self function:function] callVoid];
}

- (JSValue *)callInstanceFunction:(NSString *)function arguments:(NSArray *)arguments{
    NSParameterAssert(function);
    return [[self function:function] call:arguments];
}
@end
