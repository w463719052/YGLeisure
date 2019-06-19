//
//  YGProportionRingView.m
//  我的轮子
//
//  Created by XuQibin on 2018/5/9.
//  Copyright © 2018年 com.zccl. All rights reserved.
//

#import "YGProportionRingView.h"

@implementation YGProportionRingView

- (void)buildBackgroundLayer:(CGRect)rect {
    if (!_circleLayer0) {
        CGFloat kCircleLineWidth = CGRectGetWidth(rect)*0.11;
        for (int i = 0; i<3; i++) {
            CGFloat interval = (kCircleLineWidth+1);
            CGFloat radius = (CGRectGetWidth(rect)-2*i*interval)/2;
            CGFloat proportion = ((radius-(kCircleLineWidth)*(3-i))/radius);
            UIBezierPath *cicrle = [UIBezierPath bezierPath];
            [cicrle moveToPoint:CGPointMake(0, i*interval)];
            [cicrle addLineToPoint:CGPointMake(rect.size.width/2, i*interval)];
            [cicrle addArcWithCenter:CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)) radius:radius startAngle:M_PI * 3 / 2 endAngle:M_PI * 6 / 2+M_PI/2*proportion clockwise:YES];
            
            CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
            backgroundLayer.strokeColor = [UIColor lightGrayColor].CGColor;
            backgroundLayer.lineWidth = kCircleLineWidth;
            backgroundLayer.lineJoin = kCALineJoinRound;
            backgroundLayer.lineCap = kCALineCapRound;
            backgroundLayer.path = cicrle.CGPath;
            backgroundLayer.fillColor = [UIColor clearColor].CGColor;
            [self.layer addSublayer:backgroundLayer];
            
            CAShapeLayer *circleLayer = [CAShapeLayer layer];
            circleLayer.strokeColor = [UIColor greenColor].CGColor;
            circleLayer.lineWidth = kCircleLineWidth;
            circleLayer.lineJoin = kCALineJoinRound;
            circleLayer.lineCap = kCALineCapRound;
            circleLayer.path = cicrle.CGPath;
            circleLayer.fillColor = [UIColor clearColor].CGColor;
            circleLayer.strokeStart = 0;
            circleLayer.strokeEnd = 0;
            [self.layer addSublayer:circleLayer];
            if (i == 0) {
                _circleLayer0 = circleLayer;
            } else if (i == 1) {
                _circleLayer1 = circleLayer;
            } else if (i == 2) {
                _circleLayer2 = circleLayer;
            }
        }
    }
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [self buildBackgroundLayer:rect];
    if (_progress) {
        CABasicAnimation *progressAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        progressAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        progressAnimation.duration = _progress*2;
        progressAnimation.fromValue = @(0);
        progressAnimation.toValue = @(_progress);
        progressAnimation.removedOnCompletion = NO;
        progressAnimation.fillMode = kCAFillModeForwards;
        [_circleLayer0 addAnimation:progressAnimation forKey:@"progressAnimation"];
        
        [_circleLayer1 addAnimation:progressAnimation forKey:@"progressAnimation"];
        
        [_circleLayer2 addAnimation:progressAnimation forKey:@"progressAnimation"];
    }
}

@end
