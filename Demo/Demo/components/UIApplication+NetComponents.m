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

- (DeSignal *)de_networkSignal:(NSString *)url method:(NSString *)method parameters:(id)parameters{
    NSParameterAssert(url);
    NSParameterAssert(method);
    
    DeSignal *signal = [DeSignal createSignal:^DeDispose *(id<DeSubscribler> subscribler) {
        
        NSURL *baseUrl = [NSURL URLWithString:url];
        NSParameterAssert(baseUrl);
        
        id <NetOperation> networkOperation = [self.networkManager requestWithBaseUrl:baseUrl method:method paramters:parameters successBlock:^(id<NetTask> task, NSURLResponse *response, id data) {
            
            [subscribler sendNext:data];
            [subscribler sendCompleted];
        } failedBlock:^(id<NetTask> task, NSURLResponse *response, NSError *error) {
            
            [subscribler sendError:error];
        }];
        
        return [DeDispose disposeWithBlock:^{
            
            if ([networkOperation isExecuting]) {
                [networkOperation cancel];
            }
        }];
    }];
    return signal;
}

- (DeSignal *)de_networkRequest:(NSURLRequest *)request{
    NSParameterAssert(request);
    
    DeSignal *signal = [DeSignal createSignal:^DeDispose *(id<DeSubscribler> subscribler) {
        
        id <NetOperation> networkOperation = [self.networkManager requestWithRequest:request successBlock:^(id<NetTask> task, NSURLResponse *response, id data) {
            
            [subscribler sendNext:data];
            [subscribler sendCompleted];
        } failedBlock:^(id<NetTask> task, NSURLResponse *response, NSError *error) {

            [subscribler sendError:error];
        }];
        
        return [DeDispose disposeWithBlock:^{
            
            if ([networkOperation isExecuting]) {
                [networkOperation cancel];
            }
        }];
    }];
    return signal;

}
@end
