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
    self.delegate = delegate;
    return self;
}

- (void)setDelegate:(id)delegate{
    _delegate = delegate;
    if (delegate) {
        _collectionView.delegate = delegate;
    }
}

- (void)setDatas:(NSMutableArray *)datas{
    if (_datas != datas) {
        if (datas) { //copy to m array
            _datas = [datas map:^id(id object, id container){
                if (container) {
                    return [container mutableCopy];
                }
                return [@[object] mutableCopy];
            }];
        }else{
            _datas = nil;
        }
        [self.collectionView reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_datas count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sections = [_datas objectAtIndex:section];
    return [sections count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJOrderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EDJOrderViewCell identifier]
                                                                       forIndexPath:indexPath];
    cell.model = [self itemAtIndexPath:indexPath];
    return cell;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *temp = [_datas objectAtIndex:indexPath.section];
    id model = [temp objectAtIndex:indexPath.item];
    return model;
}

- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *temp = [_datas objectAtIndex:indexPath.section];
    [temp removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
