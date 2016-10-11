//
//  YGDrawingLineView.h
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGMagnifierView.h"
#import "YGSetPropertyInfo.h"

@interface YGDrawingLineView : UIView

@property (nonatomic,strong) UITextField *field;
@property (nonatomic,strong) UITextField *field1;
@property (nonatomic,assign) CGPoint loaction;
@property (nonatomic,assign) CGPoint currentTouch;
@property (nonatomic,assign) CGSize currentSize;
@property (nonatomic) CGAffineTransform fieldTransform;
@property (nonatomic) CGAffineTransform selfTransform;

@property (nonatomic,strong) YGMagnifierView *magnifierView;

@property (nonatomic,strong) UIImageView *imageView1;
@property (nonatomic,strong) UIImageView *imageView2;
@property (nonatomic) CGAffineTransform imageView1Transform;
@property (nonatomic) CGAffineTransform imageView2Transform;

@property (nonatomic,strong) YGSetPropertyInfo *info;

- (void)addField;

- (void)deleteView;

- (void)setField1TextWithInfo:(YGSetPropertyInfo *)info;
@end
