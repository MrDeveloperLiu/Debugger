//
//  EDJBusinessView.h
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJTouchView.h"
#import "EDJOrderLayout.h"
#import "EDJOrderViewCell.h"
#import "EDJOrderDatasource.h"
#import "EDJCollectionDatasource.h"


@interface EDJBusinessView : EDJCollectionTouchView
@property (nonatomic, strong) EDJCollectionDatasource *ds;
@end
