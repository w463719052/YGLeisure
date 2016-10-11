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
    
}
@end

@implementation YGDrawingLineView

- (void)deleteView {
    [self removeFromSuperview];
    [_field removeFromSuperview];
    [_imageView1 removeFromSuperview];
    [_imageView2 removeFromSuperview];
}

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(160, 100, 150, 20);
        _currentSize = self.frame.size;
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, 150, 2)];
//    imageView1.backgroundColor = [UIColor redColor];
    imageView1.image = [UIImage imageNamed:@"紫-"];
    [self addSubview:imageView1];
    self.userInteractionEnabled = YES;
    
}

- (void)addField {
    _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
//    _field.backgroundColor = [UIColor greenColor];
    _field.textAlignment = NSTextAlignmentCenter;
    _field.adjustsFontSizeToFitWidth = YES;
    _field.userInteractionEnabled = NO;
    [self.superview addSubview:_field];
    _field.center = self.center;
    
    _field1 = [[UITextField alloc] initWithFrame:CGRectMake(0, -5, 1, 20)];
    _field1.textColor = [UIColor yellowColor];
    _field1.textAlignment = NSTextAlignmentCenter;
    _field1.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:@"请输入"];
    [colorStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(0,colorStr.length)];
    _field1.attributedPlaceholder = colorStr;
    [_field1 sizeToFit];
    _field1.center = CGPointMake(0.5, -5);
    _field1.font = [UIFont systemFontOfSize:12];
    _field1.userInteractionEnabled = NO;
    [_field addSubview:_field1];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(155, 101, 10, 18)];
    _imageView1.image = [UIImage imageNamed:@"紫1"];
    _imageView1.tag = 1;
    [self.superview addSubview:_imageView1];
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(305, 101, 10, 18)];
    _imageView2.image = [UIImage imageNamed:@"紫2"];
    _imageView2.tag = 2;
    [self.superview addSubview:_imageView2];
    
}

- (void)setField1TextWithInfo:(YGSetPropertyInfo *)info {
    _info = info;
    _field1.text = [NSString stringWithFormat:@"%@:%@%@%@,%@",info.identification,info.type,info.number,info.unit,info.custom];
    [_field1 sizeToFit];
    _field1.center = CGPointMake(0.5, -5);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _loaction = [[touches anyObject] locationInView:self];
    _currentTouch = [[touches anyObject] locationInView:self.superview];
    _imageView1Transform = _imageView1.transform;
    _imageView2Transform = _imageView2.transform;
    _fieldTransform = _field.transform;
    _selfTransform = self.transform;
    
    if (_loaction.x > _currentSize.width-15) {
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
    } else if (_loaction.x < 15) {
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    [self solveTransformWithPoint:currentP center:CGPointMake(self.layer.position.x+self.transform.tx, self.layer.position.y+self.transform.ty)];
    
    if (!_magnifierView) {
        _magnifierView = [[YGMagnifierView alloc] init];
        _magnifierView.viewToMagnify = self.window;
    }
    [self.window addSubview:_magnifierView];
    _magnifierView.touchPoint = [touch locationInView:self.window];
    [_magnifierView setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setAnchorPoint:CGPointMake(0.5f, 0.5f) forView:self];
    [_magnifierView removeFromSuperview];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
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
    if (_loaction.x > _currentSize.width-15) {
        self.transform = CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx+(150*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty+(150*(self.transform.b-_selfTransform.b))/2);
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView1Transform.tx, _imageView1Transform.ty);
        _imageView2.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView2Transform.tx+(150*(self.transform.a-_selfTransform.a)), _imageView2Transform.ty+(150*(self.transform.b-_selfTransform.b)));
        
    } else if (_loaction.x < 15) {
        self.transform = CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-(150*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty-(150*(self.transform.b-_selfTransform.b))/2);
        
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView1Transform.tx-(150*(self.transform.a-_selfTransform.a)), _imageView1Transform.ty-(150*(self.transform.b-_selfTransform.b)));
        _imageView2.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView2Transform.tx, _imageView2Transform.ty);
    } else {
        CGFloat sss = _loaction.x-_currentSize.width/2;
        CGFloat ddd = _loaction.y-_currentSize.height/2;
        self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-sss*self.transform.a-ddd*self.transform.c, y1+self.transform.ty-sss*self.transform.b-ddd*self.transform.d);
        _field.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-_selfTransform.tx+self.transform.tx, _fieldTransform.ty-_selfTransform.ty+self.transform.ty);
        
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d,_imageView1Transform.tx-_selfTransform.tx+self.transform.tx, _imageView1Transform.ty-_selfTransform.ty+self.transform.ty);
        _imageView2.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d,_imageView2Transform.tx-_selfTransform.tx+self.transform.tx, _imageView2Transform.ty-_selfTransform.ty+self.transform.ty);
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
