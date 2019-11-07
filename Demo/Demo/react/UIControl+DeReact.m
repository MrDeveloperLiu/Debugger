//
//  UIControl+DeReact.m
//  Demo
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIControl+DeReact.h"

@implementation UIControl (DeReact)

- (DeSignal *)de_textSignal{
    DeSignal *signal = [DeSignal createSignal:^DeDispose *(id<DeSubscribler> subscribler) {
        id obv = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidChangeNotification
                                                                   object:nil
                                                                    queue:nil
                                                               usingBlock:^(NSNotification * _Nonnull note) {
           [subscribler sendNext:note.object];
        }];
        return [DeDispose disposeWithBlock:^{
            [[NSNotificationCenter defaultCenter] removeObserver:obv];
        }];
    }];
    return signal;
}

@end
