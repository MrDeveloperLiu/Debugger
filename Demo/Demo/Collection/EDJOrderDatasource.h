//
//  EDJOrderDatasource.h
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderView.h"

@class EDJOrderView;
@interface EDJOrderDatasource : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, weak) EDJOrderView *collectionView;
@property (nonatomic, weak) id <UICollectionViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *datas;
- (instancetype)initWithOrderView:(EDJOrderView *)orderView delegate:(id)delegate;
- (void)deleteItemAtIndexPath:(NSIndexPath *)indexPath;
@end

