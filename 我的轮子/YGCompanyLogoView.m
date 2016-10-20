//
//  YGCompanyLogoView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGCompanyLogoView.h"

@implementation YGCompanyLogoView

-(instancetype)initWithFrame:(CGRect)frame logo:(NSString *)logo{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:logo];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    //当前的point
    CGPoint currentP = [touch locationInView:self.superview];
    CGPoint previousP = [touch previousLocationInView:self.superview];
    self.transform = CGAffineTransformTranslate(self.transform, currentP.x-previousP.x, currentP.y-previousP.y);
}

@end
