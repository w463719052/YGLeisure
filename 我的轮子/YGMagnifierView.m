//
//  YGMagnifierView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGMagnifierView.h"

@implementation YGMagnifierView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        self.layer.borderWidth = 4;
        self.layer.cornerRadius = 40;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context,self.frame.size.width/2,self.frame.size.height/2);
    CGContextScaleCTM(context, 1.7, 1.7);
    CGContextTranslateCTM(context,-_touchPoint.x,-_touchPoint.y);
    [self.viewToMagnify.layer renderInContext:context];
}


@end
