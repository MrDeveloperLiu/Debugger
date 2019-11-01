//
//  EDJCollectionView.h
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderLayout.h"
#import "EDJOrderViewCell.h"
#import "EDJOrderDatasource.h"
#import "EDJBusinessView.h"
#import "NSArray+GenericMath.h"
#import "NSObject+EDJTransformable.h"

typedef void(^EDJOrderViewBlock)(CGSize s);

@interface EDJOrderView : UICollectionView
@property (nonatomic, copy) EDJOrderViewBlock layoutBlock;
@property (nonatomic, strong) EDJOrderDatasource *ds;
@end



