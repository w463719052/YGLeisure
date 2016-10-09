//
//  YGDrawingArrowView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingArrowView.h"

@implementation YGDrawingArrowView

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(13, 100, 150, 25);
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
//    [self addGestureRecognizer:tap];
    
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//    imageView1.backgroundColor = [UIColor redColor];
//    imageView1.image = [UIImage imageNamed:@"箭头左"];
//    [self addSubview:imageView1];
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 25)];
    arrow.image = [UIImage imageNamed:@"jt"];
    [self addSubview:arrow];
    
    self.userInteractionEnabled = YES;
    [self addField];
}

- (void)addField {
    _field = [[UITextField alloc] initWithFrame:CGRectMake(13, -5, 140, 20)];
//    _field.backgroundColor = [UIColor whiteColor];
//    _field.textAlignment = NSTextAlignmentCenter;
    _field.adjustsFontSizeToFitWidth = YES;
    _field.placeholder = @"请输入标注内容";
    _field.textColor = [UIColor yellowColor];
    _field.font = [UIFont systemFontOfSize:12];
//    _field.delegate = self;
    //    _field.userInteractionEnabled = NO;
    [self addSubview:_field];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [textField sizeToFit];
    return YES;
}

- (void)tapPress:(UITapGestureRecognizer *)send {
    _field.text = @"122";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    _loaction = [[touches anyObject] locationInView:self];
//    _fieldTransform = _field.transform;
//    _selfTransform = self.transform;
//    if (_loaction.x > _currentSize.width-20) {
//        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
//    } else if (_loaction.x < 20) {
//        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
//    }
    if (!_magnifierView) {
        _magnifierView = [[YGMagnifierView alloc] init];
        _magnifierView.viewToMagnify = self.window;
    }
    [self.window addSubview:_magnifierView];
    _magnifierView.touchPoint = [[touches anyObject] locationInView:self.window];
    [_magnifierView setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    
    self.transform = CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
    
    _magnifierView.touchPoint = [touch locationInView:self.window];;
    [_magnifierView setNeedsDisplay];
    //    [self solveTransformWithPoint:currentP center:CGPointMake(self.layer.position.x+self.transform.tx, self.layer.position.y+self.transform.ty)];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_magnifierView removeFromSuperview];
//    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
}

//- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view
//{
//    CGPoint oldOrigin = view.frame.origin;
//    view.layer.anchorPoint = anchorPoint;
//    CGPoint newOrigin = view.frame.origin;
//    CGPoint transition;
//    transition.x = newOrigin.x - oldOrigin.x;
//    transition.y = newOrigin.y - oldOrigin.y;
//    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
//}

- (void)solveTransformWithPoint:(CGPoint)point center:(CGPoint)center {
    CGFloat x1 = point.x - center.x;
    CGFloat y1 = point.y - center.y;
//    CGFloat s = y1/sqrt(pow(y1, 2)+pow(x1, 2));
//    CGFloat c = x1/sqrt(pow(y1, 2)+pow(x1, 2));
//    CGFloat d = sqrt(pow(y1, 2)+pow(x1, 2));
//    CGFloat e = fabs(d)/_currentSize.width-1;
    
    self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx, y1+self.transform.ty);
//    if (_loaction.x > _currentSize.width-20) {
//        self.transform = CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
//        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx+(150*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty+(150*(self.transform.b-_selfTransform.b))/2);
//    } else if (_loaction.x < 20) {
//        self.transform = CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
//        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-(150*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty-(150*(self.transform.b-_selfTransform.b))/2);
//    } else {
//        CGFloat sss = _loaction.x-_currentSize.width/2;
//        CGFloat ddd = _loaction.y-_currentSize.height/2;
//        self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-sss*self.transform.a-ddd*self.transform.c, y1+self.transform.ty-sss*self.transform.b-ddd*self.transform.d);
//        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-_selfTransform.tx+self.transform.tx, _fieldTransform.ty-_selfTransform.ty+self.transform.ty);
//    };
}
@end
