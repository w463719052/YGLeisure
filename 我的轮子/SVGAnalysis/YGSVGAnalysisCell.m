//
//  YGSVGAnalysisCell.m
//  我的轮子
//
//  Created by qpy2 on 2017/12/14.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGSVGAnalysisCell.h"
#import "YGHeader.h"

static const NSInteger Interval = 10;
static const NSInteger LblHeight = 30;

@implementation YGSVGAnalysisCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    [self addSubview:_messageLbl];
}

- (void)setContentViewInfo:(YGSVGAnalysisInfo *)info {
    _numberLbl.text = info.number;
    _picView.backgroundColor = [UIColor lightGrayColor];
    _messageLbl.text = @"发动机支座";
    if (info.isSelect) {
//        _numberLbl.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2];
        _numberLbl.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0.8 alpha:0.8].CGColor;
        _numberLbl.textColor = [UIColor colorWithRed:0 green:0 blue:0.8 alpha:0.8];
        self.contentView.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.4];
    } else {
//        _numberLbl.backgroundColor = [UIColor clearColor];
        _numberLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _numberLbl.textColor = [UIColor darkGrayColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

+ (CGFloat)cellHeigt {
    return Interval + 2*LblHeight;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
