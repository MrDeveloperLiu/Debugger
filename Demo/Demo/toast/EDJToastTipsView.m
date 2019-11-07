//
//  EDJToastTipsView.m
//  edaijia
//
//  Created by 刘杨 on 2019/5/6.
//

#import "EDJToastTipsView.h"

#define kRadius(_r) ((M_PI * _r) / 180.0)

@implementation EDJToastTipsView

- (instancetype)init{
    self = [super init];
    [self reset_setBackgroundColor:[UIColor clearColor]];
    _trangleMode = EDJToastTipsViewTrangleModeTop;
    _tranglePosition = EDJToastTipsViewTranglePositionMiddle;
    _trangleSize = CGSizeMake(10, 6);
    _color = [UIColor grayColor];
    return self;
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{}
- (void)reset_setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
}
- (void)didRenderBackground{}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    switch (_trangleMode) {
        case EDJToastTipsViewTrangleModeNull:
            break;
        case EDJToastTipsViewTrangleModeTop:
            [self drawTrangleModeTopRect:rect context:contextRef];
            break;
        case EDJToastTipsViewTrangleModeBottom:
            [self drawTrangleModeBottomRect:rect context:contextRef];
            break;
        case EDJToastTipsViewTrangleModeLeft:
            [self drawTrangleModeLeftRect:rect context:contextRef];
            break;
        case EDJToastTipsViewTrangleModeRight:
            [self drawTrangleModeRightRect:rect context:contextRef];
            break;
        case EDJToastTipsViewTrangleModeTest:
            [self drawTest:rect context:contextRef];
            break;
        default: {
        } break;
    }
    [self fillPath:contextRef];
    [self didRenderBackground];
}

- (void)fillPath:(CGContextRef)contextRef{
    [_color setFill];
    CGContextFillPath(contextRef);
}

- (void)drawTest:(CGRect)rect context:(CGContextRef)contextRef{
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    
    CGFloat radius = 5;
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x - radius, center.y, radius, kRadius(0), kRadius(90), 0);
    [[UIColor redColor] setStroke];
    CGContextStrokePath(contextRef);

    
    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y - radius, radius, kRadius(90), kRadius(180), 0);
    [[UIColor orangeColor] setStroke];
    CGContextStrokePath(contextRef);

    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x + radius, center.y, radius, kRadius(180), kRadius(270), 0);
    [[UIColor yellowColor] setStroke];
    CGContextStrokePath(contextRef);

    CGContextMoveToPoint(contextRef, center.x, center.y);
    CGContextAddArc(contextRef, center.x, center.y + radius, radius, kRadius(270), kRadius(360), 0);
    [[UIColor greenColor] setStroke];
    CGContextStrokePath(contextRef);
}

- (CGFloat)centerHorizontal:(CGSize)size{
    CGFloat centerHorizontal = 0;
    if (_tranglePosition == EDJToastTipsViewTranglePositionLeft) {
        centerHorizontal = _trangleSize.width * 0.5;
    }else if (_tranglePosition == EDJToastTipsViewTranglePositionMiddle){
        centerHorizontal = size.width * 0.5;
    }else if (_tranglePosition == EDJToastTipsViewTranglePositionRight){
        centerHorizontal = size.width - _trangleSize.width * 0.5;
    }
    centerHorizontal += _positionOffset;
    return centerHorizontal;
}

- (CGFloat)centercenterVertical:(CGSize)size{
    CGFloat centerVertical = 0;
    if (_tranglePosition == EDJToastTipsViewTranglePositionLeft) {
        if (_trangleMode == EDJToastTipsViewTrangleModeLeft) {
            centerVertical = size.height - _trangleSize.width * 0.5;
        }else{
            centerVertical = _trangleSize.width * 0.5;
        }
    }else if (_tranglePosition == EDJToastTipsViewTranglePositionMiddle){
        centerVertical = size.height * 0.5;
    }else if (_tranglePosition == EDJToastTipsViewTranglePositionRight){
        if (_trangleMode == EDJToastTipsViewTrangleModeLeft) {
            centerVertical = _trangleSize.width * 0.5;
        }else{
            centerVertical = size.height - _trangleSize.width * 0.5;
        }
    }
    centerVertical += _positionOffset;
    return centerVertical;
}

- (void)drawTrangleModeTopRect:(CGRect)rect context:(CGContextRef)contextRef{
    CGSize size = rect.size;
    
    CGFloat centerHorizontal = [self centerHorizontal:size];
    CGFloat trangleHorizontalRadius = _trangleSize.width * 0.5;
    
    CGFloat trangleHorizontalLeft = centerHorizontal - trangleHorizontalRadius;
    CGFloat trangleHorizontalRight = centerHorizontal + trangleHorizontalRadius;
    CGFloat trangleVertical = _trangleSize.height;
    CGFloat radius = _contentRadius;
    //三角左边
    CGContextMoveToPoint(contextRef, trangleHorizontalLeft, trangleVertical);
    //三角尖
    CGContextAddLineToPoint(contextRef, centerHorizontal, 0);
    //三角右边
    CGContextAddLineToPoint(contextRef, trangleHorizontalRight, trangleVertical);
    //右边角
    CGContextAddLineToPoint(contextRef, size.width, trangleVertical);
    if (radius)
    CGContextAddArc(contextRef, size.width - radius, trangleVertical + radius, radius, kRadius(270), kRadius(0), 0);
    //右下边角
    CGContextAddLineToPoint(contextRef, size.width, size.height);
    if (radius)
    CGContextAddArc(contextRef, size.width - radius, size.height - radius, radius, kRadius(0), kRadius(90), 0);
    //左下边角
    CGContextAddLineToPoint(contextRef, 0, size.height);
    if (radius)
    CGContextAddArc(contextRef, radius, size.height - radius, radius, kRadius(90), kRadius(180), 0);
    //右上边角
    CGContextAddLineToPoint(contextRef, 0, trangleVertical);
    if (radius)
    CGContextAddArc(contextRef, radius, trangleVertical + radius, radius, kRadius(180), kRadius(270), 0);
    //三角左边
    CGContextAddLineToPoint(contextRef, trangleHorizontalLeft, trangleVertical);
    
    _trangleRect = CGRectMake(0, 0, size.width, _trangleSize.height);
    _contentRect = CGRectMake(0, trangleVertical, size.width, size.height - trangleVertical);
}

- (void)drawTrangleModeBottomRect:(CGRect)rect context:(CGContextRef)contextRef{
    CGSize size = rect.size;
    
    CGFloat centerHorizontal = [self centerHorizontal:size];
    CGFloat trangleHorizontalRadius = _trangleSize.width * 0.5;
    
    CGFloat trangleHorizontalLeft = centerHorizontal - trangleHorizontalRadius;
    CGFloat trangleHorizontalRight = centerHorizontal + trangleHorizontalRadius;
    CGFloat trangleVertical = size.height - _trangleSize.height;
    CGFloat radius = _contentRadius;
    //三角左边
    CGContextMoveToPoint(contextRef, trangleHorizontalLeft, trangleVertical);
    //三角尖
    CGContextAddLineToPoint(contextRef, centerHorizontal, size.height);
    //三角右边
    CGContextAddLineToPoint(contextRef, trangleHorizontalRight, trangleVertical);
    //右边角
    CGContextAddLineToPoint(contextRef, size.width, trangleVertical);
    if (radius)
    CGContextAddArc(contextRef, size.width - radius, trangleVertical - radius, radius, kRadius(90), kRadius(0), 1);
    //右下边角
    CGContextAddLineToPoint(contextRef, size.width, 0);
    if (radius)
    CGContextAddArc(contextRef, size.width - radius, radius, radius, kRadius(0), kRadius(270), 1);
    //左下边角
    CGContextAddLineToPoint(contextRef, 0, 0);
    if (radius)
    CGContextAddArc(contextRef, radius, radius, radius, kRadius(270), kRadius(180), 1);
    //右上边角
    CGContextAddLineToPoint(contextRef, 0, trangleVertical);
    if (radius)
    CGContextAddArc(contextRef, radius, trangleVertical - radius, radius, kRadius(180), kRadius(90), 1);
    //三角左边
    CGContextAddLineToPoint(contextRef, trangleHorizontalLeft, trangleVertical);
    
    _trangleRect = CGRectMake(0, trangleVertical, size.width, _trangleSize.height);
    _contentRect = CGRectMake(0, 0, size.width, trangleVertical);
}

- (void)drawTrangleModeLeftRect:(CGRect)rect context:(CGContextRef)contextRef{
    CGSize size = rect.size;

    CGFloat centerVertical = [self centercenterVertical:size];
    CGFloat trangleHorizontalRadius = _trangleSize.width * 0.5;
    
    CGFloat trangleVerticalLeft = centerVertical - trangleHorizontalRadius;
    CGFloat trangleVerticalRight = centerVertical + trangleHorizontalRadius;
    CGFloat trangleHorizontal = _trangleSize.height;
    CGFloat radius = _contentRadius;
    //三角左边
    CGContextMoveToPoint(contextRef, trangleHorizontal, trangleVerticalLeft);
    //三角尖
    CGContextAddLineToPoint(contextRef, 0, centerVertical);
    //三角右边
    CGContextAddLineToPoint(contextRef, trangleHorizontal, trangleVerticalRight);
    //右边角
    CGContextAddLineToPoint(contextRef, trangleHorizontal, 0);
    if (radius)
    CGContextAddArc(contextRef, trangleHorizontal + radius, radius, radius, kRadius(180), kRadius(270), 0);
    //右下边角
    CGContextAddLineToPoint(contextRef, size.width, 0);
    if (radius)
    CGContextAddArc(contextRef, size.width - radius, radius, radius, kRadius(270), kRadius(0), 0);
    //左下边角
    CGContextAddLineToPoint(contextRef, size.width, size.height);
    if (radius)
    CGContextAddArc(contextRef, size.width - radius, size.height - radius, radius, kRadius(0), kRadius(90), 0);
    //右上边角
    CGContextAddLineToPoint(contextRef, trangleHorizontal, size.height);
    if (radius)
    CGContextAddArc(contextRef, trangleHorizontal + radius, size.height - radius, radius, kRadius(90), kRadius(180), 0);
    //三角左边
    CGContextAddLineToPoint(contextRef, trangleHorizontal, trangleVerticalLeft);
    
    _trangleRect = CGRectMake(0, 0, _trangleSize.height, size.height);
    _contentRect = CGRectMake(trangleHorizontal, 0, size.width - trangleHorizontal, size.height);
}

- (void)drawTrangleModeRightRect:(CGRect)rect context:(CGContextRef)contextRef{
    CGSize size = rect.size;
    
    CGFloat centerVertical = [self centercenterVertical:size];
    CGFloat trangleHorizontalRadius = _trangleSize.width * 0.5;
    
    CGFloat trangleVerticalLeft = centerVertical - trangleHorizontalRadius;
    CGFloat trangleVerticalRight = centerVertical + trangleHorizontalRadius;
    CGFloat trangleHorizontal = size.width - _trangleSize.height;
    CGFloat radius = _contentRadius;
    //三角左边
    CGContextMoveToPoint(contextRef, trangleHorizontal, trangleVerticalLeft);
    //三角尖
    CGContextAddLineToPoint(contextRef, size.width, centerVertical);
    //三角右边
    CGContextAddLineToPoint(contextRef, trangleHorizontal, trangleVerticalRight);
    //右边角
    CGContextAddLineToPoint(contextRef, trangleHorizontal, size.height);
    if (radius)
    CGContextAddArc(contextRef, trangleHorizontal - radius, size.height - radius, radius, kRadius(0), kRadius(90), 0);
    //右下边角
    CGContextAddLineToPoint(contextRef, 0, size.height);
    if (radius)
    CGContextAddArc(contextRef, radius, size.height - radius, radius, kRadius(90), kRadius(180), 0);
    //左下边角
    CGContextAddLineToPoint(contextRef, 0, 0);
    if (radius)
    CGContextAddArc(contextRef, radius, radius, radius, kRadius(180), kRadius(270), 0);
    //右上边角
    CGContextAddLineToPoint(contextRef, trangleHorizontal, 0);
    if (radius)
    CGContextAddArc(contextRef, trangleHorizontal - radius, radius, radius, kRadius(270), kRadius(0), 0);
    //三角左边
    CGContextAddLineToPoint(contextRef, trangleHorizontal, trangleVerticalLeft);
    
    _trangleRect = CGRectMake(trangleHorizontal, 0, _trangleSize.height, size.height);
    _contentRect = CGRectMake(0, 0, trangleHorizontal, size.height);
}

@end

