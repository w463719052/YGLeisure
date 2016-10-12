//
//  YGDrawingLineView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingLineView.h"
#import "YGTool.h"

@interface YGDrawingLineView ()<UITextFieldDelegate>
{
    
}
@end

static NSInteger const Width = 150;
static NSInteger const Height = 30;
static NSInteger const lineHeight = 2;
static NSInteger const imageVieWidth = 15;
static NSInteger const imageVieHeight = 20;

static NSInteger const ClickRange = 20;

@implementation YGDrawingLineView

- (void)deleteView {
    [self removeFromSuperview];
    [_centView removeFromSuperview];
    [_imageView1 removeFromSuperview];
    [_imageView2 removeFromSuperview];
}

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(ScreenWidth/2-Width/2, ScreenWidth/2-Height/2, Width, Height);
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

- (void)addField {
    _centView = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame)-0.5, CGRectGetMidY(self.frame)-Height/2, 1, Height)];
    _centView.userInteractionEnabled = NO;
    [self.superview addSubview:_centView];
    
    _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, Height)];
    _field.textColor = [UIColor redColor];
    _field.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:@"请输入"];
    [colorStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,colorStr.length)];
    _field.attributedPlaceholder = colorStr;
    [_field sizeToFit];
    _field.center = CGPointMake(0.5, 0);
    _field.font = [UIFont systemFontOfSize:12];
    _field.userInteractionEnabled = NO;
    [_centView addSubview:_field];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.frame), CGRectGetMidY(self.frame)-imageVieHeight/2, imageVieWidth, imageVieHeight)];
    _imageView1.image = [UIImage imageNamed:@"红1"];
    _imageView1.tag = 1;
    [self.superview addSubview:_imageView1];
    [self setAnchorPoint:CGPointMake(0, 0.5) forView:_imageView1];
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame)-imageVieWidth, CGRectGetMidY(self.frame)-imageVieHeight/2, imageVieWidth, imageVieHeight)];
    _imageView2.image = [UIImage imageNamed:@"红2"];
    _imageView2.tag = 2;
    [self.superview addSubview:_imageView2];
    [self setAnchorPoint:CGPointMake(1, 0.5) forView:_imageView2];
    
}

- (void)setField1TextWithInfo:(YGSetPropertyInfo *)info {
    _info = info;
    NSString *identification = @"";
    if (![YGTool isBlankString:info.identification]) {
        identification = [NSString stringWithFormat:@"%@:",info.identification];
    }
    NSString *type = @"";
    if (![YGTool isBlankString:info.type]) {
        type = [info.type substringWithRange:NSMakeRange(info.type.length-1, 1)];
    }
    NSString *custom = @"";
    if (![YGTool isBlankString:info.custom]) {
        custom = [NSString stringWithFormat:@",%@",info.custom];
    }
    _field.text = [NSString stringWithFormat:@"%@%@%@%@%@",identification,type,info.number,info.unit,custom];
    [_field sizeToFit];
    _field.center = CGPointMake(0.5, 0);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _loaction = [[touches anyObject] locationInView:self];
    _imageView1Transform = _imageView1.transform;
    _imageView2Transform = _imageView2.transform;
    _fieldTransform = _centView.transform;
    _selfTransform = self.transform;
    
    if (_loaction.x > _currentSize.width-ClickRange) {
        [self setAnchorPoint:CGPointMake(0, 0.5) forView:self];
    } else if (_loaction.x < ClickRange) {
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
    if (_loaction.x > _currentSize.width-ClickRange) {
        self.transform = CGAffineTransformMake(e*c+c, s+e*s, -s, c, self.transform.tx, self.transform.ty);
        _centView.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx+(Width*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty+(Width*(self.transform.b-_selfTransform.b))/2);
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView1Transform.tx, _imageView1Transform.ty);
        _imageView2.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView2Transform.tx+(Width*(self.transform.a-_selfTransform.a)), _imageView2Transform.ty+(Width*(self.transform.b-_selfTransform.b)));
        
    } else if (_loaction.x < ClickRange) {
        self.transform = CGAffineTransformMake(-(e*c+c), -(s+e*s), s, -c, self.transform.tx, self.transform.ty);
        _centView.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-(Width*(self.transform.a-_selfTransform.a))/2, _fieldTransform.ty-(Width*(self.transform.b-_selfTransform.b))/2);
        
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView1Transform.tx-(Width*(self.transform.a-_selfTransform.a)), _imageView1Transform.ty-(Width*(self.transform.b-_selfTransform.b)));
        _imageView2.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _imageView2Transform.tx, _imageView2Transform.ty);
    } else {
        CGFloat distanceX = _loaction.x-_currentSize.width/2;
        CGFloat distanceY = _loaction.y-_currentSize.height/2;
        self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx-distanceX*self.transform.a-distanceY*self.transform.c, y1+self.transform.ty-distanceX*self.transform.b-distanceY*self.transform.d);
        _centView.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d, _fieldTransform.tx-_selfTransform.tx+self.transform.tx, _fieldTransform.ty-_selfTransform.ty+self.transform.ty);
        
        _imageView1.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d,_imageView1Transform.tx-_selfTransform.tx+self.transform.tx, _imageView1Transform.ty-_selfTransform.ty+self.transform.ty);
        _imageView2.transform = CGAffineTransformMake(self.transform.d, -self.transform.c, self.transform.c, self.transform.d,_imageView2Transform.tx-_selfTransform.tx+self.transform.tx, _imageView2Transform.ty-_selfTransform.ty+self.transform.ty);
    };
}


@end
