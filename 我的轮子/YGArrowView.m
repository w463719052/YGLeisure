//
//  YGArrowView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/18.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGArrowView.h"
#import "YGTool.h"

static NSInteger const Width = 60;
static NSInteger const Height = 30;
static NSInteger const lineHeight = 2;
static NSInteger const imageVieWidth = 10;
static NSInteger const imageVieHeight = 18;

static NSInteger const ClickRange = 25;

@implementation YGArrowView

- (void)deleteView {
    [self removeFromSuperview];
    [_imageView1 removeFromSuperview];
}

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(40, 60, Width, Height);
        self.userInteractionEnabled = YES;
        _currentSize = self.frame.size;
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (Height-lineHeight)/2, Width, lineHeight)];
    imageView.layer.shouldRasterize = YES;
    imageView.image = [UIImage imageNamed:@"红-"];
    [self addSubview:imageView];
    self.userInteractionEnabled = YES;
}

- (void)addImageView {
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame)-imageVieHeight/2, imageVieWidth, imageVieHeight)];
    _imageView1.image = [UIImage imageNamed:@"箭头红"];
    _imageView1.tag = 1;
    [self.superview addSubview:_imageView1];
    [self setAnchorPoint:CGPointMake(0, 0.5) forView:_imageView1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _loaction = [[touches anyObject] locationInView:self];
    _imageView1Transform = _imageView1.transform;
    _selfTransform = self.transform;
    
    if (_loaction.x > _currentSize.width-ClickRange) {
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
    } else if (_loaction.x < ClickRange) {
        [self setAnchorPoint:CGPointMake(1, 0.5) forView:self];
    }
    if (!_magnifierView) {
        _magnifierView = [[YGMagnifierView alloc] init];
        _magnifierView.viewToMagnify = self.window;
    }
    [self.window addSubview:_magnifierView];
    CGPoint point = [[touches anyObject] locationInView:self.window];
    [self setMagniferViewFrameWithPoint:point];
    [_magnifierView setPointToMagnify:point];
}

- (void)setMagniferViewFrameWithPoint:(CGPoint)point {
    CGRect frame = _magnifierView.frame;
    if (point.x>ScreenWidth/2) {
        frame.origin.x = 10;
    } else {
        frame.origin.x = ScreenWidth-100-10;
    }
    _magnifierView.frame = frame;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    if (currentP.y > 0 && currentP.y < self.superview.frame.size.height) {
        [self solveTransformWithPoint:currentP center:CGPointMake(self.layer.position.x+self.transform.tx, self.layer.position.y+self.transform.ty)];
        CGPoint point = [touch locationInView:self.window];
        [self setMagniferViewFrameWithPoint:point];
        if (_loaction.x < ClickRange || _loaction.x > _currentSize.width-ClickRange) {
            [_magnifierView setPointToMagnify:point];
        } else {
            [_magnifierView setPointToMagnify:CGPointMake(CGRectGetMidX(_imageView1.frame), CGRectGetMidY(_imageView1.frame)+64)];
        }
    }
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
    if (_loaction.x > _currentSize.width-ClickRange) {
        self.transform = CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView1Transform.tx, _imageView1Transform.ty);
    } else if (_loaction.x < ClickRange) {
        self.transform = CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView1Transform.tx-(Width*(self.transform.a-_selfTransform.a)), _imageView1Transform.ty-(Width*(self.transform.b-_selfTransform.b)));
    } else {
        CGFloat distanceX = _loaction.x-_currentSize.width/2;
        CGFloat distanceY = _loaction.y-_currentSize.height/2;
        self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-distanceX*self.transform.a-distanceY*self.transform.c, y1+self.transform.ty-distanceX*self.transform.b-distanceY*self.transform.d);
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d,_imageView1Transform.tx-_selfTransform.tx+self.transform.tx, _imageView1Transform.ty-_selfTransform.ty+self.transform.ty);
    };
}


@end
