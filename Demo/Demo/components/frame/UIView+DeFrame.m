//
//  UIView+DeFrame.m
//  Demo
//
//  Created by 刘杨 on 2019/6/19.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIView+DeFrame.h"


@implementation UIView (DeFrame)
- (void)setLeading:(CGFloat)leading{
    CGRect frame = self.frame;
    frame.origin.x = leading;
    self.frame = frame;    
}
- (CGFloat)leading{
    return CGRectGetMinX(self.frame);
}

- (void)setTrailing:(CGFloat)trailing{
    CGRect frame = self.frame;
    frame.origin.x = trailing - frame.size.width;
    self.frame = frame;
}
- (CGFloat)trailing{
    return CGRectGetMaxX(self.frame);
}

- (void)setTop:(CGFloat)top{
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)top{
    return CGRectGetMinY(self.frame);
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width{
    return CGRectGetWidth(self.frame);;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return CGRectGetHeight(self.frame);;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}


- (UIView * (^)(CGFloat))de_leading{
    return ^UIView *(CGFloat v){
        self.leading = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_trailing{
    return ^UIView *(CGFloat v){
        self.trailing = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_top{
    return ^UIView *(CGFloat v){
        self.top = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_bottom{
    return ^UIView *(CGFloat v){
        self.bottom = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_width{
    return ^UIView *(CGFloat v){
        self.width = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_height{
    return ^UIView *(CGFloat v){
        self.height = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_centerX{
    return ^UIView *(CGFloat v){
        self.centerX = v;
        return self;
    };
}
- (UIView * (^)(CGFloat))de_centerY{
    return ^UIView *(CGFloat v){
        self.centerY = v;
        return self;
    };
}
- (UIView *(^)(CGPoint))de_center{
    return ^UIView *(CGPoint v){
        self.center = v;
        return self;
    };
}
- (UIView * (^)(CGPoint))de_origin{
    return ^UIView *(CGPoint v){
        self.origin = v;
        return self;
    };
}
- (UIView * (^)(CGSize))de_size{
    return ^UIView *(CGSize v){
        self.size = v;
        return self;
    };
}
@end
