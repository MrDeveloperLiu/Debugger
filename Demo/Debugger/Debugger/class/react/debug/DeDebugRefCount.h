//
//  DeDebugRefCount.h
//  Debugger
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeDebugRefCount : NSObject

+ (DeDebugRefCount *)ref;
@property (nonatomic, strong, readonly) NSMutableDictionary *map;
- (void)check;

- (void)addRef:(id <NSObject>)object;
- (void)removeRef:(id <NSObject>)object;

@end

