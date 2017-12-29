//
//  YGSVGAnalysisCell.m
//  我的轮子
//
//  Created by qpy2 on 2017/12/14.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import "YGSVGAnalysisCell.h"
#import "YGHeader.h"

@implementation YGSVGAnalysisCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addContentView];
    }
    return self;
}

- (void)addContentView {
    _promptAlertView = [[YGSVGAnalysisPromptAlertView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [YGSVGAnalysisPromptAlertView viewHeigt])];
    [self addSubview:_promptAlertView];
}

- (void)setContentViewInfo:(YGSVGAnalysisInfo *)info {
    [_promptAlertView setContentViewInfo:info];
    if (info.isSelect) {
        self.contentView.backgroundColor = [UIColor colorWithRed:0.9 green:0 blue:0 alpha:0.2];
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
    }
}

+ (CGFloat)cellHeigt {
    return [YGSVGAnalysisPromptAlertView viewHeigt];
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
