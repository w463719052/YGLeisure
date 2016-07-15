//
//  YGLogisticsInformationDetailCell.h
//  qpy
//
//  Created by zccl2 on 16/7/5.
//  Copyright © 2016年 dcf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGTextView.h"

@interface YGLogisticsInformationDetailCell : UITableViewCell

@property (nonatomic,strong) UIView *topLayer;

@property (nonatomic,strong) UIView *circleView;

@property (nonatomic,strong) YGTextView *testView;

@property (nonatomic,strong) UIView *myLayer;

- (void)addLayerViewWithHeight:(CGFloat)height;

@end
