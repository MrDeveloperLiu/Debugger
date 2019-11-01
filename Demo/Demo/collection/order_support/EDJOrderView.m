//
//  EDJCollectionView.m
//  Demo
//
//  Created by 刘杨 on 2019/5/15.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderView.h"

@interface EDJOrderView () <EDJOrderLayoutDelegate, EDJLayoutDelegate>

@end

@implementation EDJOrderView

- (void)dealloc{
    _layoutBlock = nil;
}

- (instancetype)init{
    EDJOrderLayout *layout = [EDJOrderLayout new];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    layout.sizeDelegate = self;
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

- (void)orderLayout:(EDJOrderLayout *)layout willBeginLayout:(CGSize)size{
    
}

- (void)orderLayout:(EDJOrderLayout *)layout didFinishLayout:(CGSize)size{
    if (self.layoutBlock) {
        self.layoutBlock(size);
    }
}

- (CGFloat)layout:(EDJLayout *)layout itemHeight:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }
    return 44;
}

//- (CGFloat)layout:(EDJLayout *)layout itemHorizontalOffset:(NSInteger)section{
//    return 0;
//}
//
//- (CGFloat)layout:(EDJLayout *)layout itemVerticalOffset:(NSInteger)section{
//    return 0;
//}
@end




