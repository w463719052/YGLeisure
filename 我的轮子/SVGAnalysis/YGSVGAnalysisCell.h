//
//  YGSVGAnalysisCell.h
//  我的轮子
//
//  Created by qpy2 on 2017/12/14.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGSVGAnalysisPromptAlertView.h"

@interface YGSVGAnalysisCell : UITableViewCell

@property (nonatomic,strong) YGSVGAnalysisPromptAlertView *promptAlertView;

- (void)setContentViewInfo:(YGSVGAnalysisInfo *)info;
+ (CGFloat)cellHeigt;

@end
