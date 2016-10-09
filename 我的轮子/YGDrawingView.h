//
//  YGDrawingView.h
//  我的轮子
//
//  Created by zccl2 on 16/9/23.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGTwoBarCodeView.h"
#import "YGCompanyLogoView.h"

@interface YGDrawingView : UIView

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) YGTwoBarCodeView *twoBarCodeView;
@property (nonatomic,strong) YGCompanyLogoView *companyLogoView;

@end
