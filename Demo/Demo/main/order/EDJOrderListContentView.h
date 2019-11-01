//
//  EDJOrderListContentView.h
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJCollectionDatasource.h"

@interface EDJOrderListContentView : UIView

@property (nonatomic, strong) EDJOrderView *collectionView;
@property (nonatomic, strong) EDJBusinessView *selectView;

@property (nonatomic, copy) dispatch_block_t contentChangedBlock;

@property (nonatomic, copy) void(^contentSelectBlock)(UICollectionView *v, NSIndexPath *indexPath);
@end

