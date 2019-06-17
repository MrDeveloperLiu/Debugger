//
//  EDJOrderDatasource.m
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderDatasource.h"

@implementation EDJOrderDatasource
- (instancetype)initWithOrderView:(EDJOrderView *)orderView delegate:(id)delegate{
    self = [super init];
    _collectionView = orderView;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _delegate = delegate;
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_datas count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[_datas objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJOrderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EDJOrderViewCell identifier]
                                                                       forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath{    
    NSMutableArray *temp = [_datas objectAtIndex:indexPath.section];
    [temp removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}
@end
