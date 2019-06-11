//
//  EDJLayout.h
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//


#import "EDJLayoutItems.h"

typedef NS_ENUM(NSUInteger, EDJLayoutDirection) {
    EDJLayoutDirectionVertical = 0,
    EDJLayoutDirectionHorizontal,
};

@interface EDJLayout : UICollectionViewLayout
@property (nonatomic, strong, readonly) NSMutableArray *attributes;
@property (nonatomic, strong, readonly) NSMutableArray *items;
@property (nonatomic, assign, readonly) CGSize viewSize;
@property (nonatomic, assign) EDJLayoutDirection direction;
//itemSize 是根据direction取
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGFloat itemMargin;
@end

@interface EDJLayout (SubClass)
- (void)_layoutBegan;
- (void)_layoutFinished;
- (CGFloat)_offsetItem:(NSInteger)item section:(NSInteger)section;
- (void)_layoutSections;
- (EDJLayoutItems *)_layoutSection:(NSInteger)section previousItem:(EDJLayoutItems *)previousItem;
- (EDJLayoutItem *)_attributeWithIndexPath:(NSIndexPath *)indexPath previous:(EDJLayoutItem *)previous;
- (void)_calculateSize;
@end
