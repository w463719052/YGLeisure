//
//  YGDrawingLineView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingLineView.h"

@interface YGDrawingLineView ()<UITextFieldDelegate>
{
    UITextField *_field1;
}
@end

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress:)];
    [self addGestureRecognizer:tap];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 6, 150, 8)];
//    imageView1.backgroundColor = [UIColor redColor];
    imageView1.image = [UIImage imageNamed:@"箭头"];
    [self addSubview:imageView1];
    self.userInteractionEnabled = YES;
//    self.backgroundColor = [UIColor redColor];
    self.textAlignment = NSTextAlignmentCenter;
//    self.text = @"11.5cm";
    self.font = [UIFont systemFontOfSize:9];
    self.adjustsFontSizeToFitWidth = YES;
}

- (void)addField {
    _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
//    _field.backgroundColor = [UIColor greenColor];
    _field.textAlignment = NSTextAlignmentCenter;
    _field.adjustsFontSizeToFitWidth = YES;
    _field.placeholder = @"?";
    _field.delegate = self;
//    _field.userInteractionEnabled = NO;
    [self.superview addSubview:_field];
    _field.center = self.center;
    
    _field1 = [[UITextField alloc] initWithFrame:CGRectMake(-10, -20, 20, 20)];
//    _field1.backgroundColor = [UIColor blueColor];
    _field1.textColor = [UIColor yellowColor];
    _field1.textAlignment = NSTextAlignmentCenter;
    _field1.adjustsFontSizeToFitWidth = YES;
    _field1.placeholder = @"?";
    _field1.delegate = self;
    //    field1.userInteractionEnabled = NO;
    [_field addSubview:_field1];
    
//    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(-75, 0, 20, 20)];
//    imageView1.backgroundColor = [UIColor greenColor];
//    [_field addSubview:imageView1];
//    
//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(55, 0, 20, 20)];
//    imageView2.backgroundColor = [UIColor greenColor];
//    [_field addSubview:imageView2];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [textField sizeToFit];
    _field1.center = CGPointMake(0.5, -10);
    return YES;
}

- (void)tapPress:(UITapGestureRecognizer *)send {
    [_field1 becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _loaction = [[touches anyObject] locationInView:self];
    _fieldTransform = _field.transform;
    _selfTransform = self.transform;
    if (_loaction.x > _currentSize.width-20) {
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
    } else if (_loaction.x < 20) {
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
    }
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
    [self solveTransformWithPoint:currentP center:CGPointMake(self.layer.position.x+self.transform.tx, self.layer.position.y+self.transform.ty)];
    
    _magnifierView.touchPoint = [touch locationInView:self.window];
    [_magnifierView setNeedsDisplay];
//    NSLog(@"%f,%f,%f,%f,%f,%f",self.transform.a,self.transform.b,self.transform.c,self.transform.d,self.transform.tx,self.transform.ty);
    NSLog(@"%f,%f,%f,%f,%f,%f",_field1.transform.a,_field1.transform.b,_field1.transform.c,_field1.transform.d,_field1.transform.tx,_field1.transform.ty);
//    NSLog(@"********%f,%f",_fieldTransform.tx,_fieldTransform.ty);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
    [_magnifierView removeFromSuperview];
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

- (void)solveTransformWithPoint:(CGPoint)point center:(CGPoint)center {
    CGFloat x1 = point.x - center.x;
    CGFloat y1 = point.y - center.y;
    CGFloat s = y1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat c = x1/sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat d = sqrt(pow(y1, 2)+pow(x1, 2));
    CGFloat e = fabs(d)/_currentSize.width-1;
    if (_loaction.x > _currentSize.width-20) {
        self.transform = CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx+(150*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty+(150*(self.transform.b-_selfTransform.b))/2);
    } else if (_loaction.x < 20) {
        self.transform = CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-(150*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty-(150*(self.transform.b-_selfTransform.b))/2);
    } else {
        CGFloat sss = _loaction.x-_currentSize.width/2;
        CGFloat ddd = _loaction.y-_currentSize.height/2;
        self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-sss*self.transform.a-ddd*self.transform.c, y1+self.transform.ty-sss*self.transform.b-ddd*self.transform.d);
        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-_selfTransform.tx+self.transform.tx, _fieldTransform.ty-_selfTransform.ty+self.transform.ty);
    };
}

//- (void)solveTransformWithPoint:(CGPoint)point center:(CGPoint)center {
//    CGFloat x1 = point.x - center.x;
//    CGFloat y1 = point.y - center.y;
//    CGFloat s = y1/sqrt(pow(y1, 2)+pow(x1, 2));
//    CGFloat c = x1/sqrt(pow(y1, 2)+pow(x1, 2));
//    CGFloat d = sqrt(pow(y1, 2)+pow(x1, 2));
//    CGFloat e = fabs(d)/_currentSize.width-1;
//    if (_loaction.x > _currentSize.width-20) {
//        self.transform = CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
//        _lbl.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _lblTransform.tx+(150*(self.transform.a-_selfTransform.a))/2, _lblTransform.ty+(150*(self.transform.b-_selfTransform.b))/2);
//    } else if (_loaction.x < 20) {
//        self.transform = CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
//        _lbl.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _lblTransform.tx-(150*(self.transform.a-_selfTransform.a))/2, _lblTransform.ty-(150*(self.transform.b-_selfTransform.b))/2);
//    } else {
//        CGFloat sss = _loaction.x-_currentSize.width/2;
//        CGFloat ddd = _loaction.y-_currentSize.height/2;
//        self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-sss*self.transform.a-ddd*self.transform.c, y1+self.transform.ty-sss*self.transform.b-ddd*self.transform.d);
//        _lbl.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _lblTransform.tx-_selfTransform.tx+self.transform.tx, _lblTransform.ty-_selfTransform.ty+self.transform.ty);
//    };
//}


@end
