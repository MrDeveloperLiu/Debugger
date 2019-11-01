//
//  EDJOrderLayout.m
//  Demo
//
//  Created by 刘杨 on 2019/10/21.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderLayout.h"

@implementation EDJOrderLayout
- (void)beginLayout{
    [self.sizeDelegate orderLayout:self willBeginLayout:self.viewSize];
}

- (void)endLayout{
    [self.sizeDelegate orderLayout:self didFinishLayout:self.viewSize];
}

- (EDJLayoutManager *)layoutManager{
    if (!_layoutManager) {
        _layoutManager = [[EDJOrderLayoutManager alloc] initWithLayout:self];
    }
    return _layoutManager;
}
@end

@implementation EDJOrderLayoutManager

- (void)layoutItemWithItems:(EDJLayoutItems *)items previous:(EDJLayoutItems *)previous{
    EDJLayoutItem *previousLastItem = previous.attributes.lastObject;
    EDJLayoutItem *previousItem = previousLastItem;

    CGFloat itemOffsetY = [self.layout layoutManager:self itemYOffset:items.section];
    CGFloat itemOffsetX = [self.layout layoutManager:self itemXOffset:items.section];

    CGFloat withoutMargin = (items.itemCount - 1) * itemOffsetX;

    CGFloat colloctionWidth = CGRectGetWidth(self.layout.collectionView.frame);
    CGFloat itemWidth = (colloctionWidth - withoutMargin) / items.itemCount;

    for (int i = 0; i < items.itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:items.section];

        CGFloat x = 0, y = 0;
        CGFloat itemHeight = [self.layout layoutManager:self itemHeight:indexPath];

        if (0 == indexPath.item) {  //第一个
            y = CGRectGetMaxY(previousItem.frame) + itemOffsetY;
        }else{                      //非第一个, 同组
            x = CGRectGetMaxX(previousItem.frame) + itemOffsetX;
            y = CGRectGetMinY(previousItem.frame);
        }

        CGRect frame = CGRectMake(x, y, itemWidth, itemHeight);
        EDJLayoutItem *attribute = [EDJLayoutItem itemWithIndexPath:indexPath frame:frame];
        [items.attributes addObject:attribute];

        previousItem = attribute;
    }
    EDJLayoutItem *firstItem = items.attributes.firstObject;
    //计算
    CGRect rect;
    rect.origin = firstItem.frame.origin;
    rect.size = CGSizeMake(CGRectGetMaxX(previousItem.frame) - rect.origin.x,
                           CGRectGetMaxY(previousItem.frame) - rect.origin.y);
    items.rect = rect;
    //添加
    [self.attributes addObjectsFromArray:items.attributes];
    [self.items addObject:items];
}


@end
