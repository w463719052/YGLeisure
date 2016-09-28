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
    
    _lbl = [[UILabel alloc] initWithFrame:CGRectMake(160, 100, 50, 20)];
    _lbl.backgroundColor = [UIColor greenColor];
    _lbl.textAlignment = NSTextAlignmentCenter;
    _lbl.adjustsFontSizeToFitWidth = YES;
//    [self.superview addSubview:_lbl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [self addGestureRecognizer:tap];
    
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    imageView1.backgroundColor = [UIColor redColor];
//    imageView1.image = [UIImage imageNamed:@"箭头左"];
//    [self addSubview:imageView1];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor redColor];
    self.textAlignment = NSTextAlignmentCenter;
    self.text = @"11.5cm";
    self.font = [UIFont systemFontOfSize:9];
    self.adjustsFontSizeToFitWidth = YES;
}

- (void)tapPress:(UITapGestureRecognizer *)send {
    _lbl.text = @"122";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _loaction = [[touches anyObject] locationInView:self];
    if (_loaction.x > _currentSize.width-20) {
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:_lbl];
    } else if (_loaction.x < 20) {
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:_lbl];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    self.transform = [self solveTransformWithPoint:currentP center:CGPointMake(self.layer.position.x+self.transform.tx, self.layer.position.y+self.transform.ty)];
//    _lbl.frame = CGRectMake((150-150/(self.transform.a+self.transform.b+0.000001))/2, 0, 150/(self.transform.a+self.transform.b), 20);
//    _lbl.center = self.center;
    
//    if (!_lbl) {
//        _lbl = [[UILabel alloc] initWithFrame:self.frame];
//        _lbl.backgroundColor = [UIColor greenColor];
//        _lbl.textAlignment = NSTextAlignmentCenter;
//        _lbl.adjustsFontSizeToFitWidth = YES;
//        _lbl.layer.anchorPoint = CGPointMake(0, 0.5);
        [self.superview addSubview:_lbl];
//    }
    _lbl.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, self.transform.tx+(150*(self.transform.a)-50)/2, self.transform.ty+150*(self.transform.b)/2);
//    _lbl.center = CGPointMake(self.center.x+50*self.transform.a, self.center.y);
    NSLog(@"%f,%f,%f,%f,%f,%f",self.transform.a,self.transform.b,self.transform.c,self.transform.d,self.transform.tx,self.transform.ty);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:_lbl];
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

- (CGAffineTransform)solveTransformWithPoint:(CGPoint)point center:(CGPoint)center {
    CGFloat x1 = point.x - center.x;
    CGFloat y1 = point.y - center.y;
    CGFloat s = y1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat c = x1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat d = sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat e = fabs(d)/_currentSize.width-1;
    
    if (_loaction.x > _currentSize.width-20) {
//        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
        return CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
    } else if (_loaction.x < 20) {
//        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
        return CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
    } else {
//        [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
//      return  CGAffineTransformTranslate(self.transform, (x1-x2)*self.transform.a+(y1-y2)*self.transform.b, (y1-y2)*self.transform.d+(x1-x2)*self.transform.c);
//        return  CGAffineTransformTranslate(self.transform, (x1-x2)*self.transform.d+(y1-y2)*self.transform.b, (y1-y2)*self.transform.d+(x1-x2)*self.transform.c);
        CGFloat sss = _loaction.x-_currentSize.width/2;
        CGFloat ddd = _loaction.y-_currentSize.height/2;
        return  CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-sss*self.transform.a-ddd*self.transform.c, y1+self.transform.ty-sss*self.transform.b-ddd*self.transform.d);
    };
}

- (CGAffineTransform)lblSolveTransformWithPoint:(CGPoint)point center:(CGPoint)center {
    CGFloat x1 = point.x - center.x;
    CGFloat y1 = point.y - center.y;
    CGFloat s = y1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat c = x1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat d = sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat e = fabs(d)/_currentSize.width-1;
    
    if (_loaction.x > _currentSize.width-20) {
        //        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
        return CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
    } else if (_loaction.x < 20) {
        //        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
        return CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
    } else {
        //        [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
        //      return  CGAffineTransformTranslate(self.transform, (x1-x2)*self.transform.a+(y1-y2)*self.transform.b, (y1-y2)*self.transform.d+(x1-x2)*self.transform.c);
        //        return  CGAffineTransformTranslate(self.transform, (x1-x2)*self.transform.d+(y1-y2)*self.transform.b, (y1-y2)*self.transform.d+(x1-x2)*self.transform.c);
        CGFloat sss = _loaction.x-_currentSize.width/2;
        CGFloat ddd = _loaction.y-_currentSize.height/2;
        return  CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-sss*self.transform.a-ddd*self.transform.c, y1+self.transform.ty-sss*self.transform.b-ddd*self.transform.d);
    };
}


@end
