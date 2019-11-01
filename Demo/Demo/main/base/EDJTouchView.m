//
//  EDJTouchView.m
//  Demo
//
//  Created by 刘杨 on 2019/10/18.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJTouchView.h"

@implementation EDJTouchView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}
@end

@implementation EDJScrollTouchView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self && !self.isDragging) {
        return nil;
    }
    return hitView;
}
@end


@implementation EDJTableTouchView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self && !self.isDragging) {
        return nil;
    }
    return hitView;
}
@end


@implementation EDJCollectionTouchView
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self && !self.isDragging) {
        return nil;
    }
    return hitView;
}
@end
