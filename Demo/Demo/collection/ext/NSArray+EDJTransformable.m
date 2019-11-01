//
//  NSArray+EDJTransformable.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSArray+EDJTransformable.h"



@implementation NSArray (EDJTransformable)

- (NSMutableArray *)containerMap:(EDJTransformableBlock)usingBlock{
    NSInteger count = self.count;
    if (count <= 0) {
        return nil;
    }
    NSMutableArray *temp = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            id array = [obj containerMap:usingBlock];
            if (array) {
                [temp addObject:array];
            }
        }else{
            [temp addObject:usingBlock(obj)];
        }
    }];
    return temp;
}

- (NSMutableArray *)map:(EDJTransformableMapBlock)usingBlock{
    NSInteger count = self.count;
    if (count <= 0) {
        return nil;
    }
    NSMutableArray *temp = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id value = nil;
        if ([obj isKindOfClass:[NSArray class]]) {
            value = usingBlock(nil, obj);
        }else{
            value = usingBlock(obj, nil);
        }
        if (value) {
            [temp addObject:value];
        }
    }];
    return temp;
}
@end
