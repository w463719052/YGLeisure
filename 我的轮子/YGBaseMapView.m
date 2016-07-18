//
//  YGBaseMapView.m
//  我的轮子
//
//  Created by zccl2 on 16/7/15.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGBaseMapView.h"

static NSInteger const interval = 10;
static NSInteger const headPortraitWidth = 60;
static NSInteger const nameLblHeight = 30;

@implementation YGBaseMapView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    UIView *backView = [[UIView alloc] init];
    backView.translatesAutoresizingMaskIntoConstraints = NO;
    backView.backgroundColor = [UIColor whiteColor];
    backView.alpha = 0.6;
    backView.layer.cornerRadius = 5;
    [self addSubview:backView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    _headPortraitView = [[UIImageView alloc] initWithFrame:CGRectMake(interval*2, -headPortraitWidth/2, headPortraitWidth, headPortraitWidth)];
    _headPortraitView.backgroundColor = [UIColor whiteColor];
    _headPortraitView.layer.cornerRadius = headPortraitWidth/2;
    _headPortraitView.layer.masksToBounds = YES;
    _headPortraitView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_headPortraitView];
    _nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(interval, CGRectGetMaxY(_headPortraitView.frame)+interval, self.frame.size.width-2*interval, nameLblHeight)];
    _nameLbl.font = [UIFont boldSystemFontOfSize:20];
    [self addSubview:_nameLbl];
    _addressLbl = [[UILabel alloc] initWithFrame:CGRectMake(interval, CGRectGetMaxY(_nameLbl.frame)+interval, CGRectGetWidth(_nameLbl.frame), nameLblHeight)];
    _addressLbl.numberOfLines = 0;
    _addressLbl.adjustsFontSizeToFitWidth = YES;
    _addressLbl.font = [UIFont systemFontOfSize:12];
    [self addSubview:_addressLbl];
    
    UIView *spotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_headPortraitView.frame)-interval/2, -interval/2, interval/2, interval/2)];
    spotView.backgroundColor = [UIColor whiteColor];
    spotView.layer.cornerRadius = interval/4;
    spotView.layer.masksToBounds = YES;
    [_headPortraitView addSubview:spotView];

    CGRect boundingRect = CGRectMake(2.5, 2.5, headPortraitWidth-5, headPortraitWidth-5);
    CAKeyframeAnimation *myAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    myAnimation.duration = 3;
    myAnimation.repeatCount = INFINITY;
    myAnimation.path = CGPathCreateWithEllipseInRect(boundingRect, nil);
    myAnimation.calculationMode = kCAAnimationPaced;
    [spotView.layer addAnimation:myAnimation forKey:@"Move"];
    
    
}

- (void)setConteentViewImage:(NSString *)imageUrl name:(NSString *)name address:(NSString *)address {
    _headPortraitView.image = [UIImage imageNamed:imageUrl];
    _nameLbl.attributedText = [self setText:name];
    _addressLbl.attributedText = [self setText:address];;
}

- (NSMutableAttributedString *)setText:(NSString *)string {
    NSMutableAttributedString *attributedString =  [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSKernAttributeName : @(2.0f)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    return attributedString;
}

- (void)setContentViewFrame {
    _headPortraitView.frame = CGRectMake((self.frame.size.width-headPortraitWidth)/2, 30, headPortraitWidth, headPortraitWidth);
    _nameLbl.frame = CGRectMake(interval, CGRectGetMaxY(_headPortraitView.frame)+interval, self.frame.size.width-2*interval, nameLblHeight);
    _addressLbl.frame = CGRectMake(interval, CGRectGetMaxY(_nameLbl.frame)+interval, CGRectGetWidth(_nameLbl.frame), nameLblHeight);
    _nameLbl.textAlignment = NSTextAlignmentCenter;
    _addressLbl.textAlignment = NSTextAlignmentCenter;
}

- (void)setNewContentViewFrame {
    _headPortraitView.frame = CGRectMake(interval*2, -headPortraitWidth/2, headPortraitWidth, headPortraitWidth);
    _nameLbl.frame = CGRectMake(interval, CGRectGetMaxY(_headPortraitView.frame)+interval, self.frame.size.width-2*interval, nameLblHeight);
    _addressLbl.frame = CGRectMake(interval, CGRectGetMaxY(_nameLbl.frame)+interval, CGRectGetWidth(_nameLbl.frame), nameLblHeight);
    _nameLbl.textAlignment = NSTextAlignmentLeft;
    _addressLbl.textAlignment = NSTextAlignmentLeft;
}

@end
