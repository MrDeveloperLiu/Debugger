//
//  EDJToastTipsView.h
//  edaijia
//
//  Created by 刘杨 on 2019/5/6.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EDJToastTipsViewTrangleMode) {
    EDJToastTipsViewTrangleModeNull = 0,
    EDJToastTipsViewTrangleModeTop,
    EDJToastTipsViewTrangleModeBottom,
    EDJToastTipsViewTrangleModeLeft,
    EDJToastTipsViewTrangleModeRight,
    EDJToastTipsViewTrangleModeTest
};

typedef NS_ENUM(NSUInteger, EDJToastTipsViewTranglePosition) {
    EDJToastTipsViewTranglePositionMiddle = 0,
    EDJToastTipsViewTranglePositionLeft,
    EDJToastTipsViewTranglePositionRight,
};


@interface EDJToastTipsView : UIView
//default EDJToastTipsViewTrangleModeTop
@property (nonatomic, assign) EDJToastTipsViewTrangleMode trangleMode;
//default EDJToastTipsViewTranglePositionMiddle
@property (nonatomic, assign) EDJToastTipsViewTranglePosition tranglePosition;
//default 0
@property (nonatomic, assign) CGFloat positionOffset;
//default CGSizeMake(10, 6)
@property (nonatomic, assign) CGSize trangleSize;
//default lightGrayColor
@property (nonatomic, strong) UIColor *color;
//三角区域
@property (nonatomic, assign) CGRect trangleRect;
//内容区域
@property (nonatomic, assign) CGRect contentRect;
//圆角半径
@property (nonatomic, assign) CGFloat contentRadius;
//完成绘制背景了，这时候上面才有值
- (void)didRenderBackground;
@end

