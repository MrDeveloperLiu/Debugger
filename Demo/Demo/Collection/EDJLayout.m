//
//  EDJLayout.m
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJLayout.h"

@implementation EDJLayout

- (instancetype)init{
    self = [super init];
    _itemSize = (CGSize){44, 44};
    _itemMargin = 0.5;
    return self;
}

- (void)prepareLayout{
    _items = [NSMutableArray array];
    _attributes = [NSMutableArray array];

    [self _layoutBegan];
    [self _layoutSections];
    [self _calculateSize];
    [super prepareLayout];
    [self _layoutFinished];
}



- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJLayoutItems *items = [_items objectAtIndex:indexPath.section];
    return [items.attributes objectAtIndex:indexPath.row];
}

- (CGSize)collectionViewContentSize{
    return _viewSize;
}



@end

@implementation EDJLayout (SubClass)
- (void)_layoutBegan{
    
}
- (void)_layoutFinished{

}

- (CGFloat)_offsetItem:(NSInteger)item section:(NSInteger)section{
    if (item <= 0 && section <= 0) {
        return 0;
    }
    return _itemMargin;
}

- (void)_calculateSize{
    EDJLayoutItem *last = _attributes.lastObject;
    if (_direction == EDJLayoutDirectionVertical) {
        _viewSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame),
                               CGRectGetMaxY(last.frame));
    }else{
        _viewSize = CGSizeMake(CGRectGetMaxX(last.frame),
                               CGRectGetHeight(self.collectionView.frame));
    }
}

- (void)_layoutSections{
    NSInteger sections = [self.collectionView numberOfSections];
    EDJLayoutItems *previous = nil;
    for (int i = 0; i < sections; i++) {
        //items
        EDJLayoutItems *items = [self _layoutSection:i previousItem:previous];
        [_items addObject:items];
        //insert attribute
        [_attributes addObjectsFromArray:items.attributes];
        previous = items;
    }
}

- (EDJLayoutItems *)_layoutSection:(NSInteger)section previousItem:(EDJLayoutItems *)previousItem{
    NSInteger number = [self.collectionView numberOfItemsInSection:section];
    EDJLayoutItems *items = [EDJLayoutItems new];
    items.section = section;
    
    EDJLayoutItem *previous = previousItem.attributes.lastObject;
    CGRect rect;
    for (int i = 0; i < number; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        EDJLayoutItem *attribute = [self _attributeWithIndexPath:indexPath previous:previous];
        if (i == 0) {
            rect.origin = attribute.frame.origin;
        }
        [items.attributes addObject:attribute];
        previous = attribute;
    }
    rect.size = CGSizeMake(CGRectGetMaxX(previous.frame) - rect.origin.x,
                           CGRectGetMaxY(previous.frame) - rect.origin.y);
    items.rect = rect;
    return items;
}

- (EDJLayoutItem *)_attributeWithIndexPath:(NSIndexPath *)indexPath previous:(EDJLayoutItem *)previous{
    CGFloat itemOffset = [self _offsetItem:indexPath.item section:indexPath.section];;;
    CGFloat x = 0, y = 0, w = 0, h = 0;
    if (_direction == EDJLayoutDirectionVertical) {
        y = CGRectGetMaxY(previous.frame) + itemOffset;
        w = CGRectGetWidth(self.collectionView.frame);
        h = _itemSize.height;
    }else{
        x = CGRectGetMaxX(previous.frame) + itemOffset;
        w = _itemSize.width;
        h = CGRectGetHeight(self.collectionView.frame);
    }
    CGRect frame = CGRectMake(x, y, w, h);
    EDJLayoutItem *attribute = [EDJLayoutItem itemWithIndexPath:indexPath frame:frame];
    return attribute;
}

@end
