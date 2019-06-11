//
//  NSDictionary+DeCategory.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSDictionary+DeCategory.h"

@implementation NSDictionary (DeCategory)
- (BOOL)_deSafetyKey:(id)key{
    return (key != nil);
}
- (BOOL)_deSafetyValue:(id)value{
    return (value != nil);
}

- (id)deObjectForKey:(id)key{
    if ([self _deSafetyKey:key]) {
        return [self objectForKey:key];
    }
    return nil;
}
@end

@implementation NSMutableDictionary (DeCategory)
- (void)deSetObject:(id)object forKey:(id<NSCopying>)key{
    if ([self _deSafetyKey:key] && [self _deSafetyValue:object]) {
        [self setObject:object forKey:key];
    }
}
@end
