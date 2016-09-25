//
//  YGDrawingLineView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingLineView.h"

@implementation YGDrawingLineView

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(160, 100, 150, 20);
        _currentSize = self.frame.size;
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:self.bounds];
    lbl.backgroundColor = [UIColor greenColor];
    [self addSubview:lbl];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor redColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.text = @"11.5cm";
    self.font = [UIFont systemFontOfSize:9];
    self.adjustsFontSizeToFitWidth = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _loaction = [[touches anyObject] locationInView:self];
    if (_loaction.x > _currentSize.width-25) {
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
    } else if (_loaction.x < 25) {
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint preP = [touch previousLocationInView:self.superview];
    self.transform = [self solveTransformWithPoint1:currentP Point2:preP center:CGPointMake(self.layer.position.x+self.transform.tx, self.layer.position.y+self.transform.ty)];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
{
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

- (CGAffineTransform)solveTransformWithPoint1:(CGPoint)point1 Point2:(CGPoint)point2 center:(CGPoint)center {
    CGFloat x1 = point1.x - center.x;
    CGFloat y1 = point1.y - center.y;
    CGFloat x2 = point2.x - center.x;
    CGFloat y2 = point2.y - center.y;
    CGFloat s = y1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat c = x1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat d = sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat e = fabs(d)/150-1;
    if (_loaction.x > _currentSize.width-25) {
//        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
        return CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
    } else if (_loaction.x < 25) {
//        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
        return CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
    } else {
//        [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
//      return  CGAffineTransformTranslate(self.transform, (x1-x2)*self.transform.d+(y1-y2)*(-self.transform.c), (y1-y2)*self.transform.d+(x1-x2)*self.transform.c);
//        return  CGAffineTransformTranslate(self.transform, (x1-x2)*self.transform.d+(y1-y2)*self.transform.b, (y1-y2)*self.transform.d+(x1-x2)*self.transform.c);
        return  CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx+30, y1+self.transform.ty);
    };
}


@end
