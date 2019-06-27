//
//  DeStream.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeStream.h"
#import "DeReact.h"

@implementation DeStream
- (void)dealloc{
    [[DeDebugRefCount ref] removeRef:self];
}

- (instancetype)init{
    self = [super init];
    [[DeDebugRefCount ref] addRef:self];
    return self;
}
@end

@implementation DeStream (DeStream)

- (instancetype)map:(id (^)(id))transform{
    return nil;
}

- (instancetype)filter:(BOOL (^)(id x))transform{
    return nil;
}
- (instancetype)bind:(id (^)(id x))transform{
    return nil;
}
@end
