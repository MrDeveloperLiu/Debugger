//
//  EDJCollectionDatasource.h
//  Demo
//
//  Created by 刘杨 on 2019/10/29.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EDJCollectionDatasource : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) id <UICollectionViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *datas;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView delegate:(id)delegate;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end

