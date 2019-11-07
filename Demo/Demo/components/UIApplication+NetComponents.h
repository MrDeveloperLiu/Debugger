//
//  UIApplication+NetComponents.h
//  Demo
//
//  Created by 刘杨 on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Debugger/Debugger.h>
#import "NetComponents.h"

#define APP [UIApplication sharedApplication]
#define NETComp APP.networkManager

@interface UIApplication (NetComponents)

@property (nonatomic, strong, readonly) id<NetComponents> networkManager;

- (void)networkInstall;
- (void)networkUninstall;

- (DeSignal *)de_networkSignal:(NSString *)url method:(NSString *)method parameters:(id)parameters;
- (DeSignal *)de_networkRequest:(NSURLRequest *)request;
@end



