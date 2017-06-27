//
//  YGRollingAdView.h
//  qpy
//
//  Created by zccl2 on 16/12/7.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGRollingAdInfo.h"

@interface YGRollingAdView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIScrollView *mainPageTopScrollView;
@property (nonatomic,strong) NSArray *rollPictureArray;
@property (nonatomic,strong) UISegmentedControl *segment;

- (void)startTimer;
- (void)stopTimer;

@end
