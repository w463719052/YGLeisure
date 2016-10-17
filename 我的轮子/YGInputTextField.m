//
//  YGInputTextField.m
//  我的轮子
//
//  Created by zccl2 on 16/10/17.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGInputTextField.h"

static NSInteger const Intrale = 10;
static NSInteger const Width = 100;
static NSInteger const Height = 20;

@implementation YGInputTextField

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(Intrale, Intrale, Width, Height);
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.cornerRadius = 3;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    //    self.layer.anchorPoint = CGPointMake(0, 0.5);
    //    self.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
    //    _field.transform = CGAffineTransformMake(-1, 0, 0, 1, 0, 0);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    CGPoint point = [touch locationInView:self];
    NSLog(@"%f",CGRectGetWidth(self.frame));
    NSLog(@"*******%f",point.x);
    if (CGRectGetWidth(self.frame)-point.x<40&&CGRectGetHeight(self.frame)-point.y<40) {
        CGRect frame = self.frame;
        frame.size.width += currentP.x-previousP.x;
        frame.size.height += currentP.y-previousP.y;
        self.frame = frame;
    } else {
       self.transform = CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
