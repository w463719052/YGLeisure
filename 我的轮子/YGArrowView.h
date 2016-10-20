//
//  YGArrowView.h
//  我的轮子
//
//  Created by zccl2 on 16/10/18.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGMagnifierView.h"

@interface YGArrowView : UIView

@property (nonatomic,assign) CGPoint loaction;
@property (nonatomic,assign) CGSize currentSize;
@property (nonatomic) CGAffineTransform selfTransform;

@property (nonatomic,strong) YGMagnifierView *magnifierView;

@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic) CGAffineTransform imageView1Transform;

- (void)addImageView;

- (void)deleteView;

@end
