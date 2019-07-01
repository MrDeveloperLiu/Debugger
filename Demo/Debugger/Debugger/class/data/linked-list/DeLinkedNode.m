//
//  DeLinkedNode.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/28.
//  Copyright © 2019 liu. All rights reserved.
//

#import "DeLinkedNode.h"

@implementation DeLinkedNode

- (instancetype)initWithValue:(id)value{
    self = [super init];
    _value = value;
    return self;
}

+ (instancetype)nodeWithValue:(id)value{
    return [[self alloc] initWithValue:value];
}
@end
