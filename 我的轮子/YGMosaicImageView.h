//
//  YGMosaicImageView.h
//  我的轮子
//
//  Created by zccl2 on 16/9/13.
//  Copyright © 2016年 com.zccl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGMosaicImageInfo.h"

@interface YGMosaicImageView : UIView

@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel *titleLbl;
@property (nonatomic,strong) UILabel *mobileLbl;
@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *messageLbl;
@property (nonatomic,strong) UIImageView *twoCodeImageView;

- (void)setContentViewWithInfo:(YGMosaicImageInfo *)info;

- (void)savePhoto;

@end
