//
//  YGSVGAnalysisCell.h
//  我的轮子
//
//  Created by qpy2 on 2017/12/14.
//  Copyright © 2017年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGSVGAnalysisInfo.h"

@interface YGSVGAnalysisCell : UITableViewCell

@property (nonatomic,strong) UILabel *numberLbl;
@property (nonatomic,strong) UIImageView *picView;
@property (nonatomic,strong) UILabel *messageLbl;


- (void)setContentViewInfo:(YGSVGAnalysisInfo *)info;
+ (CGFloat)cellHeigt;

@end
