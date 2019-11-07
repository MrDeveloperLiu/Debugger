//
//  EDJOrderViewCell.m
//  Demo
//
//  Created by 刘杨 on 2019/5/16.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJOrderViewCell.h"

@interface EDJOrderViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation EDJOrderViewCell
+ (NSString *)identifier{
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.frame = self.bounds;
    return self;
}

- (void)setModel:(EDJOrderItem *)model{
    if (_model == model) {
        return;
    }
    _model = model;
    
    if ([model isKindOfClass:[NSString class]]) {
        self.titleLabel.text = (NSString *)model;
    }else{
        if ([model.content isKindOfClass:[NSString class]]) {
            self.titleLabel.text = (NSString *)model.content;
        }else if ([model.content isKindOfClass:[NSDictionary class]]){
            self.titleLabel.text = model.content[@"title"];
        }
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _titleLabel;
}
@end