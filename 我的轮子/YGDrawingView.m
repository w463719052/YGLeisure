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
#import "YGDrawingArrowView.h"

static NSInteger const Intrale = 10;
static NSInteger const ButtonWidth = 30;

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
    _imageView.layer.masksToBounds = YES;
    [self addSubview:_imageView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-ButtonWidth-Intrale, ScreenWidth, ButtonWidth+Intrale)];
    backView.backgroundColor = RGBCOLOR(243, 243, 243);
    [self addSubview:backView];
    
    NSArray *array = @[@"箭",@"线",@"孔",@"齿",@"电",@"二",@"LG"];
    for (int i=0; i<array.count; i++) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.tag = i;
        addButton.backgroundColor = [UIColor whiteColor];
        addButton.frame = CGRectMake(Intrale/2+i*(ButtonWidth+Intrale/2), Intrale/2, ButtonWidth, ButtonWidth);
        [addButton setTitle:array[i] forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(addLine:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:addButton];
    }
}

- (void)addLine:(UIButton *)send {
    if (send.tag == 0 || send.tag == 2 || send.tag == 3 || send.tag == 4) {
        YGDrawingArrowView *arrowView = [[YGDrawingArrowView alloc] init];
        [_imageView addSubview:arrowView];
    } else if (send.tag == 1) {
    YGDrawingLineView *lineView = [[YGDrawingLineView alloc] init];
    [_imageView addSubview:lineView];
    [lineView addField];
    } else if (send.tag == 5) {
        if (!_twoBarCodeView) {
            _twoBarCodeView = [[YGTwoBarCodeView alloc] initWithX:Intrale y:ScreenWidth-70-Intrale width:70 string:@"哈哈哈哈哈哈哈哈哈哈哈"];
            [_imageView addSubview:_twoBarCodeView];
        }
    } else if (send.tag == 6) {
        if (!_companyLogoView) {
            _companyLogoView = [[YGCompanyLogoView alloc] initWithFrame:CGRectMake(Intrale, ScreenWidth-70-Intrale, 70, 70) logo:@"logo"];
            [_imageView addSubview:_companyLogoView];
        }
    }
}

@end
