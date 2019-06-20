//
//  UIView+DeFrame.h
//  Demo
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>


//Screen
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
//Nav
#define kStatusBarH             20
#define kNavBarH                44
#define kNavH                   (kStatusBarH + kNavBarH)
//Phone
#define kIphone4Size            ((CGSize){320, 480})
#define kIphone5Size            ((CGSize){320, 568})
#define kIphone6_8Size          ((CGSize){375, 667})
#define kIphone6_8PlusSize      ((CGSize){414, 736})
#define kIphoneXSize            ((CGSize){375, 812})
#define kIphoneXMaxSize         ((CGSize){414, 896})
//Safe Edge
#define kIphoneXEdgeTop         24
#define kIphoneXEdgeBottom      34
//Has Edge
#define kIphoneX (CGSizeEqualToSize(kScreenSize, kIphoneXSize))
#define kIphoneXMax (CGSizeEqualToSize(kScreenSize, kIphoneXMaxSize))
#define kIphoneEdge (kIphoneX || kIphoneXMax)
//Safe T B
#define kIphoneXSafeTop (kIphoneEdge ? kIphoneXEdgeTop: 0)
#define kIphoneXSafeBottom (kIphoneEdge ? kIphoneXEdgeBottom: 0)


@interface UIView (DeFrame)
@property (nonatomic, assign) CGFloat leading;
@property (nonatomic, assign) CGFloat trailing;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (UIView * (^)(CGFloat))de_leading;
- (UIView * (^)(CGFloat))de_trailing;

- (UIView * (^)(CGFloat))de_top;
- (UIView * (^)(CGFloat))de_bottom;

- (UIView * (^)(CGFloat))de_width;
- (UIView * (^)(CGFloat))de_height;

- (UIView * (^)(CGFloat))de_centerX;
- (UIView * (^)(CGFloat))de_centerY;
- (UIView * (^)(CGPoint))de_center;

- (UIView * (^)(CGPoint))de_origin;
- (UIView * (^)(CGSize))de_size;
@end


