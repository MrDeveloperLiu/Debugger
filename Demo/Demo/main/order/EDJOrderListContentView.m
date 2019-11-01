//
//  EDJOrderListContentView.m
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderListContentView.h"

@implementation EDJOrderListContentView

- (void)dealloc{
    _contentChangedBlock = nil;
    _contentSelectBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
    
    [self addSubview:self.selectView];
    self.selectView.frame = self.bounds;
    
    self.selectView.height = 50;
    return self;
}

- (EDJOrderView *)collectionView{
    if (!_collectionView) {
        _collectionView = [EDJOrderView new];
        _collectionView.ds = [[EDJOrderDatasource alloc] initWithOrderView:_collectionView delegate:self];
        __weak __typeof(self) ws = self;
        _collectionView.layoutBlock = ^(CGSize s){
            [ws didFinsihLayoutOrderView:s];
        };
    }
    return _collectionView;
}

- (EDJBusinessView *)selectView{
    if (!_selectView) {
        _selectView = [EDJBusinessView new];
        _selectView.ds = [[EDJCollectionDatasource alloc] initWithCollectionView:_selectView delegate:self];        
    }
    return _selectView;
}

- (void)didFinsihLayoutOrderView:(CGSize)s{
    CGFloat collectH = s.height;
    if (self.collectionView.height != collectH) {
        self.collectionView.height = collectH;
    }
    CGFloat margin = 2;
    CGFloat bottom = 2;
    CGFloat totalH = (self.collectionView.height + self.selectView.height + margin + bottom);
    if (self.height != totalH) {
        self.height = totalH;
    }
    CGFloat collectionBottom = totalH - bottom;
    if (self.collectionView.bottom != collectionBottom) {
        self.collectionView.bottom = collectionBottom;
    }
    if (self.contentChangedBlock) {
        self.contentChangedBlock();
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contentSelectBlock) {
        self.contentSelectBlock(collectionView, indexPath);
    }
}

@end
