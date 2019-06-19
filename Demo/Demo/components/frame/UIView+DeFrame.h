//
//  UIView+DeFrame.h
//  Demo
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIView (DeFrame)
@property (nonatomic, assign) CGFloat leading;
@property (nonatomic, assign) CGFloat trailing;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


- (UIView * (^)(CGFloat))de_leading;
- (UIView * (^)(CGFloat))de_trailing;
- (UIView * (^)(CGFloat))de_top;
- (UIView * (^)(CGFloat))de_bottom;
- (UIView * (^)(CGFloat))de_width;
- (UIView * (^)(CGFloat))de_height;
- (UIView * (^)(CGFloat))de_centerX;
- (UIView * (^)(CGFloat))de_centerY;
- (UIView * (^)(CGPoint))de_center;
@end


