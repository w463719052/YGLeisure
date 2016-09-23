//
//  YGDrawingView.m
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import "YGDrawingView.h"
#import "YGHeader.h"
#import "YGDrawingLineView.h"

@implementation YGDrawingView

-(instancetype)init{
    if (self=[super init]) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.userInteractionEnabled = YES;
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth, ScreenWidth)];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = [UIImage imageNamed:@"phone"];
    [self addSubview:_imageView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.backgroundColor = [UIColor whiteColor];
    addButton.frame = CGRectMake(20, ScreenWidth+20, 60, 30);
    [addButton addTarget:self action:@selector(addLine) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
}

- (void)addLine {
    YGDrawingLineView *lineView = [[YGDrawingLineView alloc] init];
    [_imageView addSubview:lineView];
}

@end
