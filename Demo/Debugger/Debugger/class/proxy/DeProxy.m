//
//  DeProxy.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/5.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeProxy.h"

@implementation DeProxy

+ (instancetype)proxyWithTarget:(id)target{
    return [[DeProxy alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)selector{
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation{
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (BOOL)isProxy{
    return YES;
}

- (BOOL)isEqual:(id)object{
    return [_target isEqual:object];
}

- (NSUInteger)hash{
    return [_target hash];
}

- (Class)superclass{
    return [_target superclass];
}

- (Class)class{
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass{
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass{
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol{
    return [_target conformsToProtocol:aProtocol];
}

- (NSString *)description{
    return [_target description];
}

- (NSString *)debugDescription{
    return [_target debugDescription];
}

@end
