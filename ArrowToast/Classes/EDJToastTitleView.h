//
//  EDJToastTitleView.h
//  edaijia
//
//  Created by 刘杨 on 2019/5/6.
//

#import "EDJToastContentView.h"

typedef void(^EDJToastTitleViewCloseBlock)(void);

@interface EDJToastTitleView : EDJToastContentView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, copy) EDJToastTitleViewCloseBlock closeBlock;

- (void)setTitle:(NSString *)title;
- (void)showInView:(UIView *)view;
- (void)closeBtnAction:(id)sender;
@end

