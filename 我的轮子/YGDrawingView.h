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
#import "YGSetPropertyView.h"

#define Intrale 10
#define ButtonWidth 35

@interface YGDrawingView : UIView<UITextFieldDelegate>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *pictureImageView;

@property (nonatomic,strong) YGTwoBarCodeView *twoBarCodeView;
@property (nonatomic,strong) YGCompanyLogoView *companyLogoView;

@property (nonatomic,strong) YGSetPropertyView *setPropertyView;

@end
