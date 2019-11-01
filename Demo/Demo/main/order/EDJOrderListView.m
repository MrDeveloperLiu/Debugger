//
//  EDJOrderListView.m
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderListView.h"

@interface EDJOrderListView ()
@property (nonatomic, strong) EDJOrderListContentView *contentView;
@end

@implementation EDJOrderListView

- (void)adjustContentView{
    self.contentView.bottom = self.insetView.frame.size.height;
}

- (EDJOrderListContentView *)contentView{
    if (!_contentView) {
        CGRect frame = CGRectMake(0, self.insetView.frame.size.height, self.insetView.frame.size.width, 0);
        _contentView = [[EDJOrderListContentView alloc] initWithFrame:frame];
        [self.insetView addSubview:_contentView];
        __weak __typeof(self) ws = self;
        _contentView.contentChangedBlock = ^{
            [ws adjustContentView];
        };
        _contentView.contentSelectBlock = ^(UICollectionView *v, NSIndexPath *indexPath){
            NSLog(@"hit %@", indexPath);
        };
    }
    return _contentView;
}
@end
