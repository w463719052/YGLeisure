//
//  UIScrollView+YGTouch.m
//  我的轮子
//
//  Created by qpy2 on 2017/12/13.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "UIScrollView+YGTouch.h"

@implementation UIScrollView (YGTouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

@end
