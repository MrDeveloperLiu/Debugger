//
//  NSObject+EDJTransformable.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSObject+EDJTransformable.h"

@implementation NSObject (EDJTransformable)

- (EDJOrderItem *)transform_toOrderItem{
    EDJOrderItem *it = [EDJOrderItem new];
    it.content = self;
    return it;
}

- (EDJListObject *)transform_toListItem{
    EDJListObject *obj = [EDJListObject new];
    obj.content = self;
    return obj;
}

@end



