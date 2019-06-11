//
//  NSArray+DeCategory.m
//  Debugger
//
//  Created by 刘杨 on 2019/6/11.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSArray+DeCategory.h"

@implementation NSArray (DeCategory)
- (NSInteger)_deFirstIndex{
    if (self.count > 0) {
        return 0;
    }
    return NSNotFound;
}
- (NSInteger)_deLastIndex{
    if (self.count > 0) {
        return self.count - 1;
    }
    return NSNotFound;
}
- (BOOL)_deSafetyIndex:(NSInteger)index{
    return (index >= 0) && (index <= self.count - 1);
}
- (id)deObjectAtIndex:(NSInteger)index{
    if ([self _deSafetyIndex:index]) {
        return [self objectAtIndex:index];
    }
    return nil;
}
@end

@implementation NSMutableArray (DeCategory)
- (void)deAddObject:(id)object{
    if (object) {
        [self addObject:object];
    }
}
- (void)deInsertObject:(id)object atIndex:(NSUInteger)index{
    if (index < 0) {
        index = 0;
    }else if (index > self.count - 1) {
        index = self.count - 1;
    }
    [self insertObject:object atIndex:index];
}
- (void)deRemoveObjectAtIndex:(NSUInteger)index{
    if ([self _deSafetyIndex:index]) {
        [self removeObjectAtIndex:index];
    }
}
@end
