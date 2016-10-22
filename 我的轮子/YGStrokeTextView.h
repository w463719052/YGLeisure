//
//  YGStrokeTextView.h
//  我的轮子
//
//  Created by zccl2 on 16/10/21.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGStrokeLabel.h"

@interface YGStrokeTextView : UIScrollView

@property (nonatomic,strong) YGStrokeLabel *strokeLabel;

@property (nonatomic,copy) NSString *text;

- (void)setStrokeLabelSizeToFit;

@end
