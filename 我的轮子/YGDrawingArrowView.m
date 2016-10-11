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
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    arrow.image = [UIImage imageNamed:@"jt"];
    [self addSubview:arrow];
    
    self.userInteractionEnabled = YES;
    [self addField];
}

- (void)addField {
    _field = [[UITextField alloc] initWithFrame:CGRectMake(40, -5, 140, 20)];
    _field.adjustsFontSizeToFitWidth = YES;
    NSMutableAttributedString *colorStr = [[NSMutableAttributedString alloc] initWithString:@"请输入标注内容"];
    [colorStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,colorStr.length)];
    _field.attributedPlaceholder = colorStr;
    _field.textColor = [UIColor redColor];
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
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_magnifierView removeFromSuperview];
}

- (void)solveTransformWithPoint:(CGPoint)point center:(CGPoint)center {
    CGFloat x1 = point.x - center.x;
    CGFloat y1 = point.y - center.y;
    self.transform = CGAffineTransformMake(self.transform.a, self.transform.b, self.transform.c, self.transform.d, x1+self.transform.tx, y1+self.transform.ty);
}
@end
