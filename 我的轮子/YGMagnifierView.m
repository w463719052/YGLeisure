//
//  YGMagnifierView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGMagnifierView.h"

@implementation YGMagnifierView

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(10, 64+10, 100, 100);
        self.backgroundColor = [UIColor blackColor];
        self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        self.layer.borderWidth = 5;
        self.layer.cornerRadius = 50;
        self.layer.masksToBounds = YES;
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        self.layer.delegate = self;
    }
    return self;
}

- (void)setPointToMagnify:(CGPoint)pointToMagnify
{
    _touchPoint = pointToMagnify;
    [self.layer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    CGContextTranslateCTM(ctx, self.frame.size.width/2, self.frame.size.height/2);
    CGContextScaleCTM(ctx, 1.7, 1.7);
    CGContextTranslateCTM(ctx,-_touchPoint.x,-_touchPoint.y);
    [self.viewToMagnify.layer renderInContext:ctx];
}

@end
