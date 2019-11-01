//
//  EDJOrderView.m
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderContentView.h"

@interface EDJOrderContentView ()
@property (nonatomic, strong) EDJOrderContainer *insetView;
@end

@implementation EDJOrderContentView

- (instancetype)init{
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    [self configure];
    [self addSubview:self.insetView];
    [self setBottomOffset:30];
    return self;
}

- (void)setBottomOffset:(CGFloat)bottomOffset{
    if (_bottomOffset != bottomOffset) {
        _bottomOffset = bottomOffset;
        
        CGFloat t = self.insetView.frame.size.height - bottomOffset;
        UIEdgeInsets inset = UIEdgeInsetsMake(t, 0, kIphoneXSafeBottom, 0);
        [self setContentInset:inset];
    }
}

- (void)configure{
    self.backgroundColor = [UIColor clearColor];
    
    self.rowHeight = 0;
    self.sectionHeaderHeight = 0;
    self.sectionFooterHeight = 0;
    
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (EDJOrderContainer *)insetView{
    if (!_insetView) {
        CGSize s = self.bounds.size;
        CGRect frame = CGRectMake(0, -s.height, s.width, s.height);
        _insetView = [[EDJOrderContainer alloc] initWithFrame:frame];
    }
    return _insetView;
}
@end
