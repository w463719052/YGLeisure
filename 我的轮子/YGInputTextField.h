//
//  YGInputTextField.h
//  我的轮子
//
//  Created by zccl2 on 16/10/17.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGSetPropertyInfo.h"
#import "YGStrokeTextView.h"

@interface YGInputTextField : UIView

@property (nonatomic,strong) YGStrokeTextView *textView;

@property (nonatomic,assign) BOOL isSetProperty;

@property (nonatomic,strong) YGSetPropertyInfo *info;

- (void)setTextFieldMessageWithInfo:(YGSetPropertyInfo *)info;
- (void)setViewBorderHide;

@end
