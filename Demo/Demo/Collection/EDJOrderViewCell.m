//
//  EDJOrderViewCell.m
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderViewCell.h"

@implementation EDJOrderViewCell
+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor whiteColor];
    return self;
}
@end
