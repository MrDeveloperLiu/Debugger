//
//  EDJLayout.m
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJLayout.h"

@interface EDJLayout ()
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) CGSize viewSize;
@end

@implementation EDJLayout

- (instancetype)init{
    self = [super init];
    _itemSize = (CGSize){44, 44};
    _itemMargin = 0.5;
    _sectionMargin = 0.5;
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

- (CGFloat)_offsetItemInSection:(NSInteger)section{
    if (0 == section) {
        return 0;
    }
    return _sectionMargin;
}

- (void)_calculateSize{
    EDJLayoutItem *last = _attributes.lastObject;
    _viewSize = CGSizeMake(CGRectGetWidth(self.collectionView.frame),
                           CGRectGetMaxY(last.frame));
}

- (void)_layoutSections{
    NSInteger sections = [self.collectionView numberOfSections];
    EDJLayoutItems *previous = nil;
    for (int i = 0; i < sections; i++) {
        NSInteger counts = [self.collectionView numberOfItemsInSection:i];
        if (counts <= 0) {
            continue;
        }
        EDJLayoutItems *items = [EDJLayoutItems new];
        items.section = i;
        items.itemCount = counts;
        [self __layoutSectionItem:items last:previous];
        previous = items;
    }
}

- (void)__layoutSectionItem:(EDJLayoutItems *)item last:(EDJLayoutItems *)last{
    EDJLayoutItem *previousItem = last.attributes.lastObject;
    CGFloat margin = (item.itemCount - 1) * _itemMargin;
    CGFloat width = (CGRectGetWidth(self.collectionView.frame) - margin) / item.itemCount;
    
    EDJLayoutItem *firstItem = nil;
    
    for (int i = 0; i < item.itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:item.section];
        CGFloat itemOffset = [self _offsetItemInSection:indexPath.section];

        CGFloat x = 0, y = 0,
        w = width,
        h = _itemSize.height;
        
        if (0 == indexPath.item) {  //第一个
            y = CGRectGetMaxY(previousItem.frame) + itemOffset;
        }else{                      //非第一个, 同组
            x = CGRectGetMaxX(previousItem.frame) + itemOffset;
            y = CGRectGetMinY(previousItem.frame);
        }
        
        EDJLayoutItem *attribute = [EDJLayoutItem itemWithIndexPath:indexPath frame:CGRectMake(x, y, w, h)];
        [item.attributes addObject:attribute];
        
        if (0 == i) {
            firstItem = attribute;
        }
        previousItem = attribute;
    }
    //计算
    CGRect rect;
    rect.origin = firstItem.frame.origin;
    rect.size = CGSizeMake(CGRectGetMaxX(previousItem.frame) - rect.origin.x,
                           CGRectGetMaxY(previousItem.frame) - rect.origin.y);
    item.rect = rect;
    //添加
    [_attributes addObjectsFromArray:item.attributes];
    [_items addObject:item];
}
@end
