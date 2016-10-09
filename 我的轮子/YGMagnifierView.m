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
        self.frame = CGRectMake(0, 64, 80, 80);
        self.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        self.layer.borderWidth = 3;
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
