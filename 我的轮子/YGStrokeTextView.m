//
//  YGStrokeTextView.m
//  我的轮子
//
//  Created by zccl2 on 16/10/21.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGStrokeTextView.h"

@implementation YGStrokeTextView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.scrollEnabled = YES;
        self.userInteractionEnabled = YES;
        self.bouncesZoom = NO;
        _strokeLabel = [[YGStrokeLabel alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, frame.size.height)];
        _strokeLabel.numberOfLines = 0;
        _strokeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_strokeLabel];
    }
    return self;
}


- (void)setText:(NSString *)text {
    _strokeLabel.text = text;
    [self setStrokeLabelSizeToFit];
}

- (void)setStrokeLabelSizeToFit {
    CGSize size = [_strokeLabel sizeThatFits:self.frame.size];
    self.contentSize = CGSizeMake(size.width, size.height+10);
    
    _strokeLabel.frame = CGRectMake(0, 5, self.frame.size.width, self.frame.size.height+10);
    [_strokeLabel sizeToFit];
    if (self.contentSize.height>self.frame.size.height) {
        [self setContentOffset:CGPointMake(0, self.contentSize.height-self.frame.size.height) animated:NO];
    }
}

@end
