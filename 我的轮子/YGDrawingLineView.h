//
//  YGDrawingLineView.h
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGMagnifierView.h"

@interface YGDrawingLineView : UILabel

@property (nonatomic,strong) UITextField *field;
@property (nonatomic,assign) CGPoint loaction;
@property (nonatomic,assign) CGSize currentSize;
@property (nonatomic) CGAffineTransform fieldTransform;
@property (nonatomic) CGAffineTransform selfTransform;

@property (nonatomic,strong) YGMagnifierView *magnifierView;

- (void)addField;

@end
