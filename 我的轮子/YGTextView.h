//
//  YGTextView.h
//  qpy
//
//  Created by zccl2 on 16/7/6.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGTextView : UIView

@property (nonatomic,strong) UIColor *color;

@property (nonatomic,assign) CGSize optimumSize;

- (void)setAttributedStringWithString:(NSString *)str;

- (CGSize)adaptiveDimension;

@end
