//
//  EDJOrderItem.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderItem.h"

@implementation EDJOrderItemLayout

@end

@implementation EDJOrderItem
- (id)copyWithZone:(nullable NSZone *)zone{
    EDJOrderItem *copy = [[EDJOrderItem alloc] init];
    copy.content = self.content;
    copy.layout = self.layout;
    return copy;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    EDJOrderItem *copy = [[EDJOrderItem alloc] init];
    copy.content = self.content;
    copy.layout = self.layout;
    return copy;
}

@end
