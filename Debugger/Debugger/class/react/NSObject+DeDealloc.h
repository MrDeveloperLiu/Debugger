//
//  NSObject+DeDealloc.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DeSignal, DeComboneDispose;
@interface NSObject (DeDealloc)

@property (nonatomic, strong, readonly) DeSignal *deallocSignal;
@property (nonatomic, strong, readonly) DeComboneDispose *deallocDispose;

@end


