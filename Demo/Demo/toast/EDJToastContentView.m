//
//  EDJToastContentView.m
//  edaijia
//
//  Created by 刘杨 on 2019/5/6.
//

#import "EDJToastContentView.h"

@implementation EDJToastContentView

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (void)didRenderBackground{
    self.contentView.frame = self.contentRect;
}
@end
