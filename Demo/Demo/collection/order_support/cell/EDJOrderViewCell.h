//
//  EDJOrderViewCell.h
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDJOrderItem.h"

@interface EDJOrderViewCell : UICollectionViewCell
+ (NSString *)identifier;

@property (nonatomic, strong) EDJOrderItem *model;
@end

