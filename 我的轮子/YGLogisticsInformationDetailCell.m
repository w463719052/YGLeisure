//
//  YGLogisticsInformationDetailCell.m
//  qpy
//
//  Created by zccl2 on 16/7/5.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import "YGLogisticsInformationDetailCell.h"
#import "YGHeader.h"
#import <CoreText/CoreText.h>

@implementation YGLogisticsInformationDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _topLayer = [[UIView alloc] initWithFrame:CGRectMake(20+9/2, 0, 1, 10)];
    _topLayer.backgroundColor = RGBCOLOR(233, 233, 233);
    [self addSubview:_topLayer];
    
    _circleView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 10, 10)];
    _circleView.layer.cornerRadius = 5;
    [self addSubview:_circleView];
    
    _testView = [[YGTextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_circleView.frame)+15, 10, ScreenWidth-20-10-15-20, 0)];
    [self addSubview:_testView];
    
    _myLayer = [[UIView alloc] init];
    _myLayer.backgroundColor = RGBCOLOR(233, 233, 233);
    [self addSubview:_myLayer];
}

- (void)addLayerViewWithHeight:(CGFloat)height {
    _myLayer.frame = CGRectMake(20+9/2, CGRectGetMaxY(_circleView.frame), 1, height+20-10-10);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
