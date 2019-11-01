//
//  EDJCollectionDatasource.m
//  Demo
//
//  Created by 刘杨 on 2019/10/29.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJCollectionDatasource.h"

@implementation EDJCollectionDatasource

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id)delegate{
    self = [super init];
    _collectionView = collectionView;
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
        _datas = datas;
        [self.collectionView reloadData];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_datas count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EDJOrderViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EDJOrderViewCell identifier]
                                                                       forIndexPath:indexPath];
    cell.model = [self itemAtIndexPath:indexPath];
    return cell;
}


- (id)itemAtIndexPath:(NSIndexPath *)indexPath{
    id model = [_datas objectAtIndex:indexPath.item];
    return model;
}
@end
