//
//  UIApplication+NetComponents.m
//  Demo
//
//  Created by 刘杨 on 2019/6/17.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIApplication+NetComponents.h"
#import <objc/runtime.h>

@implementation UIApplication (NetComponents)

- (void)setNetworkManager:(id<NetComponents>)networkManager{
    objc_setAssociatedObject(self, @selector(networkManager), networkManager, OBJC_ASSOCIATION_RETAIN);
}
- (id<NetComponents>)networkManager{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)networkInstall{
    [self setNetworkManager:(id<NetComponents>)[DeHTTPManager manager]];
}

- (void)networkUninstall{
    [self setNetworkManager:nil];
}
@end
