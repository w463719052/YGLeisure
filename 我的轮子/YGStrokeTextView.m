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
        self.delegate = self;
        _strokeLabel = [[YGStrokeLabel alloc] initWithFrame:self.bounds];
        _strokeLabel.numberOfLines = 0;
        _strokeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_strokeLabel];
    }
    return self;
}

//- (void)setFrame:(CGRect)frame {
////    [self setStrokeLabelSizeToFit];
//}

- (void)setText:(NSString *)text {
    _strokeLabel.text = text;
    [self setStrokeLabelSizeToFit];
}

- (void)setStrokeLabelSizeToFit {
    CGSize size = [_strokeLabel sizeThatFits:self.frame.size];
    self.contentSize = size;
    _strokeLabel.frame = self.frame;
    [_strokeLabel sizeToFit];
    [self scrollRectToVisible:CGRectMake(20, 200, 100, 200) animated:YES];
    NSLog(@"%f,%f",size.width,size.height);
}

@end
