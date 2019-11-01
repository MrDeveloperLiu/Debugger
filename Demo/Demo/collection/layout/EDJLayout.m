//
//  EDJLayout.m
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJLayout.h"



@interface EDJLayoutManager ()
@property (nonatomic, weak) EDJLayout *layout;
@property (nonatomic, strong) NSMutableArray *attributes;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation EDJLayoutManager

- (instancetype)initWithLayout:(EDJLayout *)layout{
    self = [super init];
    _direction = EDJLayoutManagerDirectionVertical;
    _layout = layout;
    return self;
}

- (CGFloat)estimateLineHeight{
    CGFloat scale = [[UIScreen mainScreen] scale];
    if (scale <= 2) { //1x & 2x
        return 0.5;
    }                 //3x for now
    return 0.33;
}

- (CGFloat)estimateItemHeight{
    return 44;
}

- (EDJLayoutItems *)layoutSection:(NSInteger)section counts:(NSInteger)counts{
    EDJLayoutItems *items = [EDJLayoutItems new];
    items.section = section;
    items.itemCount = counts;
    return items;
}

- (void)layoutItemWithItems:(EDJLayoutItems *)items previous:(EDJLayoutItems *)previous{
    EDJLayoutItem *previousLastItem = previous.attributes.lastObject;
    EDJLayoutItem *previousItem = previousLastItem;
                
    for (int i = 0; i < items.itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:items.section];

        CGFloat x = 0, y = 0;
        CGFloat itemHeight = [self.layout layoutManager:self itemHeight:indexPath];
        CGFloat itemWidth = [self.layout layoutManager:self itemWidth:indexPath];
        CGFloat itemMargin = [self.layout layoutManager:self itemMargin:indexPath];

        if (_direction == EDJLayoutManagerDirectionVertical) {
            y = CGRectGetMaxY(previousItem.frame) + itemMargin;
        }else{
            x = CGRectGetMaxX(previousItem.frame) + itemMargin;
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
    [_attributes addObjectsFromArray:items.attributes];
    [_items addObject:items];
}

- (void)beginLayout{
    [self.layout layoutManagerLayoutDidBegan:self];
    _items = [NSMutableArray array];
    _attributes = [NSMutableArray array];
}

- (void)endLayout{
    [self.layout layoutManagerLayoutDidFinshed:self];
}

- (void)doLayout{
    EDJLayoutItems *previous = nil;
    NSInteger sections = [self.layout.collectionView numberOfSections];
    for (NSInteger i = 0; i < sections; i++) {
        NSInteger counts = [self.layout.collectionView numberOfItemsInSection:i];
        EDJLayoutItems *items = [self layoutSection:i counts:counts];
        [self layoutItemWithItems:items previous:previous];
        previous = items;
    }
}

- (void)prepareLayout{
    [self beginLayout];
    [self doLayout];
    [self endLayout];
}
@end



@interface EDJLayout ()
@property (nonatomic, strong) EDJLayoutManager *layoutManager;
@property (nonatomic, assign) CGSize viewSize;
@end

@implementation EDJLayout

- (instancetype)init{
    self = [super init];
    _margin = [self.layoutManager estimateLineHeight];
    _height = [self.layoutManager estimateItemHeight];
    return self;
}

- (EDJLayoutManager *)layoutManager{
    if (!_layoutManager) {
        _layoutManager = [[EDJLayoutManager alloc] initWithLayout:self];
    }
    return _layoutManager;
}

- (void)prepareLayout{
    [self beginLayout];
    [self.layoutManager prepareLayout];
    [self calculateSize];
    [super prepareLayout];
    [self endLayout];
}

- (void)beginLayout{}
- (void)endLayout{}

- (void)calculateSize{
    EDJLayoutItem *last = self.layoutManager.attributes.lastObject;
    if (self.layoutManager.direction == EDJLayoutManagerDirectionHorizontal) {
        CGFloat w = CGRectGetMaxX(last.frame);
        CGFloat h = CGRectGetHeight(last.frame);
        _viewSize = CGSizeMake(w, h);
    }else{
        CGFloat w = CGRectGetWidth(self.collectionView.frame);
        CGFloat h = CGRectGetMaxY(last.frame);
        _viewSize = CGSizeMake(w, h);
    }
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = self.layoutManager.attributes;
    return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJLayoutItems *items = [self.layoutManager.items objectAtIndex:indexPath.section];
    EDJLayoutItem *item = [items.attributes objectAtIndex:indexPath.row];
    return item;
}

- (CGSize)collectionViewContentSize{
    return _viewSize;
}

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemXOffset:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(layout:itemHorizontalOffset:)]) {
        return [self.delegate layout:self itemHorizontalOffset:section];
    }
    return _margin;
}

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemYOffset:(NSInteger)section{
    if ([self.delegate respondsToSelector:@selector(layout:itemVerticalOffset:)]) {
        return [self.delegate layout:self itemVerticalOffset:section];
    }
    if (0 == section) {
        return 0;
    }
    return _margin;
}

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemHeight:(NSIndexPath *)indexPath{
    CGFloat h = 0;
    if ([self.delegate respondsToSelector:@selector(layout:itemHeight:)]) {
        h = [self.delegate layout:self itemHeight:indexPath];
    }
    if (h <= 0) {
        return _height;
    }
    return h;
}

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemWidth:(NSIndexPath *)indexPath{
    CGFloat w = 0;
    if ([self.delegate respondsToSelector:@selector(layout:itemWidth:)]) {
        w = [self.delegate layout:self itemWidth:indexPath];
    }
    if (w <= 0) {
        return CGRectGetWidth(self.collectionView.frame);
    }
    return w;
}

- (CGFloat)layoutManager:(EDJLayoutManager *)mgr itemMargin:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(layout:itemMargin:)]) {
        return [self.delegate layout:self itemMargin:indexPath];
    }
    if (0 == indexPath.section && 0 == indexPath.item) {
        return 0;
    }
    return _margin;
}

- (void)layoutManagerLayoutDidBegan:(EDJLayoutManager *)mgr{
    if ([self.delegate respondsToSelector:@selector(layoutCalculateWillBegin:)]) {
        [self.delegate layoutCalculateWillBegin:self];
    }
}

- (void)layoutManagerLayoutDidFinshed:(EDJLayoutManager *)mgr{
    if ([self.delegate respondsToSelector:@selector(layoutCalculateDidFinished:)]) {
        [self.delegate layoutCalculateDidFinished:self];
    }
}
@end
