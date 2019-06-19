//
//  DeDebugRefCount.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeDebugRefCount.h"

@implementation DeDebugRefCount

+ (DeDebugRefCount *)ref{
    static DeDebugRefCount *r = nil;
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        r = [DeDebugRefCount new];
    });
#endif
    return r;
}
+ (dispatch_queue_t)DeDebugRefCountQueue{
    static dispatch_queue_t queue = nil;
#if DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("DeDebugRefCountQueue", DISPATCH_QUEUE_SERIAL);
    });
#endif
    return queue;
}

- (instancetype)init{
    self = [super init];
    _map = [NSMutableDictionary dictionary];
    return self;
}
- (NSString *)description{
    return _map.description;
}
- (void)check{
    NSLog(@"%@", _map);
}

- (void)addRef:(id <NSObject>)object{
    NSString *class = NSStringFromClass(object.class);
    if (class) {
        dispatch_sync([self.class DeDebugRefCountQueue], ^{
            NSInteger count = [self.map[class] integerValue];
            self.map[class] = @(count + 1);
        });
    }
}
- (void)removeRef:(id <NSObject>)object{
    NSString *class = NSStringFromClass(object.class);
    if (class) {
        dispatch_sync([self.class DeDebugRefCountQueue], ^{
            NSInteger count = [self.map[class] integerValue];
            self.map[class] = @(count - 1);
        });
    }
}

@end
