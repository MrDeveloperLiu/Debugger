//
//  DeReachable.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "DeHTTPNotReachableError.h"

typedef NS_ENUM(NSUInteger, DeReachableState) {
    DeReachableStateUnkown = -1,
    DeReachableStateNotReachable = 0,
    DeReachableStateWWAN,
    DeReachableStateWIFI
};

FOUNDATION_EXPORT NSString * DeReachableChangedNotification;
FOUNDATION_EXPORT NSString * DeReachableChangedUserInfoKey;

FOUNDATION_EXPORT DeReachableState DeReachabilityStatusForFlags(SCNetworkReachabilityFlags flags);

typedef void (^DeReachableStateBlock) (DeReachableState state);

@interface DeReachable : NSObject
@property (nonatomic, assign, readonly) DeReachableState networkState;

+ (DeReachable *)reachable;
+ (instancetype)reachableForDomain:(NSString *)domain;
+ (instancetype)reachableForAddress:(const void *)address;
- (instancetype)initWithReachability:(SCNetworkReachabilityRef)reachability;

- (void)start;
- (void)stop;

- (BOOL)notReachable;
- (BOOL)isWWAN;
- (BOOL)isWIFI;
@end

