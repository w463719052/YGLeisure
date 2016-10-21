//
//  YGStrokeLabel.m
//  我的轮子
//
//  Created by zccl2 on 16/10/21.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGStrokeLabel.h"

@implementation YGStrokeLabel


- (void)drawTextInRect:(CGRect)rect {
    UIColor *textColor = self.textColor;
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    self.textColor = [UIColor whiteColor];
    [super drawTextInRect:rect];
    CGContextSetTextDrawingMode(c, kCGTextFill);
    self.textColor = textColor;
    [super drawTextInRect:rect];
}  


@end
