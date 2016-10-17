//
//  YGDrawingArrowView.h
//  我的轮子
//
//  Created by zccl2 on 16/10/9.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGMagnifierView.h"
#import "YGSetPropertyInfo.h"

@interface YGDrawingArrowView : UIView

@property (nonatomic,strong) UIImageView *arrow;
@property (nonatomic,strong) UITextField *field;
@property (nonatomic,strong) YGMagnifierView *magnifierView;

- (void)setTextFieldMessageWithInfo:(YGSetPropertyInfo *)info;
@end
