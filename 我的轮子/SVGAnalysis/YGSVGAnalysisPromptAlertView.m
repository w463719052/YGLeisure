//
//  YGSVGAnalysisPromptAlertView.m
//  我的轮子
//
//  Created by qpy2 on 2017/12/18.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGSVGAnalysisPromptAlertView.h"
#import "YGHeader.h"

static const NSInteger Interval = 10;
static const NSInteger LblHeight = 30;

@implementation YGSVGAnalysisPromptAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _numberLbl = [[UILabel alloc] initWithFrame:CGRectMake(Interval, (2*LblHeight+Interval-LblHeight)/2, LblHeight, LblHeight)];
    _numberLbl.layer.cornerRadius = LblHeight/2;
    _numberLbl.layer.masksToBounds = YES;
    _numberLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _numberLbl.layer.borderWidth = 1;
    _numberLbl.font = [UIFont systemFontOfSize:10];
    _numberLbl.textColor = [UIColor darkGrayColor];
    _numberLbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberLbl];
    
    _picView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_numberLbl.frame)+Interval, Interval/2, 2*LblHeight, 2*LblHeight)];
    _picView.layer.cornerRadius = 5;
    [self addSubview:_picView];
    
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_picView.frame)+Interval, Interval/2, ScreenWidth-4*Interval-3*LblHeight, 2*LblHeight)];
    _messageLbl.font = [UIFont systemFontOfSize:13];
    _messageLbl.textColor = [UIColor darkGrayColor];
    _messageLbl.numberOfLines = 0;
    [self addSubview:_messageLbl];
    
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton.frame = CGRectMake(ScreenWidth-50, 0, 50, 50);
    [_cancleButton setTitle:@"X" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    _cancleButton.titleEdgeInsets = UIEdgeInsetsMake(5, 30, 30, 5);
    [_cancleButton addTarget:self action:@selector(cancleButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancleButton];
    _cancleButton.hidden = YES;
}

- (void)cancleButtonPress:(UIButton *)send {
    self.hidden = YES;
}

- (void)setContentViewInfo:(YGSVGAnalysisInfo *)info {
    _numberLbl.text = info.number;
    _picView.backgroundColor = GRAY_BGCOLOR;
    _messageLbl.text = @"发动机支座";
}

+ (CGFloat)viewHeigt {
    return Interval + 2*LblHeight;
}

@end
