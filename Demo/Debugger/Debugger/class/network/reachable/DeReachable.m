//
//  DeReachable.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeReachable.h"

#import <netinet/in.h>
#import <netinet6/in6.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>

NSString * DeReachableChangedNotification = @"DeReachableChangedNotification";
NSString * DeReachableChangedUserInfoKey = @"state";

DeReachableState DeReachabilityStatusForFlags(SCNetworkReachabilityFlags flags) {
    BOOL isReachable = ((flags & kSCNetworkReachabilityFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkReachabilityFlagsConnectionRequired) != 0);
    BOOL canConnectionAutomatically = (((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) || ((flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0));
    BOOL canConnectWithoutUserInteraction = (canConnectionAutomatically && (flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0);
    BOOL isNetworkReachable = (isReachable && (!needsConnection || canConnectWithoutUserInteraction));
    
    DeReachableState state = DeReachableStateNotReachable;
    if (isNetworkReachable == NO) {
        state = DeReachableStateNotReachable;
    }else if ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0) {
        state = DeReachableStateWWAN;
    }else {
        state = DeReachableStateWIFI;
    }
    return state;
}

const void * DeReachableRetainCallBack(const void *info){
    return Block_copy(info);
}

void DeReachableReleaseCallBack(const void *info){
    if (info) {
        Block_release(info);
    }
}

void DeReachableCallBack(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *__nullable info){
    DeReachableStateBlock callback = (__bridge DeReachableStateBlock)info;
    callback(DeReachabilityStatusForFlags(flags));
}

@interface DeReachable ()
@property (nonatomic, assign) SCNetworkReachabilityRef reachabilityRef;
@property (nonatomic, assign) DeReachableState networkState;
@end

@implementation DeReachable

- (void)dealloc{
    if (_reachabilityRef) {
        CFRelease(_reachabilityRef);
    }
}

+ (DeReachable *)reachable{
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 address;
    bzero(&address, sizeof(address));
    address.sin6_len = sizeof(address);
    address.sin6_family = AF_INET6;
#else
    struct sockaddr_in address;
    bzero(&address, sizeof(address));
    address.sin_len = sizeof(address);
    address.sin_family = AF_INET;
#endif
    return [self reachableForAddress:(const void *)&address];
}

+ (instancetype)reachableForDomain:(NSString *)domain{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault,
                                                                                domain.UTF8String);
    DeReachable *able = [[DeReachable alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return able;
}

+ (instancetype)reachableForAddress:(const void *)address{
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault,
                                                                                   (const struct sockaddr *)address);
    DeReachable *able = [[DeReachable alloc] initWithReachability:reachability];
    CFRelease(reachability);
    return able;
}

- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability{
    self = [super init];
    _reachabilityRef = CFRetain(reachability);
    _networkState = DeReachableStateUnkown;
    return self;
}

- (void)start{
    [self stop];
    
    if (!_reachabilityRef) {
        return;
    }
    __weak __typeof(self) ws = self;
    DeReachableStateBlock callback = ^(DeReachableState state){
        ws.networkState = state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:DeReachableChangedNotification
                                                                object:nil
                                                              userInfo:@{DeReachableChangedUserInfoKey : @(state)}];
        });
    };
    SCNetworkReachabilityContext context = {
        0,
        (__bridge void *)callback,
        DeReachableRetainCallBack,
        DeReachableReleaseCallBack,
        NULL
    };
    SCNetworkReachabilitySetCallback(_reachabilityRef, DeReachableCallBack, &context);
    SCNetworkReachabilityScheduleWithRunLoop(_reachabilityRef, CFRunLoopGetMain(), kCFRunLoopCommonModes);
    //同步执行，防止异步出现问题
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(ws.reachabilityRef, &flags)) {
            callback(DeReachabilityStatusForFlags(flags));
        }
    });
}

- (void)stop{
    if (!_reachabilityRef) {
        return;
    }
    SCNetworkReachabilityUnscheduleFromRunLoop(_reachabilityRef, CFRunLoopGetMain(), kCFRunLoopCommonModes);
}

- (BOOL)notReachable{
    return _networkState == DeReachableStateNotReachable;
}
- (BOOL)isWWAN{
    return _networkState == DeReachableStateWWAN;
}
- (BOOL)isWIFI{
    return _networkState == DeReachableStateWIFI;
}
@end
