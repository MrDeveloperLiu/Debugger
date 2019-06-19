//
//  EDJCollectionView.m
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderView.h"

@implementation EDJOrderView

- (instancetype)init{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[EDJLayout new]];
    if (@available(iOS 10.0, *)) {
        [self setPrefetchingEnabled:NO];
    }
    [self registerClass:[EDJOrderViewCell class] forCellWithReuseIdentifier:[EDJOrderViewCell identifier]];
    return self;
}

@end
