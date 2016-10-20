//
//  YGMagnifierView.h
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGMagnifierView : UIView

@property (nonatomic,strong) UIView *viewToMagnify;
@property (nonatomic,assign) CGPoint touchPoint;

- (void)setPointToMagnify:(CGPoint)pointToMagnify;

@end
