//
//  EDJLayoutItem.m
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJLayoutItem.h"

@implementation EDJLayoutItem
+ (instancetype)itemWithIndexPath:(NSIndexPath *)indexPath frame:(CGRect)frame{
    EDJLayoutItem *item = [self.class layoutAttributesForCellWithIndexPath:indexPath];
    item.frame = frame;
    return item;
}
@end
