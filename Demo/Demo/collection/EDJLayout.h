//
//  EDJLayout.h
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//


#import "EDJLayoutItems.h"


@interface EDJLayout : UICollectionViewLayout
{
@package
    NSMutableArray *_attributes;
    NSMutableArray *_items;
    CGSize          _viewSize;
}
@property (nonatomic, strong, readonly) NSMutableArray *attributes;
@property (nonatomic, strong, readonly) NSMutableArray *items;
@property (nonatomic, assign, readonly) CGSize viewSize;
//itemSize 是根据direction取
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) float itemMargin;
@property (nonatomic, assign) float sectionMargin;
@end

@interface EDJLayout (SubClass)
- (void)_layoutBegan;
- (void)_layoutFinished;
- (void)_layoutSections;

- (CGFloat)_offsetItemInSection:(NSInteger)section;
- (void)__layoutSectionItem:(EDJLayoutItems *)item last:(EDJLayoutItems *)last;
- (void)_calculateSize;
@end


