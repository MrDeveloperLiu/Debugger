//
//  EDJBusinessView.m
//  Demo
//
//  Created by 刘杨 on 2019/10/30.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJBusinessView.h"

@interface EDJBusinessView () <EDJLayoutDelegate>

@end

@implementation EDJBusinessView

- (instancetype)init{
    EDJLayout *layout = [EDJLayout new];
    layout.height = 50;
    layout.layoutManager.direction = EDJLayoutManagerDirectionHorizontal;
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    layout.delegate = self;
    if (@available(iOS 10.0, *)) {
        self.prefetchingEnabled = NO;
    }
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    [self registerClass:[EDJOrderViewCell class] forCellWithReuseIdentifier:[EDJOrderViewCell identifier]];
    return self;
}

- (CGFloat)layout:(EDJLayout *)layout itemWidth:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)layout:(EDJLayout *)layout itemMargin:(NSIndexPath *)indexPath{
    if (0 == indexPath.item) {
        return 0;
    }
    return 1;
}

@end
