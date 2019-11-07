//
//  EDJToastTitleView.m
//  edaijia
//
//  Created by 刘杨 on 2019/5/6.
//

#import "EDJToastTitleView.h"

@implementation EDJToastTitleView

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
//        _titleLabel.font = FONT(13);
        _titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton new];
        [_closeBtn setImage:[UIImage imageNamed:@"3d_drivers"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_closeBtn];
    }
    return _closeBtn;
}

- (void)closeBtnAction:(id)sender{
    [self removeFromSuperview];
    if (_closeBlock) {
        _closeBlock();
        _closeBlock = nil;
    }
}

- (void)didRenderBackground{
    [super didRenderBackground];
    self.titleLabel.centerY = self.contentView.height * 0.5;
    self.closeBtn.centerY = self.titleLabel.centerY;
}

- (void)sizeToFit{
    [self.titleLabel sizeToFit];
    [self.closeBtn sizeToFit];
    
    self.titleLabel.leading = 10;
    self.closeBtn.leading = self.titleLabel.trailing + 5;
    
    CGFloat width = self.closeBtn.trailing + 10;
    CGFloat height = CGRectGetHeight(self.frame);
    if (height <= 0) {        
        height = MAX(self.closeBtn.height, self.titleLabel.height + 10);
    }
    self.frame = CGRectMake(CGRectGetMinX(self.frame),
                            CGRectGetMinY(self.frame),
                            width,
                            height);
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    [self sizeToFit];
}

- (void)showInView:(UIView *)view{
    [view addSubview:self];
}

@end
