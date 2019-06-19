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
- (instancetype)init{
    self = [super init];
    [[DeDebugRefCount ref] addRef:self];
    return self;
}

- (void)dealloc{
    [[DeDebugRefCount ref] removeRef:self];
}

- (instancetype)map:(id (^)(id))transform{
    return nil;
}
@end
